#!/bin/sh
# KEYWORD: firstboot

gpart recover vtbd0
gpart resize -i 2 vtbd0
zpool online -e zroot /dev/vtbd0p2
