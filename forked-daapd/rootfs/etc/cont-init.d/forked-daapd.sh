#!/usr/bin/with-contenv bashio
# ==============================================================================
# Ulrar Hass.io Add-ons: forked-daapd server
# Configures the forked-daapd Server
# ==============================================================================

if ! bashio::fs.directory_exists '/share/forked-daapd/cache'; then
    bashio::log.debug 'Creating cache folder...'
    mkdir -p /share/forked-daapd/cache
fi

if ! bashio::fs.file_exists '/share/forked-daapd/forked-daapd.conf'; then
    bashio::log.debug 'Copying default conf file...'
    cp /usr/local/etc/forked-daapd.conf /share/forked-daapd/forked-daapd.conf
fi

if ! bashio::fs.directory_exists '/share/forked-daapd/music'; then
    bashio::log.debug 'Creating music folder...'
    mkdir -p /share/forked-daapd/music
    bashio::log.debug 'Creating HA fifo file...'
    mkfifo -m 666 /share/forked-daapd/music/HomeAssistantAnnounce
fi
