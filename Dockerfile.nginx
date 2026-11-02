FROM docker.io/library/nginx:alpine

# Switch to root only for config changes, then drop back to non-root
USER root
RUN apk update && apk upgrade

COPY . /usr/share/nginx/html/
RUN sed -i 's/listen\s*80;/listen 8080;/' /etc/nginx/conf.d/default.conf

USER 1001
EXPOSE 8080
