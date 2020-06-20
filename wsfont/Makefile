#
# Spleen 1.7.0
# Copyright (c) 2018-2020, Frederic Cambus
# https://www.cambus.net/
#
# Created:      2020-06-20
# Last Updated: 2020-06-20
#
# Spleen is released under the BSD 2-Clause license.
# See LICENSE file for details.
#

SIZES =		5x8 8x16 12x24 16x32 32x64

all:
.for size in $(SIZES)
	$(CC) $(CFLAGS) spleen${size}.c -o spleen${size}
	spleen${size} > spleen-${size}
	spleen${size} | uuencode spleen-${size} > spleen-${size}.uue
.endfor

clean:
.for size in $(SIZES)
	rm -f spleen${size} spleen-${size} *.uue
.endfor
