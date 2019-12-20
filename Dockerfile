FROM dhagberg/co811-java:latest
MAINTAINER D. J. Hagberg <dhagberg@millibits.com>

ENV CATALINA_HOME /usr/local/tomcat
ENV TOMCAT_VERS=8.5.50
ENV TOMCAT_SHA5=ffca86027d298ba107c7d01c779318c05b61ba48767cc5967ee6ce5a88271bb6ec8eed60708d45453f30eeedddcaedd1a369d6df1b49eea2cd14fa40832cfb90
ENV TINI_VERS=0.18.0
ENV TINI_SHA5=fc8c522484613c57ed6532924f399d7b10851cf019bc687febe3ba7a77911ed2bc3aaf708a3b074a7a339bca00bccbcd99d72d15b5c3229a48cf4683c9501bc9
ENV PATH $CATALINA_HOME/bin:$PATH

COPY build/ /root/build/
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

RUN /root/build/build_tomcat85 $BUILDTS

USER tomcat
EXPOSE 8080
CMD exec /usr/bin/tini $CATALINA_HOME/bin/catalina.sh run
