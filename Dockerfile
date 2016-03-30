FROM debian:jessie
MAINTAINER  Alexandre Buisine <alexandrejabuisine@gmail.com>
LABEL version "3.2.0"

# Update the package repository and install applications
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
 && apt-get -yqq install \
 	vim-tiny \
 && apt-get -yqq clean \
 && rm -rf /var/lib/apt/lists/*

ADD https://github.com/kreuzwerker/envplate/releases/download/v0.0.8/ep-linux /usr/local/bin/ep
COPY resources/launch.sh /usr/local/bin

WORKDIR /usr/local
COPY resources/fcron.3.2.0.tgz resources/fcron.conf ./
RUN tar xzf fcron.3.2.0.tgz \
 && rm fcron.3.2.0.tgz \
 && useradd fcron \
 && mkdir -p var/spool/fcron \
 && mkdir /fcrontabs \
 && mv fcron.conf etc/ \
 && chmod 644 etc/fcron.conf \
 && chown root:fcron etc/fcron.conf var/spool/fcron /fcrontabs \
 && chmod g+rwx var/spool/fcron/ /fcrontabs/ \
 && chmod +x /usr/local/bin/*

VOLUME ["/fcrontabs", "/usr/local/var/spool/fcron"]
WORKDIR /fcrontabs

ENV FCRON_COMMANDS="EXAMPLE_CMD_1" FCRON_ENV_VARS="EXAMPLE_ENV_1" \
 EXAMPLE_CMD_1='@ 1 echo $EXAMPLE_ENV_1' \
 EXAMPLE_ENV_1="success"

CMD ["/usr/local/bin/launch.sh"]