#! /bin/sh

_cwd="$(pwd)"

rsync -vr --exclude-from=exclude-config-files.txt ~/.config/ $_cwd/config-files/
