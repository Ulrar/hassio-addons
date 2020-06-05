ARG BUILD_FROM=hassioaddons/debian-base:3.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

RUN apt-get update
RUN apt-get install -y --no-install-recommends curl apt-transport-https gnupg2 dirmngr
RUN curl -sSL https://dtcooper.github.io/raspotify/key.asc | apt-key add -v -
RUN echo 'deb https://dtcooper.github.io/raspotify raspotify main' | cat > /etc/apt/sources.list.d/raspotify.list
RUN apt-get update
RUN apt-get install -y --no-install-recommends raspotify
RUN ln -sf /share/raspotify /etc/default/raspotify

COPY rootfs /

ARG BUILD_ARCH
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
