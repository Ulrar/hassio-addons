# Forked-DAAPD

Based on [johnpdowling's addon](https://github.com/johnpdowling/hassio-addons/tree/master/forked-daapd), with spotify, chromecast and airplay added.
The configuration tab isn't implemented yet, you will need to edit the config file in /share/forked-daapd/forked-daapd.conf if you want to change anything.
The defaults should work fine for most uses.

Note that ingress does not work, but you can access the web interface on port 3689.

/!\ You should use pulseaudio as the output type for local playback :

```
audio {
...
	type = "pulseaudio"
...
}
```

Note that Spotify support is not available on `aarch64`.

# Raspotify

Spotify connect server, see [the github page](https://github.com/dtcooper/raspotify) for more info.
Isn't built with pulseaudio, if there is any interest I could probably add that, let me know.

Configurable through the supervisor interface. Username and password are optional, if you just want to cast locally from your phone you can leave them blank.
Works great with Forked-DAAPD through a pipe, just use `--backend pipe --device /share/forked-daapd/music/Raspotify` in the backend configuration option.

# Radicale

Fully working radicale server, again with no config from the interface. The htpasswd users file must be /share/radicale/users and passwords must be hashed in md5.
Ingress does not work, but the web interface can be found on port 5232.
