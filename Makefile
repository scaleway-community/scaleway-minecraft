DOCKER_NAMESPACE =	armbuild/
NAME =			scw-app-minecraft
VERSION =		latest
VERSION_ALIASES =	1.0.0 1.0 1
TITLE =			Minecraft server
DESCRIPTION =		Minecraft server image using MineOS
SOURCE_URL =		https://github.com/scaleway/image-app-minecraft
SHELL_DOCKER_OPTS ?=    -p 25565:25565 8080:8080

## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk
## Below you can add custom Makefile commands and overrides
