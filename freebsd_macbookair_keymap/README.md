## HOW DO?
Place `macbookair` in `/usr/local/share/X11/xkb/symbols/`

Place `keyboard-us-mac-air.conf` in `/usr/local/etc/X11/xorg.conf.d/`

## WHY?
Because for some reason the 2015 Macbook Air has the LSGT and TLDE keys swapped in hardware. 
This fixes that in the layout, and overlays the existing `us(mac)` and `us(basic)` layouts in FreeBSD.