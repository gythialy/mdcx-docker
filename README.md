# mdcx-docker
🐳 A docker image to run [MDCX](https://github.com/anyabc/something) in one step.

## Docker

```bash
docker run -d \
  -e DISPLAY_WIDTH=1080 \
  -e DISPLAY_HEIGHT=1920 \
  -e VNC_PASSWORD=1234 \
  --name mdcx \
  --restart unless-stopped \
  -p 5800:5800 \
  -p 5900:5900 \
  -v /path/to/data1:/data1 \
  -v /path/to/data2:/data2 \
  -v $(PWD)/config.ini:/app/config.ini
  ghcr.io/gythialy/mdcx:latest
```

## Docker-compose 

```yaml
version: '3'

services:
  mdcx:
    image: ghcr.io/gythialy/mdcx:latest
    container_name: mdcx
    volumes:
      - /path/to/data1:/data1
      - /path/to/data2:/data2
      - ./config.ini:/app/config.ini
    environment:
      - DISPLAY_HEIGHT=1920
      - DISPLAY_WIDTH=1080
      - VNC_PASSWORD=1234
    ports:
      - 5800:5800
      - 5900:5900
    restart: unless-stopped
    network_mode: bridge
    stdin_open: true
```

## 使用
- 任意 VNC 客户端：`<HOST IP ADDR>:5900`
- 浏览器： `http://<HOST IP ADDR>:5800`
- 更多环境变量，请查看 [Public Environment Variables
](https://github.com/jlesage/docker-baseimage-gui#public-environment-variables)