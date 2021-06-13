/*
 * Spleen 1.9.1
 * Copyright (c) 2018-2021, Frederic Cambus
 * https://www.cambus.net/
 *
 * Created:      2020-07-08
 * Last Updated: 2021-03-12
 *
 * Spleen is released under the BSD 2-Clause license.
 * See LICENSE file for details.
 */

#include <stdio.h>
#include <time.h>

#include <dev/wscons/wsconsio.h>
#include <dev/wsfont/spleen6x12.h>

int
main(int argc, char *argv[])
{
	size_t loop;

	for (loop = 0; loop < 32 * 12; loop++)
		printf("%c", 0);

	for (loop = 0; loop < 224 * 12; loop++)
		printf("%c", spleen6x12_data[loop]);

	return 0;
}
