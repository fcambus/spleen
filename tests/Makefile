#
# Spleen 2.1.0
# Copyright (c) 2018-2026, Frederic Cambus
# https://www.cambus.net/
#
# Created:      2026-01-30
# Last Updated: 2026-01-30
#
# Spleen is released under the BSD 2-Clause license.
# See LICENSE file for details.
#
# SPDX-License-Identifier: BSD-2-Clause
#

OTS ?=	ots-sanitize
TTX ?=	ttx

check:
	# Validate and sanitize OTF files
	@$(TTX) -l ../spleen-6x12.otf
	@echo "Sanitizing: spleen-6x12.otf"
	@$(OTS) ../spleen-6x12.otf

	@$(TTX) -l ../spleen-8x16.otf
	@echo "Sanitizing: spleen-8x16.otf"
	@$(OTS) ../spleen-8x16.otf

	@$(TTX) -l ../spleen-12x24.otf
	@echo "Sanitizing: spleen-12x24.otf"
	@$(OTS) ../spleen-12x24.otf

	@$(TTX) -l ../spleen-16x32.otf
	@echo "Sanitizing: spleen-16x32.otf"
	@$(OTS) ../spleen-16x32.otf

	@$(TTX) -l ../spleen-32x64.otf
	@echo "Sanitizing: spleen-32x64.otf"
	@$(OTS) ../spleen-32x64.otf

	# Sanitize WOFF files
	@echo "Sanitizing: spleen-6x12.woff"
	@$(OTS) ../spleen-6x12.woff
	@echo "Sanitizing: spleen-8x16.woff"
	@$(OTS) ../spleen-8x16.woff
	@echo "Sanitizing: spleen-12x24.woff"
	@$(OTS) ../spleen-12x24.woff
	@echo "Sanitizing: spleen-16x32.woff"
	@$(OTS) ../spleen-16x32.woff
	@echo "Sanitizing: spleen-32x64.woff"
	@$(OTS) ../spleen-32x64.woff

	# Sanitize WOFF2 files
	@echo "Sanitizing: spleen-6x12.woff2"
	@$(OTS) ../spleen-6x12.woff2
	@echo "Sanitizing: spleen-8x16.woff2"
	@$(OTS) ../spleen-8x16.woff2
	@echo "Sanitizing: spleen-12x24.woff2"
	@$(OTS) ../spleen-12x24.woff2
	@echo "Sanitizing: spleen-16x32.woff2"
	@$(OTS) ../spleen-16x32.woff2
	@echo "Sanitizing: spleen-32x64.woff2"
	@$(OTS) ../spleen-32x64.woff2

.PHONY: check
