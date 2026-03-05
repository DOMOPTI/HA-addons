ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="DOMOPTI S.R.L.S." \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="DOMOPTI S.R.L.S." \
    org.opencontainers.image.authors="DOMOPTI S.R.L.S." \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.version=${BUILD_VERSION}

# Bind Next.js to all interfaces (HA Supervisor connects via container IP, not localhost)
ENV HOSTNAME=0.0.0.0

# Startup wrapper: recreates /data subdirs wiped by HA's volume mount, then starts supervisord
COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]
