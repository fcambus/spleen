#
# Spleen 1.0.4
# Copyright (c) 2018-2019, Frederic Cambus
# https://www.cambus.net/
#
# Created:      2019-01-29
# Last Updated: 2019-02-08
#
# Spleen is released under the BSD 2-Clause license.
# See LICENSE file for details.
#

BDFTOPCF ?=	bdftopcf
BDF2PSF ?=	bdf2psf
UFOND ?=	ufond

PREFIX ?=	/usr/local
DATADIR ?=	$(PREFIX)/share/bdf2psf

EQUIVALENT =	$(DATADIR)/standard.equivalents
FONTSET =	$(DATADIR)/fontsets/Uni1.512

OPTIONS =	$(EQUIVALENT) $(FONTSET) 512

SIZES =		5x8 8x16 12x24 16x32 32x64

TARGET =	all

all:	pcf psf dfont

pcf:
.for size in $(SIZES)
	$(BDFTOPCF) -t -o spleen-${size}.pcf spleen-${size}.bdf
.endfor

psf:
.for size in $(SIZES)
	$(BDF2PSF) --fb spleen-${size}.bdf $(OPTIONS) spleen-${size}.psfu
.endfor

dfont:
	$(UFOND) -dfont *.bdf
	mv Spleen.fam.dfont spleen.dfont
