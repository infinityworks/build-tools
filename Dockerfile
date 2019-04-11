FROM debian:stretch

LABEL maintainer="Infinity Works"

RUN apt-get update && \
    apt-get install -y curl python python-pip && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -sS https://download.docker.com/linux/debian/gpg | apt-key add - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee -a /etc/apt/sources.list.d/docker.list && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-cache policy docker-ce yarn && \
    apt-get install -y nodejs jq git zip docker-ce yarn && \
    pip install awscli docker-compose && \
    apt-get -y --purge autoremove && \
    rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/*

ENV PATH="~/.yarn/bin:~/.config/yarn/global/node_modules/.bin:/scripts:$PATH"

COPY ./scripts /scripts/

CMD ["/bin/bash"]
