# Copyright (c) Forge
# SPDX-License-Identifier: MPL-2.0

FROM docker.io/library/debian:trixie

RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        locales \
        systemd \
        systemd-sysv \
        sudo \
        ssh

RUN apt-get clean

RUN rm -Rf /var/lib/apt/lists/*
RUN rm -Rf /usr/share/doc
RUN rm -Rf /usr/share/man

RUN locale-gen en_US.UTF-8

RUN rm -rf /usr/lib/python3.12/EXTERNALLY-MANAGED

RUN rm -rf /sbin/init
RUN ln -s /lib/systemd/systemd /sbin/init

RUN rm -f /lib/systemd/system/multi-user.target.wants/getty.target

RUN systemctl enable ssh

RUN useradd -m forge
RUN echo "forge ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "forge:forge" | chpasswd

EXPOSE 22

CMD ["/sbin/init"]
