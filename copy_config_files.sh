#! /bin/sh

_cwd="$(pwd)"

rsync -vr ~/.config/ $_cwd/config-files/
