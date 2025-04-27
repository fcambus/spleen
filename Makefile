#
# Spleen 2.1.0
# Copyright (c) 2018-2024, Frederic Cambus
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

TARGET =	all

all:	com pcf psf fon otb sfd otf

com:
	$(MAKE) -C dos

%.pcf: %.bdf
        $(BDFTOPCF) -t -o $< $@

pcf: $(addprefix spleen-,$(SIZES:=.pcf))

%.psfu: %.bdf
        $(BDF2PSF) --fb $< $(OPTIONS) $@ 2>1 | grep -Ev "^WARNING: "

# No PSF-based console supports 32x64 bitmap fonts, so filter that size out
psf: $(addprefix spleen-,$(filter-out 32x64.%,$(SIZES:=.psfu)))

%.fon: %.bdf
        $(FONTFORGE) -lang ff -c 'Open("$<"); Generate("$@")'

fon: $(addprefix spleen-,$(SIZES:=.fon))

%.otb: %.bdf
        $(FONTTOSFNT) -b -c -o %@ %<

otb: $(addprefix spleen-,$(SIZES:=.otb))

%.sfd: %.bdf
        $(eval SIZE := $(subst .bdf,,$(subst spleen-,,$<)))
        $(BDF2SFD) -f "Spleen $(SIZE)" -p "Spleen$(SIZE)" %< > %@
        $(FONTFORGE) -lang ff -c 'Open("$@"); SelectAll(); RemoveOverlap(); Simplify(-1, 1); Save("%@")'

sfd: $(addprefix spleen-,$(SIZES:=.sfd))

%.otf: %.sfd
        $(eval SIZE := $(subst .sfd,,$(subst spleen-,,$<)))
        $(FONTFORGE) -lang ff -c 'Open("spleen-$(SIZE).sfd"); Generate("spleen-$(SIZE).otf")'

# Filter out 5x8 as it's a different aspect ratio to the other font sizes
otf: $(addprefix spleen-,$(filter-out 5x8.%,$(SIZES:=.otf)))

%.png: %.bdf
        awk 'BEGIN { for(chr = 32; chr < 127; chr++) printf "%c", chr }' | \
        $(PBMTEXT) -font %< -nomargins | \
        $(PPMCHANGE) black "#aaa" | \
        $(PPMCHANGE) white black | \
        $(PNMTOPNG) > %@
        $(OXIPNG) -o max %@

screenshots: $(addprefix spleen-,$(SIZES:=.png))

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
        $(RM) spleen.pnm examples.pnm future.pnm letters.pnm digits.pnm

        printf "a" | \
        $(PBMTEXT) -font spleen-32x64.bdf -nomargins | \
        $(PPMCHANGE) white "#ff7f2a" | \
        $(PPMCHANGE) black "#fff" | \
        $(PNMSCALE) 4 | \
        $(PNMPASTE) - 364 100 specimen.pnm | \
        $(PNMTOPNG) > specimen.png

        $(RM) specimen.pnm
        $(OXIPNG) -o max specimen.png

clean:
        $(RM) *.bak *.dfont *.fon *.gz *.sfd *.otb *.otf *.pcf *.psfu spleen*.png
