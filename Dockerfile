FROM svn.co811.org:5000/co811-java:latest
MAINTAINER D. J. Hagberg <dhagberg@millibits.com>

ENV CATALINA_HOME /usr/local/tomcat
ENV TOMCAT_VERS=8.5.70
ENV TOMCAT_SHA5=10d306a2ea27e10b914556678763e2b1295ffdaa3da042db586d39b9ab95640bd3e1b81627f96c61f400f2db98a7d4b4bbdf21dc3238c8d0025bf95b08f2f61c
ENV TINI_VERS=0.19.0
ENV TINI_SHA5=3de06fb0a8a1fdc06f48c1933b474c965242292a02b8fa0bb85fe90678c33bb35962ab239dd7000f8bcae841045d6660bbd6846414b0a07982c4dbfb2c2bd1cc
ENV PATH $CATALINA_HOME/bin:$PATH

COPY build/ /root/build/
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

RUN /root/build/build_tomcat85 $BUILDTS

USER tomcat
EXPOSE 8080
CMD exec /usr/bin/tini $CATALINA_HOME/bin/catalina.sh run
