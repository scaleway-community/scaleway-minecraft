FROM armbuild/scw-app-java:latest

RUN apt-get update \
 && apt-get install -y \
    screen \
    python-pip \
    rdiff-backup \
    git \
    php5-cli \
 && pip2 install cherrypy==3.2.3 \
 && mkdir -p /usr/games/minecraft /var/games/minecraft \
 && git clone https://github.com/hexparrot/mineos /usr/games/minecraft \
 && ln -s /opt/java/jdk1.8.0_33/bin/java /usr/bin/java # fix this better

COPY ./patches/etc/init.d/changepw /etc/init.d/changepw
COPY ./patches/root/changepw/index.php /root/changepw/index.php
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
