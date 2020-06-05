ARG BUILD_FROM
FROM $BUILD_FROM
SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

RUN apk add --no-cache --virtual=build-dependencies \
        gcc \
        libffi-dev \
        musl-dev \
        python3-dev \
    && apk add --no-cache \
        wget \
        curl \
        git \
        python3 \
        shadow \
        su-exec \
        tzdata \
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install radicale passlib[bcrypt] \
    && apk del --purge build-dependencies \
    && mkdir -p /data/ /share/radicale/

COPY rootfs /

# Labels
LABEL \
    io.hass.name="Radicale" \
    io.hass.description="Radicale is a small but powerful CalDAV (calendars, todo-lists) and CardDAV (contacts) server" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Ulrar" \
    org.label-schema.description="Radicale is a small but powerful CalDAV (calendars, todo-lists) and CardDAV (contacts) server" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Radicale" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="" \
    org.label-schema.usage="" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/Ulrar/hassio-addons" \
    org.label-schema.vendor="Ulrar addons"
