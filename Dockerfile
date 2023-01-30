FROM ghcr.io/gythialy/mdcx-base:latest

ENV USER_ID         0
ENV GROUP_ID        0
ENV ENABLE_CJK_FONT 1
ENV LANG            zh_CN.UTF-8
ENV TZ              Asia/Shanghai

ADD app /app

WORKDIR /app

EXPOSE 5800 5900

RUN python3.9 -m pip install --no-cache-dir -r requirements.txt 
    # -i https://pypi.douban.com/simple

COPY startapp.sh /startapp.sh