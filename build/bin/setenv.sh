# Need to specify log4j2 config file using system property
CATALINA_OPTS="${CATALINA_OPTS} -Dlog4j2.configurationFile=$CATALINA_HOME/log4j2/log4j2-tomcat.xml"

# https://www.lunasec.io/docs/blog/log4j-zero-day/ Log4Shell CVE-2021-44228:
CATALINA_OPTS="${CATALINA_OPTS} -Dlog4j2.formatMsgNoLookups=true"

# Override JUL Log Manager to use log4j2
LOGGING_MANAGER="-Djava.util.logging.manager=org.apache.logging.log4j.jul.LogManager"

# Log4j2 jars need to be in system classpath
LOG4J2_JARS=$(find $CATALINA_HOME/log4j2 -type f -name '*.jar' -print | tr '\n' ':' | sed -e 's/:$//')
if [ -z "$CLASSPATH" ]; then
    CLASSPATH="$LOG4J2_JARS"
else
    CLASSPATH="${CLASSPATH}:$LOG4J2_JARS"
fi
