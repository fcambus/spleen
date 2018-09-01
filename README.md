# Spleen

Spleen is a monospaced bitmap font for consoles and terminals.

It is available in 4 sizes:

- 5x8
- 8x16
- 12x24
- 16x32

Each size is provided in the Glyph Bitmap Distribution Format (BDF).

All font sizes contain all ISO/IEC 8859-1 characters, except for the 5x8
version which only contains printable ASCII characters.

## Screenshots

Spleen 5x8:

![Spleen 5x8 Screenshot][1]

Spleen 8x16:

![Spleen 8x16 Screenshot][2]

## Roadmap

- Fix glyphes and alignment for all sizes
- Add extended character set for sizes where it makes sense (everything but
  the 5x8 version)
- Release 1.0.0
- Add bigger sizes (24x48 and 32x64) for 4K monitors

## Usage

Update your font path to include **Spleen**:

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

[1]: https://www.cambus.net/files/spleen/spleen-5x8.png
[2]: https://www.cambus.net/files/spleen/spleen-8x16.png
