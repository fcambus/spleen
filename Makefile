#
# Spleen 1.1.0
# Copyright (c) 2018-2019, Frederic Cambus
# https://www.cambus.net/
#
# Created:      2019-01-29
# Last Updated: 2019-09-04
#
# Spleen is released under the BSD 2-Clause license.
# See LICENSE file for details.
#

BDFTOPCF ?=	bdftopcf
BDF2PSF ?=	bdf2psf

PREFIX ?=	/usr/local
DATADIR ?=	$(PREFIX)/share/bdf2psf

EQUIVALENT =	$(DATADIR)/standard.equivalents
FONTSET =	$(DATADIR)/fontsets/Uni1.512

OPTIONS =	$(EQUIVALENT) $(FONTSET) 512

SIZES =		5x8 8x16 12x24 16x32 32x64

TARGET =	all

all:	pcf psf

pcf:
.for size in $(SIZES)
	$(BDFTOPCF) -t -o spleen-${size}.pcf spleen-${size}.bdf
.endfor

psf:
.for size in $(SIZES)
	$(BDF2PSF) --fb spleen-${size}.bdf $(OPTIONS) spleen-${size}.psfu
.endfor

screenshots:
.for size in $(SIZES)
	awk 'BEGIN { for(chr = 32; chr < 127; chr++) printf "%c", chr }' | \
	pbmtext -font spleen-${size}.bdf -nomargins | \
	ppmchange black "#aaa" | \
	ppmchange white black | \
	pnmtopng > spleen-${size}.png
.endfor
	optipng *.png

specimen:
	echo "\n  Spleen         " | \
	pbmtext -font spleen-32x64.bdf -nomargins | \
	ppmchange white "#ff7f2a" | \
	ppmchange black "#fff" > spleen.pnm

	echo "\n  Aa Ee Gg       \n  Qq Rr Ss" | \
	pbmtext -font spleen-32x64.bdf -nomargins | \
	ppmchange white "#ff7f2a" > examples.pnm

	echo "\n     The future  " | \
	pbmtext -font spleen-32x64.bdf -nomargins | \
	ppmchange white "#ff7f2a" | \
	ppmchange black "#fff" > future.pnm

	echo "  abcdefghijklm  \n  nopqrstuvwxyz" | \
	pbmtext -font spleen-32x64.bdf -nomargins | \
	ppmchange white "#ff2a7f" > letters.pnm

	echo "     0123456789  " | \
	pbmtext -font spleen-32x64.bdf -nomargins | \
	ppmchange white "#ff2a7f" | \
	ppmchange black "#fff"  > digits.pnm

	pnmcat -tb spleen.pnm examples.pnm future.pnm letters.pnm digits.pnm > specimen.pnm

	echo "a" | \
	pbmtext -font spleen-32x64.bdf -nomargins | \
	ppmchange white "#ff7f2a" | \
	ppmchange black "#fff" | \
	pnmscale 4 | \
	pnmpaste - 364 100 specimen.pnm | \
	pnmtopng > specimen.png
	rm *.pnm
	optipng *.png

clean:
	rm -f *.pcf *.psfu *.dfont *.png
