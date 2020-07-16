# Home Assistant Add-on: Raspotify

The Raspotify add-on allows you to use your device,
running Home Assistant, to play your Spotify music. This add-on uses the
Sotify Connect protocol, which makes it a device that can be controlled
by all the official clients.

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```yaml
name: Raspotify
bitrate: 160
volume_normalisation: true
backend: alsa
```

**Note**: _This is just an example, don't copy and paste it! Create your own!_

### Option: `log_level`

The `log_level` option controls the level of log output by the add-on and can
be changed to be more or less verbose, which might be useful when you are
dealing with an unknown issue. Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`:  Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a
more severe level, e.g., `debug` also shows `info` messages. By default,
the `log_level` is set to `info`, which is the recommended setting unless
you are troubleshooting.

Setting the `log_level` to `debug` will also turn on verbose mode of librespot.

### Option: `name`

The name of your device (the Spotify Connect target), as shown on
the official Spotify clients.

### Option: `bitrate`

The bitrate Spotify should use. The higher, the better the sound quality,
however, the add-on consumes more data.

Valid values: `96`, `160` (default) or `320`.

### Option: `username`

**IMPORTANT**: _This requires a Spotify Premium account!_

The username you use to login to your Spotify Premium account. Setting
this will bind the add-on to your account exclusively.

This can be helpful when experiencing discovery issues on your network or
to disallow guests on your network to use the add-on.

### Option: `password`

The password you use to login to your Spotify Premium account.

### Option: `volume_normalisation`

Whether to apply volume normalisation.

### Option: `backend`

The backend to use with librespot.

Valid Values are
- `alsa` for local playback on your host system,
- `pipe` for writing to a fifo pipe which can be read by the Forked-DAAPD add-on for example. See option `device`.

### Option: `device`

When choosing `backend: pipe` this specifies the file fifo pipe which this add-on writes audio to.

### Option: `metadata_pipe`

This specifies the pipe to write metadata to, when used with `backend: pipe` to forked-daapd this allows the forked-daapd server to display the track information instead of the pipe name.

Example:
```yaml
backend: pipe
device: /share/forked-daapd/music/Raspotify
metadata_pipe: /share/forked-daapd/music/Raspotify.metadata
```

The Raspotify add-on tries to create the pipe at the given path or uses an already existing pipe on each start.
If it could not create or find a pipe, there will be an error message in the add-on log. Created pipes are not deleted when changing this option.

Do not forget to restart forked-daapd after starting raspotify for the first time or the pipes might not work properly.

### Option: `extra_options`

Extra commandline arguments to pass to the librespot call.
See [Librespot Options](https://github.com/librespot-org/librespot/wiki/Options) for details.

**Note**: _The options `--linear-volume --initial-volume=100` are currently already set within the add-on._
