FROM ghcr.io/gythialy/mdcx-base:latest

# Set environment variables.
ENV APP_NAME="MDCX" \
    USER_ID=0 \
    GROUP_ID=0 \
    LANG=zh_CN.UTF-8 \
    TZ=Asia/Shanghai

ADD app /app
COPY config.sample.ini /app/
COPY 11-app-init.sh /etc/cont-init.d/

WORKDIR /app

EXPOSE 5800 5900

RUN python3.9 -m pip install --no-cache-dir -r requirements.txt && \
    # -i https://pypi.douban.com/simple
    set-cont-env APP_VERSION "$(cat /app/version)" && \
    set-cont-env DOCKER_IMAGE_VERSION "v1.0.$(cat /app/version)"

COPY startapp.sh /startapp.sh
