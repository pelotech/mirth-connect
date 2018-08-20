FROM java:8u111-jre-alpine

ENV MIRTH_CONNECT_VERSION 3.6.1.b220
ENV DATABASE_DRIVER derby
ENV DATABASE_URL "jdbc:derby:\${dir.appdata}/mirthdb;create=true"
ENV DATABASE_USERNAME ""
ENV DATABASE_PASSWORD ""

RUN \
  cd /tmp && \
  mkdir -p /opt && \
  wget http://downloads.mirthcorp.com/connect/$MIRTH_CONNECT_VERSION/mirthconnect-$MIRTH_CONNECT_VERSION-unix.tar.gz && \
  tar xvzf mirthconnect-$MIRTH_CONNECT_VERSION-unix.tar.gz -C /opt && \
  rm -f mirthconnect-$MIRTH_CONNECT_VERSION-unix.tar.gz && \
  mv /opt/Mirth\ Connect /opt/mirth-connect

#COPY mirthconnect-$MIRTH_CONNECT_VERSION-unix.tar.gz /tmp
#RUN \
#  cd /tmp && \
#  mkdir -p /opt && \
#  tar xvzf mirthconnect-$MIRTH_CONNECT_VERSION-unix.tar.gz -C /opt && \
#  rm -f mirthconnect-$MIRTH_CONNECT_VERSION-unix.tar.gz && \
#  mv /opt/Mirth\ Connect /opt/mirth-connect

WORKDIR /opt/mirth-connect

EXPOSE 8080 8443

COPY ./docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["java", "-jar", "mirth-server-launcher.jar"]