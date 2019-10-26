## Dracut colors hook

Use this [dracut](https://wiki.archlinux.org/index.php/Dracut) hook to
set the virtual terminal colors during early userspace. This package follows
same config syntax (`/etc/vconsole.conf`) as original [mkinitcpio hooks](https://github.com/EvanPurkhiser/mkinitcpio-colors).
The syntax is provided below.

Requires the [setcolors](https://github.com/EvanPurkhiser/linux-vt-setcolors) utility.

### Usage

To define colors you will want to edit your `/etc/vconsole.conf` file and
specify the colors in the format `COLOR_X=hexcode`. Where X is a number between
0 and 15. For example:

```sh
COLOR_0=ff0000
COLOR_1=00ff00
...
COLOR_15=0000ff
```

If no config is provided, the setcolors utility fallbacks to default values (ergo, nothing is changed).

You will need to regenerate initrd with `dracut` command each time you make changes to your
color configuration.

### Converting from `setcolors` format

You may use this sed command to convert from a [setcolors color configuration
file](https://github.com/EvanPurkhiser/linux-vt-setcolors/blob/master/example-colors/solarized)
to the required format for the `/etc/vconsole.conf` file.

```sh
$ sed 's/^\(.*\)#\(.\{6\}\).*$/COLOR_\1=\2/'
```