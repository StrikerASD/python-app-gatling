FROM openjdk:11-jdk-slim

# Instalacja wget
RUN apt-get update && apt-get install -y wget unzip && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV GATLING_VERSION 3.7.4
RUN mkdir -p /opt/gatling && \
    cd /opt/gatling && \
    wget -q -O gatling.zip https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/${GATLING_VERSION}/gatling-charts-highcharts-bundle-${GATLING_VERSION}-bundle.zip && \
    unzip gatling.zip && \
    rm gatling.zip && \
    mv /opt/gatling/gatling-charts-highcharts-bundle-${GATLING_VERSION}/* /opt/gatling && \
    rm -rf /opt/gatling/gatling-charts-highcharts-bundle-${GATLING_VERSION}

ENV GATLING_HOME /opt/gatling

COPY ./simulations /opt/gatling/user-files/simulations

WORKDIR /opt/gatling

RUN ls -l /opt/gatling/lib
RUN echo "Kompilacja LoadTest.java" && \
    javac -cp "/opt/gatling/lib/*" /opt/gatling/user-files/simulations/LoadTest.java && \
    ls -l /opt/gatling/user-files/simulations
RUN chmod -R 755 /opt/gatling/user-files/simulations

ENTRYPOINT ["bash"]

#ENTRYPOINT ["java", "-cp", "/opt/gatling/lib/*:/opt/gatling/user-files/simulations", "simulations.LoadTest"]