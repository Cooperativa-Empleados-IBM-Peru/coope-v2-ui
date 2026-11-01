FROM registry.redhat.io/ubi9/nginx-122:latest

# Switch to root only for config changes, then drop back to non-root
USER root
RUN apk update && apk upgrade

COPY . /usr/share/nginx/html/
RUN sed -i 's/listen\s*80;/listen 8080;/' /etc/nginx/conf.d/nginx.conf \
    && chown -R 1001:0 /usr/share/nginx/html \
    && chmod -R g=u /usr/share/nginx/html

# ubi9/nginx-122 ships with the nginx user as uid 1001
USER 1001

EXPOSE 8080
