#
# Spleen 1.8.0
# Copyright (c) 2018-2020, Frederic Cambus
# https://www.cambus.net/
#
# Created:      2020-06-20
# Last Updated: 2020-06-25
#
# Spleen is released under the BSD 2-Clause license.
# See LICENSE file for details.
#

SIZES =		5x8 8x16 12x24 16x32 32x64

all:
.for size in $(SIZES)
	$(CC) $(CFLAGS) spleen-${size}.c -o spleen-${size}
	spleen-${size} > spleen-${size}.fnt
	spleen-${size} | uuencode spleen-${size}.fnt > spleen-${size}.fnt.uue
.endfor

clean:
.for size in $(SIZES)
	rm -f spleen-${size} *.fnt *.uue
.endfor
