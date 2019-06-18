FROM docker:18.09

RUN apk update
RUN apk add bash ca-certificates

# Install aws-cli for S3 endpoints
RUN apk -Uuv add groff less python py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip && \
    rm /var/cache/apk/*

# Install SSH for SFTP endpoints
RUN apk -Uuv add openssh && \
    rm /var/cache/apk/*

# Install JQ
RUN apk -Uuv add jq && \
    rm /var/cache/apk/*

# Add the libs
ADD src/func.bash /usr/share/misc/func.bash

# Add the scripts
ADD src/dockerize-release.bash /usr/bin/dockerize-release
RUN chmod a+x /usr/bin/*-release