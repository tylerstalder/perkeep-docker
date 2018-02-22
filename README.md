# perkeep-docker

A multistage docker build for [Perkeep].  Final image is under 50MB.

## Docker Hub

This container is available as an automated build on [Docker Hub]:

- stable/master: `docker pull jhillyerd/perkeep:stable`
- latest/develop: `docker pull jhillyerd/perkeep:latest`

## Building

To build and run the container locally:

    git clone https://github.com/jhillyerd/perkeep-docker
    cd perkeep-docker
    docker build -t perkeep . # creates image perkeep:latest
    ./run-container.sh

This will create `$HOME/perkeep/config` and `$HOME/perkeep/storage`.  You should
then be able to access http://localhost:3179/ with user/pass:
`perkeep`/`perkeep`.

## Deploying

### Volumes

- `/config` Perkeep daemon configuration, PGP key
- `/storage` Blob storage

You will need to map these volumes if you wish Perkeep to be persisted between
container restarts.

During its first start, the container will create `/config/server-config.json`
which you will need to edit to customize your username and password.

### Ports

- `3179/tcp` Perkeep's HTTP interface.


[Docker Hub]: https://hub.docker.com
[Perkeep]:    https://perkeep.org
