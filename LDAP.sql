CREATE TABLE `LDAP`.`parties`(
	`party_id` INT NOT NULL AUTO_INCREMENT,
	`full_name` TEXT CHARACTER
	SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`email` VARCHAR (256) CHARACTER
	SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`party_id`), UNIQUE `email` (`email`)) ENGINE = InnoDB;

CREATE TABLE `LDAP`.`roles` (
	`role_id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (256) CHARACTER
	SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`role_id`), UNIQUE `name` (`name`)) ENGINE = InnoDB;

CREATE TABLE `LDAP`.`party_roles` (
	`party_id` INT NOT NULL,
	`role_id` INT NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(`party_id`, `role_id`)) ENGINE = InnoDB;

ALTER TABLE `party_roles` ADD CONSTRAINT `party_id_fk` FOREIGN KEY (`party_id`)
	REFERENCES `parties`(`party_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `party_roles` ADD CONSTRAINT `role_id_fk` FOREIGN KEY (`role_id`)
	REFERENCES `roles`(`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

INSERT INTO `roles` (`role_id`, `name`, `created_at`) VALUES
	(NULL, 'PRESIDENT', CURRENT_TIMESTAMP()), (NULL, 'VICE_PRESIDENT', CURRENT_TIMESTAMP()),
	(NULL, 'MANAGER', CURRENT_TIMESTAMP()), (NULL, 'DEVELOPER', CURRENT_TIMESTAMP());

INSERT INTO `parties` (`party_id`, `full_name`, `email`, `created_at`) VALUES
	(NULL, 'Fran Farmington', 'fran@ex.com', CURRENT_TIMESTAMP()),
	(NULL, 'Tristan Partin', 'tristan@ex.com', CURRENT_TIMESTAMP()),
	(NULL, 'Jill Hill', 'jill@ex.com', CURRENT_TIMESTAMP());

INSERT INTO `party_roles` (`party_id`, `role_id`, `created_at`) VALUES
	('1', '1', CURRENT_TIMESTAMP()), ('1', '4', CURRENT_TIMESTAMP()),
	('2', '3', CURRENT_TIMESTAMP()), ('2', '4', CURRENT_TIMESTAMP()),
	('3', '2', CURRENT_TIMESTAMP()), ('3', '4', CURRENT_TIMESTAMP());
