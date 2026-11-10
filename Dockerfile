FROM registry.access.redhat.com/ubi10/nginx-126:latest

USER root

# Upgrade system packages to latest versions
RUN dnf upgrade -y --refresh --nodocs && dnf clean all && rm -rf /var/cache/dnf

# Copy static assets with non-root ownership (UID 1001, GID 0)
COPY --chown=1001:0 . /opt/app-root/src/
RUN chmod -R g=u /usr/share/nginx/html

# nss_wrapper (used by the s2i run script) replaces /etc/passwd, so nginx must be
# listed in its template; otherwise nginx fails with getpwnam("nginx") when the
# platform (e.g. IBM Code Engine) runs the container as root.
RUN echo 'nginx:x:998:997:Nginx web server:/var/lib/nginx:/sbin/nologin' >> /opt/app-root/etc/passwd.template

# Drop back to non-root nginx user (uid 1001)
USER 1001

EXPOSE 8080

CMD ["/usr/libexec/s2i/run"]