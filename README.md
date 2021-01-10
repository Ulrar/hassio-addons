# Forked-DAAPD

Based on [johnpdowling's addon](https://github.com/johnpdowling/hassio-addons/tree/master/forked-daapd), with spotify, chromecast and airplay added.
The configuration tab isn't implemented yet, you will need to edit the config file in /share/forked-daapd/forked-daapd.conf if you want to change anything.
The defaults should work fine for most uses.

Ingress should work out of the box if you're accessing home assistant directly, if you're going through a reverse proxy of some kind you'll need to redirect port 3688 for the ui's websockets.
if you have any issues you can access the web interface on port 3689.

Note that Spotify support is not available on `aarch64`.

Note that the avahi-daemon addon is required if you're using the latest versions of Hassos.

# Raspotify

Spotify connect server, see [the github page](https://github.com/dtcooper/raspotify) for more info.
Isn't built with pulseaudio, if there is any interest I could probably add that, let me know.

Configurable through the supervisor interface. Username and password are optional, if you just want to cast locally from your phone you can leave them blank.

Works great with Forked-DAAPD through a pipe, just use 
```yaml
backend: pipe
device: /share/forked-daapd/music/Raspotify
```
in the add-on configuration.

[Read the full add-on documentation](raspotify/DOCS.md).

# Avahi-Daemon

The newer versions of Hassos have moved form avahi to systemd-resolved, which is not compatible with forked-daapd.
This addon should allow forked-daapd, and any other addon that depends on avahi, to work.

# Radicale

Fully working radicale server, again with no config from the interface. The htpasswd users file must be /share/radicale/users and passwords must be hashed in md5.
Ingress does not work, but the web interface can be found on port 5232.
