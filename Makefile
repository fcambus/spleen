#
# Spleen 2.0.2
# Copyright (c) 2018-2023, Frederic Cambus
# https://www.cambus.net/
#
# Created:      2019-01-29
# Last Updated: 2023-10-06
#
# Spleen is released under the BSD 2-Clause license.
# See LICENSE file for details.
#
# SPDX-License-Identifier: BSD-2-Clause
#

BDFTOPCF ?=	bdftopcf
BDF2PSF ?=	bdf2psf
BDF2SFD ?=	bdf2sfd
FONTFORGE ?=	fontforge
OXIPNG ?=	oxipng
FONTTOSFNT ?=	fonttosfnt

PBMTEXT ?=	pbmtext
PPMCHANGE ?=	ppmchange
PNMCAT ?=	pnmcat
PNMPASTE ?=	pnmpaste
PNMSCALE ?=	pnmscale
PNMTOPNG ?=	pnmtopng

PREFIX ?=	/usr
DATADIR ?=	$(PREFIX)/share/bdf2psf

EQUIVALENT =	$(DATADIR)/standard.equivalents

ASCII =		$(DATADIR)/ascii.set
LINUX =		$(DATADIR)/linux.set
USEFUL =	$(DATADIR)/useful.set
FONTSET =	$(DATADIR)/fontsets/Uni1.512+:$(ASCII)+:$(LINUX)+:$(USEFUL)

OPTIONS =	$(EQUIVALENT) $(FONTSET) 512

SIZES =		5x8 6x12 8x16 12x24 16x32 32x64
OTFSIZES =	6x12 8x16 12x24 16x32 32x64

TARGET =	all

all:	com pcf psf fon otb sfd otf

com:
	$(MAKE) -C dos

pcf:
.for size in $(SIZES)
	$(BDFTOPCF) -t -o spleen-${size}.pcf spleen-${size}.bdf
.endfor

psf:
.for size in $(SIZES)
	$(BDF2PSF) --fb spleen-${size}.bdf $(OPTIONS) spleen-${size}.psfu
.endfor

fon:
.for size in $(SIZES)
	$(FONTFORGE) -lang ff -c 'Open("spleen-${size}.bdf"); Generate("spleen-${size}.fon")'
.endfor

otb:
.for size in $(SIZES)
	$(FONTTOSFNT) -b -c -o spleen-${size}.otb spleen-${size}.bdf
.endfor

sfd:
.for size in $(OTFSIZES)
	$(BDF2SFD) -f "Spleen ${size}" -p "Spleen${size}" spleen-${size}.bdf > spleen-${size}.sfd
	$(FONTFORGE) -lang ff -c 'Open("spleen-${size}.sfd"); SelectAll(); RemoveOverlap(); Simplify(-1, 1); Save("spleen-${size}.sfd")'
.endfor

otf:
.for size in $(OTFSIZES)
	$(FONTFORGE) -lang ff -c 'Open("spleen-${size}.sfd"); Generate("spleen-${size}.otf")'
.endfor

screenshots:
.for size in $(SIZES)
	awk 'BEGIN { for(chr = 32; chr < 127; chr++) printf "%c", chr }' | \
	$(PBMTEXT) -font spleen-${size}.bdf -nomargins | \
	$(PPMCHANGE) black "#aaa" | \
	$(PPMCHANGE) white black | \
	$(PNMTOPNG) > spleen-${size}.png
.endfor
	$(OXIPNG) -o max *.png

specimen:
	printf "\n  Spleen         " | \
	$(PBMTEXT) -font spleen-32x64.bdf -nomargins | \
	$(PPMCHANGE) white "#ff7f2a" | \
	$(PPMCHANGE) black "#fff" > spleen.pnm

	printf "\n  Aa Ee Gg       \n  Qq Rr Ss" | \
	$(PBMTEXT) -font spleen-32x64.bdf -nomargins | \
	$(PPMCHANGE) white "#ff7f2a" > examples.pnm

	printf "\n     The future  " | \
	$(PBMTEXT) -font spleen-32x64.bdf -nomargins | \
	$(PPMCHANGE) white "#ff7f2a" | \
	$(PPMCHANGE) black "#fff" > future.pnm

	printf "  abcdefghijklm  \n  nopqrstuvwxyz" | \
	$(PBMTEXT) -font spleen-32x64.bdf -nomargins | \
	$(PPMCHANGE) white "#ff2a7f" > letters.pnm

	printf "     0123456789  " | \
	$(PBMTEXT) -font spleen-32x64.bdf -nomargins | \
	$(PPMCHANGE) white "#ff2a7f" | \
	$(PPMCHANGE) black "#fff"  > digits.pnm

	$(PNMCAT) -tb spleen.pnm examples.pnm future.pnm letters.pnm digits.pnm > specimen.pnm

	printf "a" | \
	$(PBMTEXT) -font spleen-32x64.bdf -nomargins | \
	$(PPMCHANGE) white "#ff7f2a" | \
	$(PPMCHANGE) black "#fff" | \
	$(PNMSCALE) 4 | \
	$(PNMPASTE) - 364 100 specimen.pnm | \
	$(PNMTOPNG) > specimen.png
	rm *.pnm
	$(OXIPNG) -o max *.png

clean:
	rm -f *.bak *.dfont *.fon *.gz *.sfd *.otb *.otf *.pcf *.psfu spleen*.png
