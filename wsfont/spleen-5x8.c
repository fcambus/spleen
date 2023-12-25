/*
 * Spleen 2.0.2
 * Copyright (c) 2018-2023, Frederic Cambus
 * https://www.cambus.net/
 *
 * Created:      2020-06-20
 * Last Updated: 2020-07-08
 *
 * Spleen is released under the BSD 2-Clause license.
 * See LICENSE file for details.
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */

#include <stdio.h>
#include <time.h>

#include <dev/wscons/wsconsio.h>
#include <dev/wsfont/spleen5x8.h>

int
main(int argc, char *argv[])
{
	size_t loop;

	for (loop = 0; loop < 32 * 8; loop++)
		printf("%c", 0);

	for (loop = 0; loop < 96 * 8; loop++)
		printf("%c", spleen5x8_data[loop]);

	for (loop = 0; loop < 128 * 8; loop++)
		printf("%c", 0);

	return 0;
}
