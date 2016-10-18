FROM mickadoo/php7
MAINTAINER michaeldevery@gmail.com
RUN apt-get update

# env variables (yarnyard "composer install" will fail if not pdo_sqlite)
ENV YARNYARD_DATABASE_DRIVER pdo_sqlite
ENV MYSQL_PASS root

# mysql server
RUN echo "mysql-server mysql-server/root_password password ${MYSQL_PASS}" | debconf-set-selections \
    && echo "mysql-server mysql-server/root_password_again password ${MYSQL_PASS}" | debconf-set-selections

# elasticsearch
RUN curl -L -O https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.3.4/elasticsearch-2.3.4.tar.gz \
    && tar -xvf elasticsearch-2.3.4.tar.gz \
    && mv elasticsearch-2.3.4/ /opt/elasticsearch
RUN useradd elasticsearch && chown -R elasticsearch: /opt/elasticsearch

# rabbitmq
RUN echo 'deb http://www.rabbitmq.com/debian/ testing main' | tee /etc/apt/sources.list.d/rabbitmq.list \
    && wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add -

# mongodb
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 \
    && echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list \
    && mkdir -p /data/db

# nvm / npm / node
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash \
    && . /root/.bashrc \
    && nvm install 6.0.0 \
    && nvm use 6.0.0 \
    && nvm alias default 6.0.0

# install packages
RUN apt-get update --fix-missing
RUN apt-get install -y build-essential checkinstall libssl-dev rabbitmq-server default-jdk mysql-server mongodb-org supervisor

# clone repos
RUN git clone https://github.com/mickadoo/mailer /var/www/mailer
RUN git clone https://github.com/mickadoo/yarnyard /var/www/yarnyard
RUN git clone https://github.com/mickadoo/sheepdog /var/www/sheepdog

# do initial composer install to reduce time on each deploy
RUN cd /var/www/yarnyard && composer install
RUN cd /var/www/mailer && composer install

# initial npm i
RUN ln -s /root/.nvm/versions/node/v6.0.0/bin/node /usr/bin/node
RUN ln -s /root/.nvm/versions/node/v6.0.0/bin/npm /usr/bin/npm
RUN cd /var/www/sheepdog && npm i

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY entrypoint.sh /opt/entrypoint.sh

WORKDIR /var/www
ENTRYPOINT ["/bin/sh" , "/opt/entrypoint.sh"]