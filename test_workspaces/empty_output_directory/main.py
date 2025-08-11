# Check generated files are as expected
import os
import pathlib
import sys

expected = set()

if os.name == 'nt':
    expected = set([p.replace('/', '\\') for p in expected])

files = set([str(p) for p in pathlib.Path('dir_lib').glob('**/*') if p.is_file()])

if files != expected:
    print('Files found do not match expected')
    print('Found {}'.format(files))
    print('Expected {}'.format(expected))
    sys.exit(1)
