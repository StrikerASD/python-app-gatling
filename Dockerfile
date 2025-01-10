# Używamy jdk zamiast jre, aby mieć dostęp do javac
FROM openjdk:11-jdk-slim

# Install Gatling
ENV GATLING_VERSION 3.7.4
RUN mkdir -p /opt/gatling && \
    cd /opt/gatling && \
    wget -q -O gatling.zip https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/${GATLING_VERSION}/gatling-charts-highcharts-bundle-${GATLING_VERSION}-bundle.zip && \
    unzip gatling.zip && \
    rm gatling.zip && \
    mv /opt/gatling/gatling-charts-highcharts-bundle-${GATLING_VERSION}/* /opt/gatling && \
    rm -rf /opt/gatling/gatling-charts-highcharts-bundle-${GATLING_VERSION}

# Set Gatling home
ENV GATLING_HOME /opt/gatling

# Copy Gatling project
COPY ./simulations /opt/gatling/user-files/simulations

# Set working directory
WORKDIR /opt/gatling

# Compile Java files
RUN javac -cp "/opt/gatling/lib/*" /opt/gatling/user-files/simulations/LoadTest.java

# Entrypoint to run Gatling
# Zakładając, że LoadTest.java jest w pakiecie simulations
ENTRYPOINT ["java", "-cp", "/opt/gatling/lib/*:/opt/gatling/user-files/simulations", "simulations.LoadTest"]