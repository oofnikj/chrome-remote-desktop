# Chrome Remote Desktop: Mirror Mode

This modified version of the Chrome Remote Desktop for Linux [Python wrapper](https://github.com/chromium/chromium/blob/master/remoting/host/linux/linux_me2me_host.py) allows one to launch CRD in mirror mode, making the primary display available over a remote connection instead of launching a new session in a virtual framebuffer.

Original functionality has been preserved -- this is a drop-in replacement and all existing command-line options work as before.

## Usage

It is expected that you already have a working installation of Chrome Remote Desktop.

To use, replace the original script with the included modified version:
```
$ sudo cp chrome-remote-desktop /opt/google/chrome-remote-desktop/
```

then launch CRD with the additional option `--mirror DISPLAY`, where `DISPLAY` is the X display to be mirrored (most probably `:0`). CRD will attempt to connect to this display instead of launching a new `Xvfb` process, providing much the same functionality as CRD on other platforms:

```
$ /opt/google/chrome-remote-desktop/chrome-remote-desktop --start --mirror :0
```

**NOTE:** On Ubuntu, ou may need to stop the `chrome-remote-desktop` service first:
```
$ sudo service stop chrome-remote-desktop
```

## Service installation

The included wrapper script, `crd-mirror`, does a couple of things:
* launches CRD in mirror mode
* redirects PulseAudio output to the remote host once connected and restores output to the default after disconnecting
* triggers a desktop notification when a remote host connection status changes (requires `notify-send` to be installed)
* locks the desktop when remote client disconnects for security

The wrapper script can be placed in the same directoy as `chrome-remote-desktop`.

The `systemd` service definition can be used to run `crd-mirror` as a user daemon.

To install and run it:
```
$ sudo cp crd-mirror /opt/google/chrome-remote-desktop/
$ mkdir -p ~/.config/systemd/user
$ cp crd-mirror.service ~/.config/systemd/user/
$ systemctl --user daemon-reload
$ systemctl --user enable crd-mirror.service
$ systemctl --user start crd-mirror.service
```

Tested on Arch Linux and Ubuntu 18.04 running GNOME in Xorg.

YMMV.