## Snapaste Docker

Dockerfile for https://github.com/kstarikov/snapaste

> A snapping pastebin implementation. Whatever text data posted to it can only be accessed once.

### Usage

#### Clone repository

```bash
git clone git@github.com:velimir0xff/snapaste-docker.git
cd snapaste-docker
```

#### Generate ssl certificate

```bash
mkdir ssl
openssl req -x509 -nodes -newkey rsa:2048 \
        -keyout ./ssl/domain.key \
        -out ./ssl/domain.crt \
        -subj "/C=UK/ST=Wales/L=Cardiff/O=snapaste/CN=snapaste.com"
```

#### Tweak snapaste config

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

```sh
docker run -v "`pwd`/ssl:/usr/local/snapaste/ssl" \
           -v "`pwd`/erl.config:/usr/local/snapaste/config/erl.config" \
           velimir/snapaste
```
