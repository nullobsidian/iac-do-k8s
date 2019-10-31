FROM alpine:latest

ARG USER=dev
ENV HOME /home/$USER
ENV DOCTL_VERSION "1.33.0"
ENV ANSIBLE_VERSION "2.8.6"
ENV TERRAFORM_VERSION "0.12.12"
ENV K8s_VERSION "1.15.5"

LABEL version="1.0.0"

RUN apk add --update \
    sudo \
    git \
    openssh-client openssh-keygen \
    openssl \
    ca-certificates \
    wget \
    curl \
    gettext \
    python \
    py-pip && \
    apk add --update --virtual build-dependencies \
    python-dev libffi-dev openssl-dev build-base && \
    pip install cffi --upgrade && \
    pip install ansible==${ANSIBLE_VERSION} --upgrade && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v${K8s_VERSION}/bin/linux/amd64/kubectl && \
    wget -P /tmp/ https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz && \
    wget -P /tmp/ https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    tar xf /tmp/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz && \
    mv doctl /usr/local/bin/doctl && \
    apk --purge del build-dependencies && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/tmp/* && \
    adduser -D $USER && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0400 /etc/sudoers.d/$USER

USER $USER
WORKDIR $HOME

VOLUME ["/home/$USER"]
