cd /app
echo java -javaagent:/usr/local/newrelic/newrelic.jar -Dnewrelic.config.license_key=${NEW_RELIC_LICENCE_KEY} -Dnewrelic.config.app_name=shipping -XX:MaxRAMPercentage=90 -jar /app/shipping.jar >/app/out
java -javaagent:/usr/local/newrelic/newrelic.jar -Dnewrelic.config.license_key=${NEW_RELIC_LICENCE_KEY} -Dnewrelic.config.app_name=shipping -XX:MaxRAMPercentage=90 -jar /app/shipping.jar

