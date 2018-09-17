# Spleen

Spleen is a monospaced bitmap font for consoles and terminals.

It is available in 5 sizes:

- 5x8
- 8x16
- 12x24
- 16x32
- 32x64

Each size is provided in the Glyph Bitmap Distribution Format (BDF).

All font sizes contain all ISO/IEC 8859-1 characters, except for the 5x8
version which only contains printable ASCII characters.

## Screenshots

![Spleen - L'etranger][1]

## Roadmap

- Fix glyphes and alignment for all sizes
- Release 1.0.0

## Usage

Update your font path to include **Spleen**:

	xset +fp /usr/local/share/fonts/spleen/

Update **.Xdefaults** and add one of the following directives:

	xterm*faceName: spleen:pixelsize=8:antialias=false
	xterm*faceName: spleen:pixelsize=16:antialias=false
	xterm*faceName: spleen:pixelsize=24:antialias=false
	xterm*faceName: spleen:pixelsize=32:antialias=false
	xterm*faceName: spleen:pixelsize=64:antialias=false

## License

Spleen is released under the BSD 2-Clause license. See `LICENSE` file for
details.

## Author

Spleen is developed by Frederic Cambus.

- Site: https://www.cambus.net

## Resources

GitHub: https://github.com/fcambus/spleen

[1]: https://www.cambus.net/content/2018/09/spleen-etranger.png
