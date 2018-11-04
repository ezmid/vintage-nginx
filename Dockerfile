FROM alpine:3.8

MAINTAINER Filip Cieker <filip.cieker@ezmid.com>
LABEL maintainer="Filip Cieker filip.cieker@ezmid.com"

USER root

################################################################################
# Layer 1 - Install Nginx
RUN apk --no-cache add \
        nginx

################################################################################
# Layer 2 - Copy default configuration files
COPY docker /

################################################################################
# Layer 3 - Fix app dir rights
RUN chown -R nginx:nginx \
        /var/www/app \
        /var/lib/nginx \
        /var/log/nginx

################################################################################
# Init system
EXPOSE 8080
WORKDIR /var/www/app
CMD ["nginx", "-g", "daemon off;"]
