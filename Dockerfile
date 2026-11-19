FROM nginx:alpine@sha256:0563c36f94a6d3ec3584161b77859f740f7e20b4853f52c796a864ce6908e8ea

# Upgrade base image
RUN set -ex && apk --update --no-cache upgrade

# Copy clearnet static files
COPY public /usr/share/nginx/html/public

# Copy Tor static files
COPY tor /usr/share/nginx/html/tor

# Delete default nginx conf file
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx.conf file
COPY nginx.conf /etc/nginx/nginx.conf

HEALTHCHECK CMD wget -qO- --header="Host: sethforprivacy.com" http://127.0.0.1/ || exit 1

EXPOSE 80