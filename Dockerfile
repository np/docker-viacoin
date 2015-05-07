FROM ubuntu:14.04
MAINTAINER Nicolas Pouillard [https://nicolaspouillard.fr]

RUN apt-get update && \
    apt-get install -y software-properties-common python-software-properties && \
    add-apt-repository ppa:viacoin/viacoin && \
    apt-get update && \
    apt-get install -y viacoind && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV HOME /viacoin
RUN useradd -s /bin/bash -m -d /viacoin viacoin
RUN chown viacoin:viacoin -R /viacoin

USER viacoin

VOLUME ["/viacoin"]

EXPOSE 8332 8333

WORKDIR /viacoin

CMD ["viacoind"]

