FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp


RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    ca-certificates \
    autoconf \
    gcc \
    make \
    unzip \
    wget \
    apache2 \
    php \
    libapache2-mod-php \
    libgd-dev \
    libssl-dev \
    daemon \
    libperl-dev \
    libnet-snmp-perl \
    libmysqlclient-dev \
    curl && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN useradd nagios && \
    groupadd nagcmd && \
    usermod -a -G nagcmd nagios && \
    usermod -a -G nagcmd www-data


RUN wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.5.9.tar.gz && \
    tar -xzf nagios-4.5.9.tar.gz && \
    cd nagios-4.5.9 && \
    ./configure --with-command-group=nagcmd && \
    make all && \
    make install && \
    make install-commandmode && \
    make install-init && \
    make install-config && \
    make install-webconf && \
    htpasswd -cb /usr/local/nagios/etc/htpasswd.users nagiosadmin nagios && \
    cd .. && rm -rf nagios-4.5.9*


RUN a2enmod rewrite cgi


EXPOSE 80


CMD ["sh", "-c", "service apache2 start && /usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg && tail -f /dev/null"]

