# Spleen

Spleen is a monospaced bitmap font available in 5 sizes:

- 5x8
- 8x16
- 12x24
- 16x32
- 32x64

Each size is provided in the Glyph Bitmap Distribution Format (BDF), and
release tarballs contain the fonts in the following formats: `PCF`, `PSF`
(for the Linux console), and `.dfont` for Macintosh users.

All font sizes contain all ISO/IEC 8859-1 characters, except for the 5x8
version which only contains printable ASCII characters due to character
size constraints.

The font name is a reference to Baudelaire.

## Screenshots

The following screenshots show Spleen 16x32 displaying code and prose.

![Spleen - Hello][1]

![Spleen - L'etranger][2]

## XLFD font names

```
-misc-spleen-medium-r-normal--8-80-72-72-c-50-iso10646-1
-misc-spleen-medium-r-normal--16-160-72-72-c-80-iso10646-1
-misc-spleen-medium-r-normal--24-240-72-72-c-120-iso10646-1
-misc-spleen-medium-r-normal--32-320-72-72-c-160-iso10646-1
-misc-spleen-medium-r-normal--64-640-72-72-c-320-iso10646-1
```

## Packages

Packages are available for the following operating systems:

- [OpenBSD][3]
- [NetBSD][4]
- [FreeBSD][5]
- [Arch Linux][6]
- [Void Linux][7]

## Manual installation

### *BSD and Linux

Clone the repository, convert the files to the Portable Compiled Format
(PCF) using **bdftopcf** and run **mkfontdir** in the directory.

### Mac OS X / macOS

macOS users should use the provided `.dfont` file containing all sizes.

## Usage

### *BSD and Linux

Update the font path to include **Spleen**:

	xset +fp /usr/local/share/fonts/spleen/

Update **.Xdefaults** and add one of the following directives:

	xterm*faceName: spleen:pixelsize=8:antialias=false
	xterm*faceName: spleen:pixelsize=16:antialias=false
	xterm*faceName: spleen:pixelsize=24:antialias=false
	xterm*faceName: spleen:pixelsize=32:antialias=false
	xterm*faceName: spleen:pixelsize=64:antialias=false

Launch **xterm**.

### Linux console

Release tarballs provide PSF files for each size, `setfont` can be used
to load and set the desired font.

### Mac OS X / macOS

Configure the terminal application to use Spleen, and make sure anti-aliasing
is disabled.

Use the following sizes:

- Spleen 5x8: 8 Pt
- Spleen 8x16: 16 Pt
- Spleen 12x24: 24 Pt
- Spleen 16x32: 32 Pt
- Spleen 32x64: 64 Pt

## License

Spleen is released under the BSD 2-Clause license. See `LICENSE` file for
details.

## Author

Spleen is developed by Frederic Cambus.

- Site: https://www.cambus.net

## Resources

GitHub: https://github.com/fcambus/spleen

[1]: https://www.cambus.net/content/2018/09/spleen-hello.png
[2]: https://www.cambus.net/content/2018/09/spleen-etranger.png
[3]: https://cvsweb.openbsd.org/cgi-bin/cvsweb/ports/fonts/spleen/
[4]: http://pkgsrc.se/fonts/spleen
[5]: https://www.freshports.org/x11-fonts/spleen/
[6]: https://aur.archlinux.org/packages/bdf-spleen/
[7]: https://github.com/void-linux/void-packages/tree/master/srcpkgs/font-spleen
