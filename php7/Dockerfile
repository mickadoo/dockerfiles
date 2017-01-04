FROM debian:jessie
MAINTAINER michaeldevery@gmail.com
RUN apt-get update

# required packages
RUN apt-get install -y wget git

# add php7 source
RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && wget https://www.dotdeb.org/dotdeb.gpg \
    && apt-key add dotdeb.gpg

RUN apt-get update

# php 7 and required extensions
RUN apt-get install -y php7.0-cli php7.0-bcmath php7.0-mbstring php7.0-dom php7.0-zip php7.0-mysql php7.0-sqlite

# composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

# optional tools
RUN apt-get install -y curl vim mysql-client

# xdebug
RUN apt-get install -y php7.0-xdebug
RUN echo "xdebug.remote_enable=on \n\
          xdebug.remote_host=172.17.0.1 \n\
          xdebug.remote_port=9000 \n\
          xdebug.remote_connect_back=Off \n\
          xdebug.remote_autostart=off" >> /etc/php/7.0/mods-available/xdebug.ini
RUN echo "alias phpdb='export XDEBUG_CONFIG=\"idekey=PHPSTORM\"; export PHP_IDE_CONFIG=\"serverName=docker\"; php '" >> ~/.bashrc

# ssh (for remote interpreter)
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd \
    && chmod 0755 /var/run/sshd \
    && /usr/sbin/sshd
RUN useradd --create-home --shell /bin/bash --groups sudo php-remote \
    &&  echo "php-remote:php-remote" | chpasswd

# composer global directory
ENV COMPOSER_HOME "/usr/local/composer"
RUN echo PATH=$PATH:$COMPOSER_HOME/vendor/bin >> /etc/profile

# phpcs
RUN composer global require "squizlabs/php_codesniffer=*"

# phpmd
RUN composer global require "phpmd/phpmd=*"

RUN apt-get install php7.0-curl

EXPOSE 22
EXPOSE 80

CMD ["/usr/sbin/sshd", "-D"]
