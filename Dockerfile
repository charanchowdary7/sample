FROM <company>/centos:7

LABEL maintainer="example@gmail.com"

LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40
ENV SPLUNK_HOME /opt/splunk

ENV SPLUNK_PRODUCT universalforwarder

ENV SPLUNK_VERSION 6.5.2

ENV SPLUNK_GROUP splunk

ENV SPLUNK_USER splunk

ENV SPLUNK_BACKUP_DEFAULT_ETC /var/opt/splunk


COPY base.repo /etc/yum.repos.d/

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod +x /sbin/entrypoint.sh

ADD http://repo .  <company>   /walmart/splunk/splunkforwarder/6.5.2/splunkforwarder-6.5.2.rpm splunk/

RUN rpm -ivh /splunk/splunkforwarder-6.5.2.rpm && \
    /opt/splunkforwarder/bin/splunk enable boot-start --accept-license

EXPOSE 8000/tcp 8089/tcp 8191/tcp 9997/tcp 1514 8088/tcp 

WORKDIR /opt/splunk

VOLUME [ "/opt/splunk/etc", "/opt/splunk/var" ]

ENTRYPOINT ["/sbin/entrypoint.sh"]
