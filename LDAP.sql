-- Create the schema

CREATE TABLE `LDAP`.`parties`(
	`party_id` INT NOT NULL AUTO_INCREMENT,
	`full_name` TEXT CHARACTER
	SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`email` VARCHAR (256) CHARACTER
	SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`party_id`), UNIQUE `email` (`email`)) ENGINE = InnoDB;

CREATE TABLE `LDAP`.`roles` (
	`role_id` INT NOT NULL AUTO_INCREMENT,
	`title` VARCHAR (256) CHARACTER
	SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`role_id`), UNIQUE `title` (`title`)) ENGINE = InnoDB;

CREATE TABLE `LDAP`.`party_roles` (
	`party_role_id` INT NOT NULL AUTO_INCREMENT,
	`party_id` INT NOT NULL,
	`role_id` INT NOT NULL,
	`valid` BOOLEAN NOT NULL DEFAULT TRUE,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`party_role_id`), UNIQUE `party_role` (`party_id`, `role_id`)) ENGINE = InnoDB;

ALTER TABLE `party_roles` ADD CONSTRAINT `party_id_fk` FOREIGN KEY (`party_id`)
	REFERENCES `parties`(`party_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `party_roles` ADD CONSTRAINT `role_id_fk` FOREIGN KEY (`role_id`)
	REFERENCES `roles`(`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Run the inserts when you have the pipeline all set up

INSERT INTO `roles` (`title`, `created_at`, `updated_at`) VALUES
	('PRESIDENT', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()), ('VICE_PRESIDENT', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
	('MANAGER', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()), ('EMPLOYEE', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());

INSERT INTO `parties` (`full_name`, `email`, `created_at`, `updated_at`) VALUES
	('Fran Farmington', 'fran@ex.com', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
	('Tristan Partin', 'tristan@ex.com', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
	('Jill Hill', 'jill@ex.com', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());

INSERT INTO `party_roles` (`party_id`, `role_id`, `created_at`, `updated_at`) VALUES
	('1', '1', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()), ('1', '4', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
	('2', '3', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()), ('2', '4', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
	('3', '2', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()), ('3', '4', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());

-- Once the inserts have ran, try running these updates to see the changes

-- This simulates a person getting fired or quitting
UPDATE `party_roles` SET `valid` = '0' WHERE `party_roles`.`party_role_id` = 3;
UPDATE `party_roles` SET `valid` = '0' WHERE `party_roles`.`party_role_id` = 4;
