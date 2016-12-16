FROM gcc:6
MAINTAINER michaeldevery@gmail.com
RUN apt-get update

RUN apt-get install -y vim man

RUN mkdir -p ~/.vim/autoload ~/.vim/bundle \
    && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

RUN cd ~/.vim/bundle \
    && git clone git://github.com/tpope/vim-sensible.git

RUN apt-get update && apt-get install -y manpages-dev

COPY .vimrc /root/.vimrc

RUN echo "alias c='clear'" >> /root/.bashrc

WORKDIR /opt

CMD /bin/bash
