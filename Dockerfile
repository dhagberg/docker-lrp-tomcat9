FROM cga-ci:5000/lrp-u-java:latest
MAINTAINER D. J. Hagberg <dhagberg@millibits.com>

ENV CATALINA_HOME=/usr/local/tomcat
ENV LOG4J2_VERS=2.24.3
ENV LOG4J2_SHA5=ea103f64b8d04436be4768ba53c08b4909c761a30bbf0b7fe155eb3db6dafae46d73ad4d86e9786b35f69d35ea90727ec9184cee256a0f9274b9ab2b56ed02a8
ENV TOMCAT_VERS=9.0.104
ENV TOMCAT_SHA5=b387fae59f1eda13a5c2336243514d9568057815689057ff920be696548ea6afbcfc0933934d3d6f8c4e2b5108322dc7509bfe934c49d05905c6ce87f1dff53c
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
