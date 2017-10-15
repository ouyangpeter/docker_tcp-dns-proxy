FROM python:2.7.14-alpine3.6
WORKDIR /root
RUN set -ex && \
#    echo "http://mirrors.aliyun.com/alpine/v3.6/main/" > /etc/apk/repositories && \
#      mkdir ~/.pip && \
#      echo -e '[global]\ntrusted-host=mirrors.aliyun.com\nindex-url=http://mirrors.aliyun.com/pypi/simple/\n' > ~/.pip/pip.conf && \

    apk add --no-cache \
              --virtual TMP build-base \
                            git && \
      pip install --no-cache-dir -U \ 
              pip && \
      pip install --no-cache-dir -U \
              gevent \
              pylru && \

    git clone --depth=1 https://github.com/henices/Tcp-DNS-proxy.git && \
      cd Tcp-DNS-proxy && \
      git submodule update --init --recursive && \

    apk del --purge \
            TMP && \
    rm -rf \
           /root/.cache \
           /tmp/*
WORKDIR /root/Tcp-DNS-proxy
VOLUME /config
ENTRYPOINT ["python", "tcpdns.py"]
CMD ["-f", "/config/tcpdns.json"]
