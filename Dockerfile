FROM docker:18.09

RUN apk update
RUN apk -Uuv add bash ca-certificates openssl git openssh && \
    rm /var/cache/apk/*

# Install JQ
RUN apk -Uuv add jq && \
    rm /var/cache/apk/*

# Add the libs
ADD src/func.bash /usr/share/misc/func.bash

# Add the scripts
ADD src/dockerize-release.bash /usr/bin/dockerize-release
RUN chmod a+x /usr/bin/*-release