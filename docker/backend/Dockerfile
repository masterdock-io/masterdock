FROM python:3.9.18-bullseye

LABEL maintainer "Wazzup Inc. - Keisuke Mutoh <kmutoh@wazzup.jp>"

##############################################################################
# apt update
RUN apt update

###############################################################################
# install sudo
RUN apt-get install -y sudo

###############################################################################
# install git
RUN apt-get -y install git

###############################################################################
# install misc packages
RUN apt-get install -y cron unzip procps wget vim certbot sqlite3

###############################################################################
# add sudoer user
ARG BACKEND_USER
ENV BACKEND_USER=${BACKEND_USER}
ARG BACKEND_USER_ID
ENV BACKEND_USER_ID=${BACKEND_USER_ID}
ARG BACKEND_GROUP
ENV BACKEND_GROUP=${BACKEND_GROUP}
ARG BACKEND_GROUP_ID
ENV BACKEND_GROUP_ID=${BACKEND_GROUP_ID}
ARG BACKEND_USER_PASSWORD
ENV BACKEND_USER_PASSWORD=${BACKEND_USER_PASSWORD}

RUN groupadd -g ${BACKEND_GROUP_ID} ${BACKEND_GROUP} && \
    useradd  -g ${BACKEND_GROUP} -u ${BACKEND_USER_ID} -G sudo -m -s /bin/bash ${BACKEND_USER} && \
    echo ${BACKEND_USER}:${BACKEND_USER_PASSWORD} | chpasswd

RUN echo 'Defaults visiblepw' >> /etc/sudoers
ARG sudostr0=' ALL=(ALL) NOPASSWD:ALL'
ARG sudostr=$BACKEND_USER$sudostr0
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

USER ${BACKEND_USER}
RUN echo 'export BACKEND_USER_PASSWORD=""' >> ~/.bashrc

###############################################################################
# prepare entrypoint script
USER root
COPY entrypoint.sh /home/${BACKEND_USER}/
RUN chown ${BACKEND_USER}:${BACKEND_GROUP} /home/${BACKEND_USER}/entrypoint.sh
RUN chmod a+x /home/${BACKEND_USER}/entrypoint.sh

###############################################################################
# Finish!
ARG BACKEND_PATH
ENV BACKEND_PATH=${BACKEND_PATH}

USER ${BACKEND_USER}
WORKDIR ${BACKEND_PATH}
