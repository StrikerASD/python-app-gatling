FROM denvazh/gatling:latest

# Copy custom simulation files into the appropriate Gatling directory
COPY user-files /opt/gatling/user-files
COPY target /opt/gatling/target

# Ensure the Gatling binary is executable and set the working directory
WORKDIR /opt/gatling

# Define the entrypoint with an absolute path to the Gatling binary
ENTRYPOINT ["./bin/gatling.sh"]

# Default command to run a specific simulation
CMD ["-sf", "user-files/simulations", "-rf", "results", "-s", "LoadTest"]
