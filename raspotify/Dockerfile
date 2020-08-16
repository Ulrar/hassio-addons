ARG BUILD_FROM=hassioaddons/debian-base:3.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM} as base

ARG BUILD_ARCH

ENV BUILD_DEPS build-essential \
               alsa-utils      \
               libasound2-dev  \
               git             \
               curl            \
               pkg-config

ENV RUN_DEPS   apt-transport-https \
               libasound2-plugins


RUN apt-get update -y && apt-get install -y --no-install-recommends ${RUN_DEPS} \
    && rm -rf /var/lib/apt/lists/*

FROM base AS builder
ARG BUILD_ARCH
RUN apt-get update && apt-get install -y --no-install-recommends ${BUILD_DEPS}

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH             "/root/.cargo/bin/:$PATH"
ENV CARGO_TARGET_DIR "/usr/src/build"
ENV CARGO_HOME       "/usr/src/build/cache"

COPY metadata-pipe.patch /tmp
RUN git clone git://github.com/librespot-org/librespot.git /tmp/librespot && cd /tmp/librespot && git checkout master && git config --global user.name build && git config --global user.email "none@none.tld" && git apply /tmp/metadata-pipe.patch
WORKDIR /tmp/librespot

RUN cargo build --release --no-default-features --features alsa-backend
RUN cp -v /usr/src/build/release/librespot /usr/bin
RUN ${BUILD_ARCH}-linux-gnu-strip /usr/bin/librespot

FROM base AS runner
ARG BUILD_ARCH
COPY --from=builder /usr/bin/librespot /usr/bin/librespot

RUN ln -sf /share/raspotify /etc/default/raspotify

COPY rootfs /

ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

LABEL \
    io.hass.name="raspotify Server" \
    io.hass.description="The raspotify server program" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Ulrar" \
    org.label-schema.description="The raspotify server program" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Shairport Sync Server" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="" \
    org.label-schema.usage="" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/Ulrar/hassio-addons/tree/master/raspotify" \
    org.label-schema.vendor="Ulrar addons"
