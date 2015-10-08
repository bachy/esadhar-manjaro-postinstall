#! /bin/sh

_cwd="$(pwd)"

rsync -vr --exclude-from=exclude-config-files.txt /home/$USER/.config/ $_cwd/config-files/
