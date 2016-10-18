FROM mickadoo/php7
MAINTAINER michaeldevery@gmail.com
RUN apt-get update

RUN apt-get install -y php7.0-gd
RUN composer global require drush/drush
RUN echo 'alias drush="/usr/bin/php /root/.composer/vendor/drush/drush/drush"' >> ~/.bashrc

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \
    && echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections \
    && apt-get -y install mysql-server-5.5

RUN apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV XDEBUG_CONFIG "idekey=PHPSTORM"
ENV PHP_IDE_CONFIG "serverName=docker-drupal"

WORKDIR /var/www

CMD ["/usr/bin/supervisord"]
