CREATE TABLE `LDAP`.`parties`(
	`party_id` INT NOT NULL AUTO_INCREMENT,
	`full_name` TEXT CHARACTER
	SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`email` VARCHAR (256) CHARACTER
	SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`party_id`), UNIQUE `email` (`email`)) ENGINE = InnoDB;

CREATE TABLE `LDAP`.`identities` (
	`identity_id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (256) CHARACTER
	SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`identity_id`), UNIQUE `name` (`name`)) ENGINE = InnoDB;

CREATE TABLE `LDAP`.`party_identities` (
	`party_id` INT NOT NULL,
	`identity_id` INT NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(`party_id`, `identity_id`)) ENGINE = InnoDB;

ALTER TABLE `party_identities` ADD CONSTRAINT `party_id_fk` FOREIGN KEY (`party_id`)
	REFERENCES `parties`(`party_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `party_identities` ADD CONSTRAINT `identity_id_fk` FOREIGN KEY (`identity_id`)
	REFERENCES `identities`(`identity_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- INSERT INTO `identities` (`identity_id`, `name`, `created_at`) VALUES
-- 	(NULL, 'PRESIDENT', CURRENT_TIMESTAMP()), (NULL, 'VICE_PRESIDENT', CURRENT_TIMESTAMP()),
-- 	(NULL, 'MANAGER', CURRENT_TIMESTAMP()), (NULL, 'DEVELOPER', CURRENT_TIMESTAMP());

-- INSERT INTO `parties` (`party_id`, `full_name`, `email`, `created_at`, `updated_at`) VALUES
-- 	(NULL, 'Joe Shmoe', 'joe.shmoe@example.com', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());

-- INSERT INTO `party_identities` (`party_id`, `identity_id`, `created_at`) VALUES ('1', '1', CURRENT_DATE());
