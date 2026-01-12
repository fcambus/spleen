#
# Spleen 2.1.0
# Copyright (c) 2018-2026, Frederic Cambus
# https://www.cambus.net/
#
# Created:      2019-01-29
# Last Updated: 2026-01-12
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
PYFTSUBSET ?=	pyftsubset

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

PCFS =		$(SIZES:%=spleen-%.pcf)
PSFS =		$(SIZES:%=spleen-%.psfu)
FONS =		$(SIZES:%=spleen-%.fon)
OTBS =		$(SIZES:%=spleen-%.otb)

SFDS =		$(OTFSIZES:%=spleen-%.sfd)
OTFS =		$(OTFSIZES:%=spleen-%.otf)

WOFFS =		$(OTFSIZES:%=spleen-%.woff)
WOFF2S =	$(OTFSIZES:%=spleen-%.woff2)

PNGS =		$(SIZES:%=spleen-%.png)

all: com pcf psf fon otb sfd otf woff woff2

com:
	$(MAKE) -C dos

pcf:	$(PCFS)
psf:	$(PSFS)
fon:	$(FONS)
otb:	$(OTBS)
sfd:	$(SFDS)
otf:	$(OTFS)
woff:	$(WOFFS)
woff2:	$(WOFF2S)

.SUFFIXES: .bdf .pcf .psfu .fon .otb .sfd .otf .woff .woff2 .png

.bdf.pcf:
	$(BDFTOPCF) -t -o $@ $<

.bdf.psfu:
	$(BDF2PSF) --fb $< $(OPTIONS) $@

.bdf.fon:
	$(FONTFORGE) -lang ff -c 'Open("$<"); Generate("$@")'

.bdf.otb:
	$(FONTTOSFNT) -b -c -o $@ $<

.bdf.sfd:
	size=`echo "$@" | sed -e 's/^spleen-//' -e 's/\.sfd$$//'`; \
	$(BDF2SFD) -f "Spleen $$size" -p "Spleen$$size" $< > $@; \
	$(FONTFORGE) -lang ff -c 'Open("$@"); SelectAll(); RemoveOverlap(); Simplify(-1,1); Save("$@")'

.sfd.otf:
	$(FONTFORGE) -lang ff -c 'Open("$<"); Generate("$@")'

.otf.woff:
	$(PYFTSUBSET) $< \
		--output-file=$@ \
		--flavor=woff \
		--layout-features='*' \
		--glyphs='*' \
		--drop-tables+=FFTM \
		--with-zopfli

.otf.woff2:
	$(PYFTSUBSET) $< \
		--output-file=$@ \
		--flavor=woff2 \
		--layout-features='*' \
		--glyphs='*' \
		--drop-tables+=FFTM

.bdf.png:
	awk 'BEGIN { for (c = 32; c < 127; c++) printf "%c", c }' | \
	$(PBMTEXT) -font $< -nomargins | \
	$(PPMCHANGE) black "#aaa" | \
	$(PPMCHANGE) white black | \
	$(PNMTOPNG) > $@

screenshots: $(PNGS)
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
	$(PPMCHANGE) black "#fff" > digits.pnm

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
	rm -f *.bak *.dfont *.fon *.gz *.sfd *.otb *.otf *.pcf *.psfu *.woff *.woff2 spleen*.png
