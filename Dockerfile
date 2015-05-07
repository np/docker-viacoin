FROM ubuntu:14.04
MAINTAINER Nicolas Pouillard [https://nicolaspouillard.fr]

#RUN apt-get update && \
#    apt-get install -y software-properties-common python-software-properties

# waiting for the ppa
#    add-apt-repository ppa:viacoin/viacoin && \
#    apt-get update && \
#    apt-get install -y viacoind && \
#    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN add-apt-repository ppa:bitcoin/bitcoin && \
#    apt-get update && \
#    apt-get install -y build-essential libtool autotools-dev autoconf pkg-config libssl-dev libboost-all-dev libdb4.8-dev libdb4.8++-dev libminiupnpc-dev

#RUN ./autogen.sh && \
#    ./configure --with-gul=no --enable-tests=no && \
#    make && \
#    make install

ADD https://github.com/viacoin/viacoin/releases/download/v0.10.7/viacoin-0.10.7-linux64.tar.gz viacoin-0.10.7-linux64.tar.gz
RUN echo 'daef41d015e2d63db9c4954729f3b40f7e2c00582b899ec6ba77e97005e82aae  viacoin-0.10.7-linux64.tar.gz' | sha256sum -c
RUN tar -C /usr/local/ --strip-components=1 -xzf viacoin-0.10.7-linux64.tar.gz

ENV HOME /viacoin
RUN useradd -s /bin/bash -m -d /viacoin viacoin
RUN chown viacoin:viacoin -R /viacoin

USER viacoin

VOLUME ["/viacoin"]

EXPOSE 8332 8333

WORKDIR /viacoin

CMD ["viacoind"]

