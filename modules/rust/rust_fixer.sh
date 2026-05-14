#!/usr/bin/env bash

set -euo pipefail

cp -R "$1"/. "$2"/
chmod -R +w "$2"

find "$2" -type f ! -name 'mod.rs' ! -name '*.serde.rs' ! -name '*.tonic.rs' | while read -r base; do
    dir="$(dirname "$base")"
    module="$(basename "${base%.rs}")"
    for generated in "$dir/$module".serde.rs "$dir/$module".tonic.rs; do
        if [[ -f "$generated" ]]; then
            echo "include!(\"$(basename "$generated")\");" >> "$base"
        fi
    done
done
