FROM alpine:3.20.2

COPY --chown=1000:1000 entrypoint.sh /

RUN addgroup -g 1000 alpine && adduser -u 1000 -s /bin/sh -D -G alpine alpine && \
    chmod u+x /entrypoint.sh && \
    apk add --no-cache bash \
                       curl \
                       openssl \
                       mysql-client \
                       mariadb-connector-c \
                       mongodb-tools \
                       postgresql15-client \
                       pgloader \
                       openssh-client \
                       redis \
                       screen \
                       7zip \
                       lftp \
                       && \
    apk add --no-cache perl \
                       perl-io-socket-ssl \
                       perl-digest-hmac \
                       perl-term-readkey \
                       perl-mime-lite \
                       perl-io-socket-inet6 \
                       perl-net-dns \
#                       perl-file-libmagic \
                       && \
    curl -fsSLo /usr/local/bin/smtp-cli https://raw.githubusercontent.com/mludvig/smtp-cli/v3.10/smtp-cli && \
# install azcopy
    apk add --no-cache libc6-compat && \
    curl -fsSL https://aka.ms/downloadazcopy-v10-linux | tar -C /usr/local/bin -oxvzf - --strip-components=1 --exclude '*/*.*' && \
    chmod +x /usr/local/bin/azcopy && \
# suppress warning of missing File::LibMagic module
    sed -i 's/missing_modules_ok = 0/missing_modules_ok = 1/' /usr/local/bin/smtp-cli && \
    chmod +x /usr/local/bin/smtp-cli && \
    rm -rf /apk /tmp/* /var/cache/apk/* /sbin/*

USER alpine

ENTRYPOINT ["/entrypoint.sh"]
CMD []