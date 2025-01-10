package simulations;

import io.gatling.javaapi.core.*;
import io.gatling.javaapi.http.*;

import java.time.Duration;

import static io.gatling.javaapi.core.CoreDsl.*;
import static io.gatling.javaapi.http.HttpDsl.*;

public class LoadTest extends Simulation {

    // Base URL from environment variable or default to localhost
    private static final String BASE_URL = System.getenv("BASE_URL") != null 
                                           ? System.getenv("BASE_URL") 
                                           : "http://localhost:8080";

    // Define the HTTP protocol configuration
    HttpProtocolBuilder httpProtocol = http
            .baseUrl(BASE_URL)
            .acceptHeader("application/json")
            .contentTypeHeader("application/json");

    // Scenario to test GET method
    ScenarioBuilder getScenario = scenario("GET Endpoint Test")
            .exec(
                    http("GET Request")
                            .get("/") // Target the root endpoint
                            .check(status().is(200)) // Check for 200 status
            );

    // Scenario to test POST method
    ScenarioBuilder postScenario = scenario("POST Endpoint Test")
            .exec(
                    http("POST Request")
                            .post("/echo") // Target the /echo endpoint
                            .body(StringBody("{\"key\":\"value\"}")).asJson() // Send JSON payload
                            .check(status().is(200)) // Check for 200 status
            );

    // Set up the simulation
    {
        setUp(
                getScenario.injectOpen(rampUsers(10).during(Duration.ofSeconds(10))), // Ramp up 10 users over 10 seconds
                postScenario.injectOpen(rampUsers(10).during(Duration.ofSeconds(10))) // Ramp up 10 users over 10 seconds
        ).protocols(httpProtocol);
    }
}
