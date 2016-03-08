## -*- docker-image-name: "scaleway/minecraft:latest" -*-
FROM scaleway/java:amd64-8
# following 'FROM' lines are used dynamically thanks do the image-builder
# which dynamically update the Dockerfile if needed.
#FROM scaleway/java:armhf-8       # arch=armv7l
#FROM scaleway/java:arm64-8       # arch=arm64
#FROM scaleway/java:i386-8        # arch=i386
#FROM scaleway/java:mips-8        # arch=mips


# Install deps
RUN apt-get update \
 && apt-get install -y \
    screen \
    python-pip \
    rdiff-backup \
    git \
    php5-cli \
 && pip2 install cherrypy==3.2.3 \
 && mkdir -p /usr/games/minecraft /var/games/minecraft \
 && git clone https://github.com/hexparrot/mineos /usr/games/minecraft


# Patch rootfs
COPY ./overlay /


# Build
WORKDIR /usr/games/minecraft
RUN git config core.filemode false \
 && chmod +x server.py mineos_console.py generate-sslcert.sh \
 && ln -s /usr/games/minecraft/mineos_console.py /usr/local/bin/mineos \
 && chmod 744 /etc/init.d/changepw \
 && update-rc.d changepw defaults \
 && cp /usr/games/minecraft/init/mineos /etc/init.d/ \
 && chmod 744 /etc/init.d/mineos \
 && update-rc.d mineos defaults \
 && cp /usr/games/minecraft/init/minecraft /etc/init.d/ \
 && chmod 744 /etc/init.d/minecraft \
 && update-rc.d minecraft defaults \
 && cp /usr/games/minecraft/mineos.conf /etc/ \
 && ./generate-sslcert.sh \
 && adduser --disabled-password --gecos '' admin \
 && echo 'admin:admin' | chpasswd \
 && groupadd minecraft \
 && usermod -a -G minecraft admin \
 && chgrp -R minecraft /usr/games/minecraft /var/games/minecraft \
 && chmod g+s /usr/games/minecraft /var/games/minecraft


# -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=4 -XX:+AggressiveOpts
# EXPOSE 8080
# EXPOSE 25565
