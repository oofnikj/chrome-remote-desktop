# Chrome Remote Desktop: Mirror Mode Hack

This modified version of the Chrome Remote Desktop for Linux [Python wrapper](https://github.com/chromium/chromium/blob/master/remoting/host/linux/linux_me2me_host.py) allows one to launch CRD in mirror mode, making the primary display available over a remote connection instead of launching a new session in a virtual framebuffer.

Original functionality has been preserved. 

## Usage

To use, launch CRD with the additional option `--mirror DISPLAY`, where `DISPLAY` is the X display number to be mirrored (most probably `0`). CRD will attempt to connect to this display instead of launching a new `Xvfb` process, providing much the same functionality as CRD on other platforms:

```
$ /opt/google/chrome-remote-desktop --start --mirror 0
```