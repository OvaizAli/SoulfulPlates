package com.Group11.soulfulplates;

import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootApplication
public class Group11SoulfulPlates implements ApplicationRunner {

	private final JdbcTemplate jdbcTemplate;

	public Group11SoulfulPlates(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public static void main(String[] args) {
		SpringApplication.run(Group11SoulfulPlates.class, args);
	}

	@Override
	public void run(ApplicationArguments args) throws Exception {
		if (isTableEmpty("roles")) {
			jdbcTemplate.execute("INSERT INTO roles(name) VALUES('ROLE_BUYER')");
			jdbcTemplate.execute("INSERT INTO roles(name) VALUES('ROLE_SELLER')");
			jdbcTemplate.execute("INSERT INTO roles(name) VALUES('ROLE_ADMIN')");
		}
	}

	private boolean isTableEmpty(String tableName) {
		Integer rowCount = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM " + tableName, Integer.class);
		return rowCount != null && rowCount == 0;
	}
}
