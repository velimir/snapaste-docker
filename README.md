# Snapaste Docker

Dockerfile for https://github.com/kstarikov/snapaste

> A snapping pastebin implementation. Whatever text data posted to it can only be accessed once.

## Usage

### Run prebuilt image

#### Generate ssl certificate

```bash
mkdir ssl
openssl req -x509 -nodes -newkey rsa:2048 \
        -keyout ./ssl/domain.key \
        -out ./ssl/domain.crt \
        -subj "/C=UK/ST=Wales/L=Cardiff/O=snapaste/CN=snapaste.com"
```

If you already have certificates just copy them to ssl directory or provide vaid certificates' path to docker.

#### Add snapaste config

```bash
cat > erl.config <<EOF
[{snapaste, [
    %% host and port for your site as seen from the outside world
    {host, "snapaste.com"},
    {port, 443},
    %% certificate file for your domain
    {certfile, "/usr/local/snapaste/ssl/domain.crt"},
    %% key file for your domain
    {keyfile, "/usr/local/snapaste/ssl/domain.key"}
]}].
EOF
```

#### Run docker container

The following command line maps incoming 443 to 443 port of `snapaste` container (make sure that erl.config has `{port, 443}`). Also it deletes `snapaste` container once it's stopped.

```sh
docker run --rm \
           -v "`pwd`/ssl:/usr/local/snapaste/ssl" \
           -v "`pwd`/erl.config:/usr/local/snapaste/config/erl.config" \
           --expose 443 \
           -p 443:443 \
           --name snapaste \
           velimir/snapaste
```

### Build and use your own image

```sh
git clone git@github.com:velimir0xff/snapaste-docker.git
cd snapaste-docker
git submodule update --init
docker build .
docker tag <image id from build step> <your docker accont>/snapaste
docker push <your docker accont>/snapaste
```

Then go to section [how to use image](#run-prebuilt-image) and replace all `velimir/snapaste` with name of your image.
