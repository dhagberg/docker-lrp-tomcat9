FROM svn.co811.org:5000/co811-java:latest
MAINTAINER D. J. Hagberg <dhagberg@millibits.com>

ENV CATALINA_HOME /usr/local/tomcat
ENV LOG4J2_VERS=2.17.1
ENV TOMCAT_VERS=8.5.78
ENV TOMCAT_SHA5=b50213e64cc1fd3da2847deda1ca13bee4c26663093c11d53c5ecfe4cdec8856e743b4a1d8488e0c0cbe9bf149e755df40a4140f3b155e2195e3bc6335de3512
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
