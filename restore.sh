#!/bin/bash
# Restore the Manu o te nūnaʻa workspace exactly where the build scripts expect it.
# Usage: unzip the kit, then:  bash restore.sh
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
cp -r "$HERE/fs/tmp/." /tmp/
mkdir -p /home/claude && cp -r "$HERE/fs/home/claude/." /home/claude/
# fonts for the promo/video scripts (Bricolage Grotesque + Figtree)
( cd /tmp/promo && npm install --silent @fontsource/bricolage-grotesque @fontsource/figtree >/dev/null 2>&1 || echo "npm install of fonts failed (only needed for promo videos)" )
cd /home/claude/motu-nui && python3 build.py && node --check /tmp/g.js && echo "BUILD OK"
node /tmp/validate.js | tail -1
