#
# Spleen 1.0.3
# Copyright (c) 2018-2019, Frederic Cambus
# https://www.cambus.net/
#
# Created:      2019-01-29
# Last Updated: 2019-02-06
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

TARGET =	all

all:	pcf psf dfont

pcf:
	$(BDFTOPCF) -t -o spleen-5x8.pcf spleen-5x8.bdf
	$(BDFTOPCF) -t -o spleen-8x16.pcf spleen-8x16.bdf
	$(BDFTOPCF) -t -o spleen-12x24.pcf spleen-12x24.bdf
	$(BDFTOPCF) -t -o spleen-16x32.pcf spleen-16x32.bdf
	$(BDFTOPCF) -t -o spleen-32x64.pcf spleen-32x64.bdf

psf:
	$(BDF2PSF) --fb spleen-5x8.bdf $(OPTIONS) spleen-5x8.psfu
	$(BDF2PSF) --fb spleen-8x16.bdf $(OPTIONS) spleen-8x16.psfu
	$(BDF2PSF) --fb spleen-12x24.bdf $(OPTIONS) spleen-12x24.psfu
	$(BDF2PSF) --fb spleen-16x32.bdf $(OPTIONS) spleen-16x32.psfu
	$(BDF2PSF) --fb spleen-32x64.bdf $(OPTIONS) spleen-32x64.psfu

dfont:
	$(UFOND) -dfont *.bdf
	mv Spleen.fam.dfont spleen.dfont
