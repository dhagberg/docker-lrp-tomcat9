FROM cga-ci:5000/lrp-u-java:latest
LABEL org.opencontainers.image.authors="dhagberg@millibits.com"

ENV CATALINA_HOME=/usr/local/tomcat
# Check for latest release versions available at:
# https://dlcdn.apache.org/logging/log4j/
ENV LOG4J2_VERS=2.25.5
ENV LOG4J2_SHA5=d5f4f2625f18746b27e4ecd55634218ebad2e6de5ef1bcf53c19612960bd62a5aae7ff394df69f9c9bfd6a253d0310af13ed83fa53fbf22f031c696b5eefdcf6
# And https://tomcat.apache.org/download-90.cgi
ENV TOMCAT_VERS=9.0.123
ENV TOMCAT_SHA5=64b1130e719399c0a409e6996081433b16af8d9c89266c7aaa9849af70a1815feca91e13896f5ccc41451dc5759716d1c84882682de955822c30509de102f290
# And https://github.com/krallin/tini/releases
ENV TINI_VERS=0.19.0
ENV TINI_SHA5=e4645f3e2a0fdf013fd46f5658e092d86ac60f732bc79a1702c0025a5d1c29146bb99f3da22d420153727801584bfa3935e31cc761f00efc4b74e6165d9c7972
ENV PATH=$CATALINA_HOME/bin:$PATH

COPY build/ /root/build/
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

RUN /root/build/build_tomcat9 $BUILDTS

USER tomcat
EXPOSE 8080
CMD exec /usr/bin/tini $CATALINA_HOME/bin/catalina.sh run
