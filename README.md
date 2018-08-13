# ionic-docker

Docker nodejs and IONIC to run and developer mobile apps

## Getting Started

These instructions allow you to run a ionic docker and edit the source code from your own pc. You must have docker and docker-compose installed.

### Running

Clone this repo

```
git clone https://github.com/aosmorac/ionic-docker.git
```

Go to code folder 

```
cd ionic-docker
```

Run docker 

```
docker-compose up
```
Go into docker container

```
sudo docker exec -i -t ionic-mobile bash
```
### Check Base App

Go to an web explorer and open http://localhost:8100

### Note

You can edit your code and test it in a web browser, at this moment this docker has Android SDK but it is necessary to adjust its configuration to achieve run it directly in a device.