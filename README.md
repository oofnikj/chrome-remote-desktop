# Chrome Remote Desktop: Mirror Mode

This modified version of the Chrome Remote Desktop for Linux [Python wrapper](https://github.com/chromium/chromium/blob/master/remoting/host/linux/linux_me2me_host.py) allows one to launch CRD in mirror mode, making the primary display available over a remote connection instead of launching a new session in a virtual framebuffer.

After installing the modified script, launching CRD with the additional option `--mirror DISPLAY`, where `DISPLAY` is the X display to be mirrored (most probably `:0`), will connect to this display instead of launching a new `Xvfb` process, providing much the same functionality as CRD on other platforms.

Original functionality has been preserved -- this is a drop-in replacement and all existing command-line options work as before.

The included wrapper script, `crd-mirror`, does a couple of things:
* launches CRD in mirror mode
* redirects PulseAudio output to the remote host once connected and restores output to the default after disconnecting
* triggers a desktop notification when a remote host connection status changes (requires `notify-send` to be installed)
* locks the desktop when remote client disconnects for security (requires `xdg-screensaver`)

## Installation

It is expected that you already have a working installation of Chrome Remote Desktop.

To install mirror mode:
```
$ make install
```

## Usage

Connect to your host remotely as usual, but instead of launching a new session, you should be greeted by your primary session.

---

Tested on Ubuntu 18.04 and Arch Linux running GNOME-Xorg. Wayland is currently not supported by Chrome Remote Desktop. There is some discussion [here](https://www.mail-archive.com/wayland-devel@lists.freedesktop.org/msg40731.html).

YMMV.