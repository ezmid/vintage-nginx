FROM alpine:3.9

LABEL maintainer="Filip Cieker filip.cieker@ezmid.com"

################################################################################
# Layer 1 - Install Nginx
RUN apk --no-cache --update upgrade && \
    apk add \
        nginx

################################################################################
# Layer 2 - Copy default configuration files
COPY docker /

################################################################################
# Layer 3 - Fix app dir rights
RUN chown -R nobody:nobody \
        /var/www/app/index.html \
        /var/lib/nginx/logs \
        /var/log/nginx \
        /var/tmp \
        /run/nginx && \
    chmod -R 0777 \
        /var/tmp \
        /var/lib/nginx/logs \
        /run/nginx

################################################################################
# Init system
EXPOSE 8080
WORKDIR /var/www/app
CMD ["nginx", "-g", "daemon off;"]
