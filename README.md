# Forked-DAAPD

Based on [johnpdowling's addon](https://github.com/johnpdowling/hassio-addons/tree/master/forked-daapd), with spotify, chromecast and airplay added.
The configuration tab isn't implemented yet, you will need to edit the config file in /share/forked-daapd/forked-daapd.conf if you want to change anything.
The defaults should work fine for most uses.

Note that ingress does not work, but you can access the web interface on port 3689.

# Radicale

Fully working radicale server, again with no config from the interface. The htpasswd users file must be /share/radicale/users and passwords must be hashed in md5.
Ingress does not work, but the web interface can be found on port 5232.
