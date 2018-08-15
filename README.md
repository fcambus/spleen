# Spleen

Spleen is a hand-drawn bitmap font which is available in 4 sizes:

- 5x8
- 8x16
- 12x24
- 16x32

The project is still in its early infancy. The fonts only contain
printable ASCII characters for now (96 characters per font).

## Roadmap

- Fix glyphes and alignment for all sizes
- Add extended character set for sizes where it makes sense (everything but
  the 5x8 version)
- Release 1.0.0

## Usage

Update your font path to include **Spleen*:

	xset +fp /usr/local/share/fonts/spleen/

Update **.Xdefaults** and add one of the following directives:

	xterm*faceName: spleen:pixelsize=8:antialias=false
	xterm*faceName: spleen:pixelsize=16:antialias=false
	xterm*faceName: spleen:pixelsize=24:antialias=false
	xterm*faceName: spleen:pixelsize=32:antialias=false

## License

Spleen is released under the BSD 2-Clause license. See `LICENSE` file for
details.

## Author

Spleen is developed by Frederic Cambus.

- Site: https://www.cambus.net

## Resources

GitHub: https://github.com/fcambus/spleen
