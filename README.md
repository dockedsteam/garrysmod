# Garry's Mod Docker

This is an unofficial Docker-Image for running a Garry's Mod Server in a container. The image is reduced to the minimum requirements for a playable server and is fully customizable.

## Getting started

1. Pull the image from DockerHub using `docker pull dockedsteam/garrysmod:latest`
2. Run the image

   ```shell
   docker run -it \
              -v /path/on/machine:/home/steam/gmod \
              -e GAMEMODE=terrortown \
              -e WORKSHOP_COLLECTION=<Workshop Collection Id> \
              -e MAP=ttt_minecraft_b5 \
              dockedsteam/garrysmod:latest
   ```

   _You might want to adjust the run command to fit your needs._

## Environment

There are several environment variables present for configuring the server.  For configuring the game mode  (e.g. TTT) follow the next section about game mode configuration.

| Key   | Default | Example |
| --- | --- | --- |
| PORT | 27015 | |
| MAX_PLAYERS | 16 |
| MAP |  gm_flatgrass | ttt_minecraft_b5 |
| GAMEMODE | sandbox | terrortown |
| WORKSHOP_COLLECTION | | |
| WORKSHOP_COLLECTION_AUTH_KEY | | |

## Game Mode Configuration

If not already done, mount the game directory using `-v /path/on/machine:/home/steam/gmod` when running the image.
You can now adjust the server.cfg configuration located in the `<Garry's Mod path on machine>/garrysmod/cfg/` folder.
You might also want to directly bind yout server configuration.
