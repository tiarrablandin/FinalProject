-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema toonthrowbackdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `toonthrowbackdb` ;

-- -----------------------------------------------------
-- Schema toonthrowbackdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `toonthrowbackdb` DEFAULT CHARACTER SET utf8 ;
USE `toonthrowbackdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `bio` TEXT NULL,
  `img` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cartoon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cartoon` ;

CREATE TABLE IF NOT EXISTS `cartoon` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `cartoon_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `date` VARCHAR(45) NULL,
  `rating` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `creator` VARCHAR(45) NULL,
  `network` VARCHAR(45) NULL,
  `created_date` DATETIME NULL,
  `updated_date` DATETIME NULL,
  `image` TEXT NULL,
  `cartooncol` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`, `cartoon_id`),
  INDEX `fk_user_has_cartoon_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_cartoon_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `media` ;

CREATE TABLE IF NOT EXISTS `media` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `link` TEXT NULL,
  `cartoon_user_id` INT NOT NULL,
  `cartoon_cartoon_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_media_cartoon1_idx` (`cartoon_user_id` ASC, `cartoon_cartoon_id` ASC),
  CONSTRAINT `fk_media_cartoon1`
    FOREIGN KEY (`cartoon_user_id` , `cartoon_cartoon_id`)
    REFERENCES `cartoon` (`user_id` , `cartoon_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `forum`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forum` ;

CREATE TABLE IF NOT EXISTS `forum` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `cartoon_id` INT NOT NULL,
  `cartoon_user_id` INT NOT NULL,
  `cartoon_cartoon_id` INT NOT NULL,
  `comment` TEXT NOT NULL,
  `active` TINYINT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_forum_user1_idx` (`user_id` ASC),
  INDEX `fk_forum_cartoon1_idx` (`cartoon_user_id` ASC, `cartoon_cartoon_id` ASC),
  CONSTRAINT `fk_forum_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_forum_cartoon1`
    FOREIGN KEY (`cartoon_user_id` , `cartoon_cartoon_id`)
    REFERENCES `cartoon` (`user_id` , `cartoon_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trivia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trivia` ;

CREATE TABLE IF NOT EXISTS `trivia` (
  `id` INT NOT NULL,
  `cartoon_id` INT NOT NULL,
  `question` TEXT NOT NULL,
  `answer` VARCHAR(100) NOT NULL,
  `cartoon_user_id` INT NOT NULL,
  `cartoon_cartoon_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trivia_cartoon1_idx` (`cartoon_user_id` ASC, `cartoon_cartoon_id` ASC),
  CONSTRAINT `fk_trivia_cartoon1`
    FOREIGN KEY (`cartoon_user_id` , `cartoon_cartoon_id`)
    REFERENCES `cartoon` (`user_id` , `cartoon_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merchandise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `merchandise` ;

CREATE TABLE IF NOT EXISTS `merchandise` (
  `id` INT NOT NULL,
  `cartoon_user_id` INT NOT NULL,
  `cartoon_cartoon_id` INT NOT NULL,
  `link` TEXT NOT NULL,
  `picture` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_merchandise_cartoon1_idx` (`cartoon_user_id` ASC, `cartoon_cartoon_id` ASC),
  CONSTRAINT `fk_merchandise_cartoon1`
    FOREIGN KEY (`cartoon_user_id` , `cartoon_cartoon_id`)
    REFERENCES `cartoon` (`user_id` , `cartoon_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fun_fact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fun_fact` ;

CREATE TABLE IF NOT EXISTS `fun_fact` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite` ;

CREATE TABLE IF NOT EXISTS `favorite` (
  `cartoon_user_id` INT NOT NULL,
  `cartoon_cartoon_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`cartoon_user_id`, `cartoon_cartoon_id`, `user_id`),
  INDEX `fk_cartoon_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_cartoon_has_user_cartoon1_idx` (`cartoon_user_id` ASC, `cartoon_cartoon_id` ASC),
  CONSTRAINT `fk_cartoon_has_user_cartoon1`
    FOREIGN KEY (`cartoon_user_id` , `cartoon_cartoon_id`)
    REFERENCES `cartoon` (`user_id` , `cartoon_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cartoon_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS toon@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'toon'@'localhost' IDENTIFIED BY 'toon';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'toon'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `bio`, `img`) VALUES (1, 'admin', 'admin', '1', 'long bio here', 'img url here');

COMMIT;

