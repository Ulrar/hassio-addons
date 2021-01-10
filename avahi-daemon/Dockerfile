ARG BUILD_FROM=hassioaddons/debian-base:3.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

ARG BUILD_ARCH

ENV DEPS   avahi-daemon

RUN apt-get update -y && apt-get install -y --no-install-recommends ${DEPS} \
    && rm -rf /var/lib/apt/lists/*

COPY rootfs /

ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

LABEL \
    io.hass.name="Avahi Daemon" \
    io.hass.description="The avahi daemon" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Ulrar" \
    org.label-schema.description="The avahi daemon" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Avahi Daemon" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="" \
    org.label-schema.usage="" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/Ulrar/hassio-addons/tree/master/avahi-daemon" \
    org.label-schema.vendor="Ulrar addons"
