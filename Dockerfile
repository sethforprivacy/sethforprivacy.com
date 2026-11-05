FROM nginx:alpine@sha256:a46f57e097e8effc26192437d2e715adf74bcbea836117651ee436c27983fa41

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