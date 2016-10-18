FROM mickadoo/php7
MAINTAINER michaeldevery@gmail.com
RUN apt-get update

ENV MYSQL_PASS root

RUN echo "mysql-server mysql-server/root_password password ${MYSQL_PASS}" | debconf-set-selections \
    && echo "mysql-server mysql-server/root_password_again password ${MYSQL_PASS}" | debconf-set-selections \
    && apt-get -y install mysql-server

RUN apt-get install -y default-jdk

RUN curl -L -O https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.3.4/elasticsearch-2.3.4.tar.gz \
    && tar -xvf elasticsearch-2.3.4.tar.gz \
    && mv elasticsearch-2.3.4/ /opt/elasticsearch
RUN useradd elasticsearch && chown -R elasticsearch: /opt/elasticsearch

RUN echo 'deb http://www.rabbitmq.com/debian/ testing main' | tee /etc/apt/sources.list.d/rabbitmq.list \
    && wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add -
RUN apt-get update
RUN apt-get install -y rabbitmq-server

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 \
    && echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

RUN apt-get update

RUN apt-get install -y mongodb-org
RUN mkdir -p /data/db

RUN apt-get install -y build-essential checkinstall libssl-dev
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash \
    && . /root/.bashrc \
    && nvm install 6.0.0 \
    && nvm use 6.0.0 \
    && nvm alias default 6.0.0

ENV SHEEPDOG__MONGO_URL 'mongodb://localhost/sheepdog'
ENV SHEEPDOG__RABBIT_HOST 'localhost'
ENV YARNYARD_DATABASE_DRIVER 'pdo_mysql'

# su elasticsearch -c '/opt/elasticsearch/bin/elasticsearch'
# /usr/sbin/rabbitmq-server
# service mysql start
# mongod
# run db creation script, migrations