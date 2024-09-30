#!/usr/bin/env python3

import base64
import hashlib
import json
import pathlib
import re
import subprocess
import tarfile
import tempfile
import shutil
import sys
import urllib.parse

# Config
BCR_REPO = 'bazelbuild/bazel-central-registry'
BCR_STAGING_REPO = 'rules-proto-grpc/bazel-central-registry'
CORE_MODULE_NAME = 'rules_proto_grpc'
HOMEPAGE = 'https://rules-proto-grpc.com'
MAINTAINER_EMAIL = 'adam@rules-proto-grpc.com'
MAINTAINER_NAME = 'Adam Liddell'
MAINTAINER_GH_USER = 'aaliddell'
SOURCE_REPO = 'rules-proto-grpc/rules_proto_grpc'
VERSION = input('Version number: ').strip()
VERSION_PLACEHOLDER = '0.0.0.rpg.version.placeholder'


# Sanity check
if not re.fullmatch(r"^([a-zA-Z0-9.]+)(?:-([a-zA-Z0-9.-]+))?(?:\+[a-zA-Z0-9.-]+)?$", VERSION):
    print('Version is not valid')
    sys.exit(1)

branch = subprocess.run(
    ['git', 'rev-parse', '--abbrev-ref', 'HEAD'], check=True, capture_output=True
).stdout.strip().decode()
if branch != 'master':
    print('Current branch is not master')
    sys.exit(2)

existing_tags = subprocess.run(
    ['git', 'tag', '--list'], check=True, capture_output=True
).stdout.strip().decode().split('\n')
if VERSION in existing_tags:
    print('Version conflicts with an existing tag')
    sys.exit(3)


# Work under a temp directory
with tempfile.TemporaryDirectory() as tmp_dir:
    tmp_dir = pathlib.Path(tmp_dir)
    print(f'Working under temporary directory: {tmp_dir}')

    # Checkout clean copy under tmp dir
    code_dir = tmp_dir / 'checkout'
    print(f'Checking out code under: {code_dir}')
    subprocess.run(['git', 'checkout-index', '--all', '--prefix', f'{code_dir}/'], check=True)

    # Patch version identifier on modules
    # This is hilariously inefficient but whatever...
    version_bytes = VERSION.encode()
    version_placeholder_bytes = VERSION_PLACEHOLDER.encode()
    for dir_path, dir_names, file_names in (code_dir / 'modules').walk():
        for file_name in file_names:
            file_path = dir_path / file_name
            file_data = file_path.read_bytes()
            if version_placeholder_bytes in file_data:
                file_path.write_bytes(file_data.replace(version_placeholder_bytes, version_bytes))
                print(f'Patching version in {dir_path / file_name}')

    # Find modules
    modules = {
        (
            # Core module is not suffixed with _core
            (CORE_MODULE_NAME + '_' + path.name)
            if path.name != 'core' else CORE_MODULE_NAME
        ): path
        for path in (code_dir / 'modules').glob('*')
        if path.name != 'example_protos'  # Don't publish internal examples as module
    }

    # Build assets
    def _filter_tar_info(tar_info: tarfile.TarInfo) -> tarfile.TarInfo:
        """Strip local info from tar records."""
        tar_info.mtime = 0
        tar_info.uid = 0
        tar_info.gid = 0
        tar_info.uname = 'root'
        tar_info.gname = 'root'
        return tar_info

    tmp_dist_dir = tmp_dir / 'dist'
    tmp_dist_dir.mkdir()
    module_dist_paths = {}
    module_dist_hashes = {}
    for module_name, module_path in modules.items():
        module_dist_path = tmp_dist_dir / f'{module_name}-{VERSION}.tar.gz'
        print(f'Bundling module {module_name} ({module_path}) to {module_dist_path}')
        with tarfile.open(module_dist_path, 'x:gz', compresslevel=9, dereference=True) as tar_file:
            tar_file.add(module_path, f'{module_name}-{VERSION}', filter=_filter_tar_info)

        module_dist_paths[module_name] = module_dist_path
        module_dist_hashes[module_name] = base64.b64encode(
            hashlib.sha256(module_dist_path.read_bytes()).digest()
        ).decode()

    # Copy assets
    dist_dir = pathlib.Path('.') / 'dist' / str(VERSION)
    dist_dir.mkdir(parents=True, exist_ok=True)
    for module_name, module_dist_path in module_dist_paths.items():
        print(f'Copying module dist to {dist_dir / module_dist_path.name}')
        shutil.copy(module_dist_path, dist_dir / module_dist_path.name)

    # Clone and update BCR repo, then create new branch
    bcr_dir = tmp_dir / 'bcr'
    bcr_branch_name = f'release/{VERSION}'
    subprocess.run(['git', 'clone', f'https://github.com/{BCR_REPO}.git', str(bcr_dir)], check=True)
    subprocess.run(['git', 'switch', '--create', bcr_branch_name], cwd=bcr_dir, check=True)

    # Update BCR modules
    for module_name, module_path in modules.items():
        # Update module level files
        bcr_mod_dir = bcr_dir / 'modules' / module_name
        bcr_mod_dir.mkdir(exist_ok=True)

        bcr_metadata_path = bcr_mod_dir / 'metadata.json'
        bcr_metadata = {}
        if bcr_metadata_path.exists():
            bcr_metadata = json.loads(bcr_metadata_path.read_bytes())
        
        bcr_metadata.update({
            'homepage': HOMEPAGE,
            'maintainers': [{
                'email': MAINTAINER_EMAIL,
                'github': MAINTAINER_GH_USER,
                'name': MAINTAINER_NAME,
            }],
            'repository': [
                f'github:{SOURCE_REPO}',
            ],
            'yanked_versions': {},
        })
        bcr_metadata.setdefault('versions', [])
        bcr_metadata['versions'].append(VERSION)

        bcr_metadata_path.write_text(json.dumps(bcr_metadata, indent=4) + '\n')

        # Create module version level files
        bcr_mod_version_dir = bcr_mod_dir / VERSION
        bcr_mod_version_dir.mkdir(exist_ok=False)

        shutil.copy(module_path / 'MODULE.bazel', bcr_mod_version_dir / 'MODULE.bazel')
        (bcr_mod_version_dir / 'source.json').write_text(json.dumps({
            'integrity': f'sha256-{module_dist_hashes[module_name]}',
            'strip_prefix': f'{module_name}-{VERSION}',
            'url': f'https://github.com/{SOURCE_REPO}/releases/download/{VERSION}/{module_name}-{VERSION}.tar.gz',
            'patches': {},
            'patch_strip': 0,
        }, indent=4) + '\n')

        (bcr_mod_version_dir / 'presubmit.yml').write_text(f"""matrix:
  platform:
    - debian10
    - ubuntu2004
    - macos
    - windows
  bazel:
    - 6.x
    - 7.x
tasks:
  verify_targets:
    name: Verify build targets
    platform: ${{{{ platform }}}}
    bazel: ${{{{ bazel }}}}
    build_targets:
    - '@{module_name}//...'
""")

    # Stage and commit
    commit_title = f'{CORE_MODULE_NAME}@{VERSION}'
    subprocess.run(['git', 'add', '--all'], cwd=bcr_dir, check=True)
    subprocess.run([
        'git', 'commit',
        '--message', commit_title,
    ], cwd=bcr_dir, check=True, env={
        'GIT_AUTHOR_NAME': MAINTAINER_NAME,
        'GIT_AUTHOR_EMAIL': MAINTAINER_EMAIL,
        'GIT_COMMITTER_NAME': MAINTAINER_NAME,
        'GIT_COMMITTER_EMAIL': MAINTAINER_EMAIL,
    })

    # Push BCR branch
    subprocess.run([
        'git', 'push', '--force', f'git@github.com:{BCR_STAGING_REPO}.git',
        f'{bcr_branch_name}:{bcr_branch_name}',
    ], cwd=bcr_dir, check=True)

pr_body = f'''Release: https://github.com/{SOURCE_REPO}/releases/tag/{VERSION}
'''
print(f"""
Next steps:
- Tag the release with: git tag {VERSION}
- Push tag to GH: git push --tags
- Create a release at https://github.com/{SOURCE_REPO}/releases/new?tag={urllib.parse.quote_plus(VERSION)}&title={urllib.parse.quote_plus(VERSION)}
- Attach the files in {dist_dir.absolute()} to the release
- Create a PR on BCR at https://github.com/{BCR_REPO}/compare/main...{BCR_STAGING_REPO.replace('/', ':')}:{bcr_branch_name}?quick_pull=1&title={urllib.parse.quote_plus(commit_title)}&body={urllib.parse.quote_plus(pr_body)}

""")
