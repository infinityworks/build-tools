FROM alpine:3.8

LABEL maintainer="Infinity Works"

RUN apk add --update --no-cache bash && \
    sed -i 's/bin\/ash/bin\/bash/' /etc/passwd

RUN apk add --update --no-cache \
    python \
    py-pip \
    groff \
    jq \
    ca-certificates \
    nodejs \
    curl \
    git \
    zip \
    openssh-client \
    docker && \
    pip install --upgrade awscli docker-compose && \
    apk -v --purge del py-pip && \
    curl -o- -L https://yarnpkg.com/install.sh | bash

ENV PATH="~/.yarn/bin:~/.config/yarn/global/node_modules/.bin:/scripts:$PATH"

COPY ./scripts /scripts/

CMD ["/bin/bash"]
