FROM node:lts-bullseye

LABEL maintainer "Wazzup Inc. - Keisuke Mutoh <kmutoh@wazzup.jp>"

##############################################################################
# install quasar-cli
RUN npm i -g @quasar/cli@latest

##############################################################################
# apt update
RUN apt update

###############################################################################
# install sudo
RUN apt install -y sudo

###############################################################################
# install git
RUN apt install -y git

###############################################################################
# install some packages for a headless e2e testing of cypress
RUN apt install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libnss3 libxss1 libasound2 libxtst6 xauth xvfb

###############################################################################
# install misc packages
RUN apt install -y cron unzip procps wget vim certbot sqlite3

###############################################################################
# add sudoer user
ARG FRONT_USER
ENV FRONT_USER=${FRONT_USER}
ARG FRONT_USER_ID
ENV FRONT_USER_ID=${FRONT_USER_ID}
ARG FRONT_GROUP
ENV FRONT_GROUP=${FRONT_GROUP}
ARG FRONT_GROUP_ID
ENV FRONT_GROUP_ID=${FRONT_GROUP_ID}
ARG FRONT_USER_PASSWORD
ENV FRONT_USER_PASSWORD=${FRONT_USER_PASSWORD}

RUN usermod -u 8888 node
RUN groupmod -g 8888 node

RUN groupadd -g ${FRONT_GROUP_ID} ${FRONT_GROUP} && \
    useradd  -g ${FRONT_GROUP} -u ${FRONT_USER_ID} -G sudo -m -s /bin/bash ${FRONT_USER} && \
    echo ${FRONT_USER}:${FRONT_USER_PASSWORD} | chpasswd

RUN echo 'Defaults visiblepw' >> /etc/sudoers
ARG sudostr0=' ALL=(ALL) NOPASSWD:ALL'
ARG sudostr=$FRONT_USER$sudostr0
RUN echo $sudostr
RUN echo ${sudostr} >> /etc/sudoers

###############################################################################
# set environments
ARG SYS_LOCALE
ENV SYS_LOCALE=${SYS_LOCALE}
ARG SYS_CHARSET
ENV SYS_CHARSET=${SYS_CHARSET}
ARG SYS_TIMEZONE
ENV SYS_TIMEZONE=${SYS_TIMEZONE}

###############################################################################
# change Timezone
RUN cp /usr/share/zoneinfo/${SYS_TIMEZONE} /etc/localtime

###############################################################################
# change Locale
RUN apt install -y locales
RUN rm -rf /var/lib/apt/lists/*
RUN echo "$SYS_LOCALE $SYS_CHARSET" > /etc/locale.gen
RUN locale-gen ${SYS_LOCALE}
ENV LC_ALL ${SYS_LOCALE}
ENV LANG ${SYS_LOCALE}
ENV LANGUAGE ""

USER ${FRONT_USER}
RUN echo 'export FRONT_USER_PASSWORD=""' >> ~/.bashrc

###############################################################################
# prepare entrypoint script
USER root
COPY entrypoint.sh /home/${FRONT_USER}/
RUN chown ${FRONT_USER}:${FRONT_GROUP} /home/${FRONT_USER}/entrypoint.sh
RUN chmod a+x /home/${FRONT_USER}/entrypoint.sh

###############################################################################
# Finish!
ARG FRONT_PATH
ENV FRONT_PATH=${FRONT_PATH}

USER ${FRONT_USER}
WORKDIR ${FRONT_PATH}