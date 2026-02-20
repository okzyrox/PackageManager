#!/usr/bin/env bash

set -euo pipefail

## Path stuff
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

## Version
VERSION=$(grep 'REPACKAGE_VERSION =' "$PROJECT_ROOT/src/Version.luau" | awk -F'"' '{print $2}')

echo $VERSION