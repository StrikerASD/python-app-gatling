FROM denvazh/gatling:latest

# Copy custom simulation files into the appropriate Gatling directory
COPY user-files /opt/gatling/user-files
COPY target /opt/gatling/target

# Ensure the Gatling binary is executable and set the working directory
WORKDIR /opt/gatling

# Define entrypoint and default command
ENTRYPOINT ["/opt/gatling/bin/gatling.sh"]
CMD ["-sf", "user-files/simulations", "-rf", "results", "-s", "LoadTest"]

# Default command to run a specific simulation

