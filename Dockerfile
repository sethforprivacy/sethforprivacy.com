FROM nginx:latest

# Patch vulnerabilities
RUN apt-get update \
    && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends ca-certificates\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy clearnet static files
COPY public /usr/share/nginx/html/public

# Copy Tor static files
COPY tor /usr/share/nginx/html/tor

# Delete default nginx conf file
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx.conf file
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80