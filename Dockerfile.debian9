FROM	debian:9
LABEL	maintainer="Alexandre Buisine <alexandrejabuisine@gmail.com>"
LABEL	version "4.1.1"

# This container should be built with the --squash option in order to avoid huge containers

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
 && apt-get -yqq install \
 	gcc \
 	make \
 	ssmtp \
 	vim-tiny \
 && apt-get -yqq clean \
 && rm -rf /var/lib/apt/lists/*

ENV FCRON_VERSION="3.2.1"

# Dockerfile will auto gunzip but will not auto untar
WORKDIR /tmp
ADD http://fcron.free.fr/archives/fcron-${FCRON_VERSION}.src.tar.gz fcron.tar
RUN tar -xf fcron.tar \
	&& cd fcron-${FCRON_VERSION} \
	&& ./configure \
	&& make \
	&& make install

RUN DEBIAN_FRONTEND=noninteractive apt-get -y -qq remove --purge \
 	gcc \
 	make \
 && apt-get -y autoremove --purge

ADD https://github.com/kreuzwerker/envplate/releases/download/v0.0.8/ep-linux /usr/local/bin/ep

COPY resources/launch.sh /usr/local/bin/launch.sh
COPY resources/environ_bash.sh /usr/local/bin/environ_bash.sh
COPY resources/fcron.conf /usr/local/etc/fcron.conf

RUN mkdir /fcrontabs \
 && chown root:fcron /usr/local/etc/fcron.conf /fcrontabs \
 && chmod 644 /usr/local/etc/fcron.conf /fcrontabs

RUN chmod +x /usr/local/bin/*

VOLUME ["/fcrontabs", "/usr/local/var/spool/fcron"]
WORKDIR /fcrontabs

ENV FCRON_COMMANDS="EXAMPLE_CMD_1" \
	EXAMPLE_CMD_1='@ 1 echo $PATH'

CMD ["/usr/local/bin/launch.sh"]