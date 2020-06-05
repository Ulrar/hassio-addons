ARG BUILD_FROM=hassioaddons/debian-base:3.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM} as base

ENV BUILD_DEPS \
    autoconf \
    automake \
    autotools-dev \
    build-essential \
    git \
    libantlr3c-dev \
    libasound2-dev \
    libavahi-client-dev \
    libavcodec-dev \
    libavfilter-dev \
    libavformat-dev \
    libavutil-dev \
    libconfuse-dev \
    libcurl4-gnutls-dev \
    libevent-dev \
    libgcrypt20-dev \
    libgnutls28-dev \
    libjson-c-dev \
    libmxml-dev \
    libplist-dev \
    libplist-dev \
    libprotobuf-c-dev \
    libpulse-dev \
    libsodium-dev \
    libspotify-dev \
    libsqlite3-dev \
    libswscale-dev \
    libtool \
    libunistring-dev \
    libwebsockets-dev \
    openjdk-11-jre-headless \
    zlib1g-dev

ENV RUN_DEPS \
    libantlr3c-3.4-0 \
    libasound2 \
    libasound2-plugins \
    libavahi-client3 \
    libavcodec58 \
    libavfilter7 \
    libavformat58 \
    libavutil56 \
    libconfuse2 \
    libcurl3-gnutls \
    libevent-2.1-6 \
    libevent-pthreads-2.1-6 \
    libgcrypt20 \
    libgnutls30 \
    libjson-c3 \
    libmxml1 \
    libplist3 \
    libprotobuf-c1 \
    libpulse0 \
    libsodium23 \
    libspotify-dev \
    libspotify12 \
    libsqlite3-0 \
    libswscale5 \
    libunistring2 \
    libwebsockets8 \
    zlib1g

#RUN sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    curl gpg gpg-agent dirmngr apt-transport-https gawk gettext gperf \
    && rm -rf /var/lib/apt/lists/*
RUN curl -L https://apt.mopidy.com/mopidy.list -o /etc/apt/sources.list.d/mopidy.list \
    && curl -L https://apt.mopidy.com/mopidy.gpg -o /tmp/mopidy.gpg \
    && apt-key add /tmp/mopidy.gpg


FROM base AS builder
RUN mkdir -p /usr/share/man/man1
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    ${BUILD_DEPS} \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L -o /tmp/antlr-3.4-complete.jar http://www.antlr3.org/download/antlr-3.4-complete.jar \
    && echo '#!/bin/bash' > /usr/local/bin/antlr3 \
    && echo 'exec java -cp /tmp/antlr-3.4-complete.jar org.antlr.Tool "$@"' >> /usr/local/bin/antlr3 \
    && chmod 775 /usr/local/bin/antlr3

WORKDIR /tmp/forked-daapd
RUN git clone --depth 1 https://github.com/ejurgensen/forked-daapd.git . \
    && autoreconf -fi \
    && ./configure \
    --enable-itunes \
    --enable-chromecast \
    --with-pulseaudio \
    --enable-spotify \
    --with-libwebsockets \
    && make \
	&& make install DESTDIR=/tmp/forked-daapd-install


FROM base AS runner
COPY --from=builder /usr/local/bin/antlr3 /usr/local/bin/antlr3
RUN chmod 775 /usr/local/bin/antlr3
COPY --from=builder /tmp/forked-daapd-install /
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    ${RUN_DEPS} \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/local/etc
RUN sed -i -e 's/\(uid.*=.*\)/uid = "root"/g' forked-daapd.conf \
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
