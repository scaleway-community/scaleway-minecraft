FROM vikbez/armhf-ubuntu-oraclejava

RUN mkdir /minecraft
WORKDIR /minecraft
RUN wget -q --no-check-certificate "https://s3.amazonaws.com/Minecraft.Download/versions/1.7.9/minecraft_server.1.7.9.jar" -O mcserv.jar
CMD java -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=4 -XX:+AggressiveOpts -Xms1536M -Xmx1536M -jar mcserv.jar nogui

EXPOSE 25565
