FROM vikbez/armhf-ubuntu-oraclejava

RUN mkdir /minecraft
WORKDIR /minecraft

ENV VERSION 1.8
ENV MEMORY 1546

ADD server.properties /minecraft/server.properties

RUN echo "eula=true" > eula.txt

RUN wget -q --no-check-certificate "https://s3.amazonaws.com/Minecraft.Download/versions/${VERSION}/minecraft_server.${VERSION}.jar" -O mcserv.jar
CMD java -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=4 -XX:+AggressiveOpts -Xms${MEMORY}M -Xmx${MEMORY}M -jar mcserv.jar nogui

EXPOSE 25565
