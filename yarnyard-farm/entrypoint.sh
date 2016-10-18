#!/usr/bin/env bash

cd /var/www/yarnyard && git pull install
cd /var/www/yarnyard && composer install
cd /var/www/yarnyard && /usr/bin/php bin/console doctrine:database:create
# should remove diff command once initial migration file checked in
cd /var/www/yarnyard && /usr/bin/php bin/console doctrine:migrations:diff
cd /var/www/yarnyard && /usr/bin/php bin/console doctrine:migrations:migrate -n

cd /var/www/mailer && git pull
cd /var/www/mailer && composer install

cd /var/www/sheepdog && git pull
cd /var/www/sheepdog && npm i

/usr/bin/supervisord