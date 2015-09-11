# Minecraft image on Scaleway

[![Travis](https://img.shields.io/travis/scaleway-community/scaleway-minecraft.svg)](https://travis-ci.org/scaleway-community/scaleway-minecraft)
[![Scaleway ImageHub](https://img.shields.io/badge/ImageHub-view-ff69b4.svg)](https://hub.scaleway.com/minecraft.html)

Scripts to build the official Minecraft image on Scaleway

This image is built using [Image Tools](https://github.com/scaleway/image-tools) and depends on the official [Java](https://github.com/scaleway-community/scaleway-java) image.


![banner](https://pbs.twimg.com/media/COYa28cWgAE_Ngg.png:medium)


---

**This image is meant to be used on a C1 server.**

We use the Docker's building system and convert it at the end to a disk image that will boot on real servers without Docker. Note that the image is still runnable as a Docker container for debug or for inheritance.

[More info](https://github.com/scaleway/image-tools)


---

## How to connect to your C1 server

See the [documentation](https://www.scaleway.com/docs/create-and-connect-to-your-server/) to connect your to your C1 server.

## Install

Build and write the image to /dev/nbd1 (see [documentation](https://www.scaleway.com/docs/create_an_image_with_docker))

    $ make install

Full list of commands available at: [scaleway/image-tools](https://github.com/scaleway/image-tools/#commands)

---

A project by [![Scaleway](https://avatars1.githubusercontent.com/u/5185491?v=3&s=42)](https://www.scaleway.com/)
