package org.acme.people.service;

import org.eclipse.microprofile.metrics.annotation.Counted;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class GreetingService {

    @Counted(name = "greetings", description = "How many greetings we've given.")
    public String greeting(String name) {
        return "hello " + name + " from the GreetingService";
    }

}
