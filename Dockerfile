FROM debian:jessie
MAINTAINER  Alexandre Buisine <alexandrejabuisine@gmail.com>
LABEL version "3.2.0"

# Update the package repository and install applications
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
 && apt-get -yqq install \
 	vim-tiny \
 && apt-get -yqq clean \
 && rm -rf /var/lib/apt/lists/*

# Update the package repository and install applications
WORKDIR /usr/local
COPY resources/fcron.3.2.0.tgz resources/fcron.conf resources/launch.sh ./
RUN tar xzf fcron.3.2.0.tgz \
 && rm fcron.3.2.0.tgz \
 && useradd fcron \
 && mkdir -p var/spool/fcron \
 && mv launch.sh / \
 && chmod +x /launch.sh \
 && mkdir /fcrontabs \
 && mv fcron.conf etc/ \
 && chmod 644 etc/fcron.conf \
 && chown root:fcron etc/fcron.conf var/spool/fcron /fcrontabs \
 && chmod g+rwx var/spool/fcron/ /fcrontabs/

VOLUME ["/fcrontabs", "/usr/local/var/spool/fcron"]
WORKDIR /fcrontabs

CMD ["/launch.sh"]