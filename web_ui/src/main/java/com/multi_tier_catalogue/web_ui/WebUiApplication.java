package com.multi_tier_catalogue.web_ui;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = "com.multi_tier_catalogue.web_ui")
public class WebUiApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(WebUiApplication.class, args);
	}

}
