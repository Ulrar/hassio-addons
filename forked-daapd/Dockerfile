ARG BUILD_FROM=hassioaddons/debian-base:3.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

ENV BUILD_DEPS libcurl4-gnutls-dev \
               openjdk-11-jre-headless \
	       build-essential \
	       libgnutls28-dev \
	       libprotobuf-c-dev \
	       libplist-dev \
	       libsodium-dev \
	       libsodium-dev \
	       libpulse-dev \
	       autotools-dev \
	       git \
	       autoconf \
	       automake \
	       libtool \
	       libantlr3c-dev \
	       libconfuse-dev \
	       libunistring-dev \
	       libsqlite3-dev \
	       libavcodec-dev \
	       libavformat-dev \
	       libavfilter-dev \
	       libswscale-dev \
	       libavutil-dev \
	       libasound2-dev \
	       libmxml-dev \
	       libgcrypt20-dev \
	       libavahi-client-dev \
	       zlib1g-dev \
	       libevent-dev \
	       libplist-dev \
	       libjson-c-dev \
	       libspotify-dev \
	       libwebsockets-dev

ENV RUN_DEPS   libpulse0 \
	       libgnutls30 \
	       libprotobuf-c1 \
	       libsodium23 \
	       libantlr3c-3.4-0 \
	       libconfuse2 \
	       libunistring2 \
	       libsqlite3-0 \
               libavcodec58 \
	       libavformat58 \
	       libavfilter7 \
	       libswscale5 \
	       libavutil56 \
	       libasound2 \
	       libmxml1 \
	       libgcrypt20 \
	       libavahi-client3 \
	       zlib1g \
	       libevent-2.1-6 \
	       libplist3 \
	       libjson-c3 \
	       libspotify12 \
	       libspotify-dev \
	       libwebsockets8 \
	       libevent-pthreads-2.1-6 \
	       libcurl3-gnutls

#RUN sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends curl gpg gpg-agent dirmngr apt-transport-https gawk gettext gperf
RUN curl -L https://apt.mopidy.com/mopidy.list -o /etc/apt/sources.list.d/mopidy.list
RUN curl -L https://apt.mopidy.com/mopidy.gpg -o /tmp/mopidy.gpg
RUN apt-key add /tmp/mopidy.gpg
RUN apt-get update -y
RUN mkdir -p /usr/share/man/man1
RUN apt-get install -y --no-install-recommends ${BUILD_DEPS}

RUN curl -L -o /tmp/antlr-3.4-complete.jar http://www.antlr3.org/download/antlr-3.4-complete.jar && \
    echo '#!/bin/bash' > /usr/local/bin/antlr3 && \
    echo 'exec java -cp /tmp/antlr-3.4-complete.jar org.antlr.Tool "$@"' >> /usr/local/bin/antlr3 && \
    chmod 775 /usr/local/bin/antlr3

RUN cd /tmp && \
    git clone https://github.com/ejurgensen/forked-daapd.git && \
    cd /tmp/forked-daapd && \
    autoreconf -fi && \
    ./configure \
      --enable-itunes \
      --enable-chromecast \
      --with-pulseaudio \
      --enable-spotify \
      --with-libwebsockets && \
    make && \
    make install

RUN cd /usr/local/etc \
 && sed -i -e 's/\(uid.*=.*\)/uid = "root"/g' forked-daapd.conf \
 && sed -i s#"ipv6 = yes"#"ipv6 = no"#g forked-daapd.conf \
 && sed -i s#/srv/music#/share/forked-daapd/music#g forked-daapd.conf \
 && sed -i s#/usr/local/var/cache/forked-daapd/songs3.db#/share/forked-daapd/cache/songs3.db#g forked-daapd.conf \
 && sed -i s#/usr/local/var/cache/forked-daapd/cache.db#/share/forked-daapd/cache/cache.db#g forked-daapd.conf \
 && sed -i s#/usr/local/var/log/forked-daapd.log#/dev/stdout#g forked-daapd.conf \
 && sed -i "/websocket_port\ =/ s/# *//" forked-daapd.conf \
 && sed -i "/trusted_networks\ =/ s/# *//" forked-daapd.conf \
 && sed -i "/pipe_autostart\ =/ s/# *//" forked-daapd.conf \
 && sed -i "/db_path\ =/ s/# *//" forked-daapd.conf \
 && sed -i "/cache_path\ =/ s/# *//" forked-daapd.conf

RUN apt-get remove -y ${BUILD_DEPS} && apt-get autoremove -y
RUN apt-get install -y --no-install-recommends ${RUN_DEPS}

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Forked-daapd Server" \
    io.hass.description="The forked-daapd server program" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Ulrar" \
    org.label-schema.description="The forked-daapd server program" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Forked-daapd Server" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="" \
    org.label-schema.usage="" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/Ulrar/hassio-addons/tree/master/forked-daapd" \
    org.label-schema.vendor="Ulrar addons"
