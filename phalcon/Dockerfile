FROM mickadoo/php7
MAINTAINER michaeldevery@gmail.com
RUN apt-get update

# phalcon
RUN curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | bash
RUN apt-get install -y php7.0-phalcon

# phalcon dev tools
RUN git clone git://github.com/phalcon/phalcon-devtools.git /opt/phalcon
RUN ln -s /opt/phalcon/phalcon.php /usr/bin/phalcon
RUN chmod ugo+x /usr/bin/phalcon