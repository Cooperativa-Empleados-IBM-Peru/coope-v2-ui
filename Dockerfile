FROM registry.access.redhat.com/ubi10/nginx-126:latest

USER root

# Upgrade system packages to latest versions
RUN dnf upgrade -y --refresh --nodocs && dnf clean all && rm -rf /var/cache/dnf

# Copy static assets with non-root ownership (UID 1001, GID 0)
COPY --chown=1001:0 . /usr/share/nginx/html/
RUN chmod -R g=u /usr/share/nginx/html

# Drop back to non-root nginx user (uid 1001)
USER 1001

EXPOSE 8080

CMD ["/usr/libexec/s2i/run"]