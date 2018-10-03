FROM alpine:3.8

MAINTAINER Filip Cieker <filip.cieker@ezmid.com>

# Switch to root, because we need to alter the image
USER root

RUN apk --no-cache add nginx

# Ensure directories exist
RUN /bin/mkdir -p /var/www/app /var/www/tmp

# Copy default configuration files
COPY docker /

# Runtime
#COPY ./public/build /var/www/app/build

# deletes default nginx conf
RUN /bin/rm /etc/nginx/conf.d/default.conf \
        # support running as arbitrary user which belogs to the root group
        && chmod -R g+rwx /var/www \
        && chgrp -R root /var/www

# Switch back user
RUN chown -R nginx:nginx /var/www/app
USER nginx

# Default app folder
WORKDIR /var/www/app

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
