FROM wordpress

VOLUME [ "/var/www/html/wp-content/themes/" ]
VOLUME [ "/var/www/html/wp-content/plugins/" ]
VOLUME [ "/usr/src/wordpress/" ]
VOLUME [ "/var/www/html/" ]

ENV WORDPRESS_DB_USER root
ENV WORDPRESS_DB_PASSWORD Tentee237
ENV WORDPRESS_DB_NAME tentee

EXPOSE 80