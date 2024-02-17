FROM postgres:16.1

LABEL maintainer "Wazzup Inc. - Keisuke Mutoh <kmutoh@wazzup.jp>"

###############################################################################
# apt update
RUN apt update

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

