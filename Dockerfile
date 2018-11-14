FROM alpine:3.8

LABEL maintainer="Infinity Works"

RUN apk add --update --no-cache \
    python \
    py-pip \
    groff \
    jq \
    ca-certificates \
    nodejs \
    yarn \
    git \
    zip \
    openssh-client \
    docker && \
    pip install --upgrade awscli && \
    apk -v --purge del py-pip
