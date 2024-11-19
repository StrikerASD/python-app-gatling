FROM nextmetaphor/alpine-java

# Set the working directory
WORKDIR /gatling

# Copy the Java simulation
COPY LoadTest.java ./user-files/simulations/

# Default environment variable for the base URL
ENV BASE_URL="http://default-address"

# Default command to run the Gatling simulation
ENTRYPOINT ["gatling.sh", "-s", "LoadTest"]