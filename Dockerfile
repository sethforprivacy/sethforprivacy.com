FROM nginx:latest
COPY ./public /usr/share/nginx/html/public
COPY ./tor /usr/share/nginx/html/tor
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80