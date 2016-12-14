FROM debian:jessie-backports
MAINTAINER Marcelo Almeida <marcelo.almeida@jumia.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y wget && \
    wget -qO- https://repo.saltstack.com/apt/debian/8/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add - && \
    echo "deb http://repo.saltstack.com/apt/debian/8/amd64/latest jessie main" > /etc/apt/sources.list.d/saltstack.list && \
    apt-get update && apt-get install -y --no-install-recommends salt-ssh ssh-client python-git python-msgpack && \
    apt-get clean && apt-get autoremove -yq --purge && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo '   StrictHostKeyChecking no' >> /etc/ssh/ssh_config

CMD ["salt-ssh", "--version"]
