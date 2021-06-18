package io.pivotal.pal.tracker.backlog;

import io.pivotal.pal.tracker.projects.ProjectEventListener;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.client.RestOperations;

import java.util.TimeZone;


@SpringBootApplication
@ComponentScan({"io.pivotal.pal.tracker.backlog", "io.pivotal.pal.tracker.restsupport"})
public class App {

    public static void main(String[] args) {
        TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
        SpringApplication.run(App.class, args);
    }

    @Bean
    ProjectEventListener projectEventListener() {
        return new ProjectEventListener();
    }

    //TODO set up listener
}
