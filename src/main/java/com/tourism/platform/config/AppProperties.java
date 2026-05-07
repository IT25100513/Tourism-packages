package com.tourism.platform.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.nio.file.Path;

@Configuration
public class AppProperties {

    @Bean
    public Path dataDirectory(@Value("${app.data.directory:data}") String dir) {
        return Path.of(dir).toAbsolutePath().normalize();
    }
}
