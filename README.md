# perkeep-docker

A multistage docker build for [Perkeep].  Final image is under 50MB.

## Configuration

 - Create ~/perkeep/config
 - Copy identity-secring.gpg into ^
 - Copy server-config.json ^ 
 - Create Google Cloud Storage bucket
 - Create Google Cloud Platform service account https://cloud.google.com/iam/docs/creating-managing-service-accounts#creating
 - Set GOOGLE_APPLICATION_CREDENTIALS path in run-perkeep.sh
 - Set googlecloudstorage key in configuration block to ':bucket-name/blobs'
 - Set PERKEEP_REF in Dockerfile, I prefer a commit reference rather than a tag or master.

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
