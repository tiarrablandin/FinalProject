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
  `email` VARCHAR(45) NULL,
  `bio` TEXT NULL,
  `image` VARCHAR(200) NULL,
  `active` TINYINT NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `creator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `creator` ;

CREATE TABLE IF NOT EXISTS `creator` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `bio` TEXT NULL,
  `image` TEXT NULL,
  `url` TEXT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `network`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `network` ;

CREATE TABLE IF NOT EXISTS `network` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` TEXT NULL,
  `image` TEXT NULL,
  `url` TEXT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rating` ;

CREATE TABLE IF NOT EXISTS `rating` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rating` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cartoon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cartoon` ;

CREATE TABLE IF NOT EXISTS `cartoon` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `airing_date` DATETIME NULL,
  `description` TEXT NULL,
  `created_date` VARCHAR(45) NOT NULL,
  `updated_date` DATETIME NULL,
  `image` TEXT NULL,
  `user_id` INT NOT NULL,
  `finale_date` DATETIME NULL,
  `url` TEXT NULL,
  `active` TINYINT NOT NULL,
  `creator_id` INT NOT NULL,
  `network_id` INT NOT NULL,
  `rating_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cartoon_user1_idx` (`user_id` ASC),
  INDEX `fk_cartoon_creator1_idx` (`creator_id` ASC),
  INDEX `fk_cartoon_network1_idx` (`network_id` ASC),
  INDEX `fk_cartoon_rating1_idx` (`rating_id` ASC),
  CONSTRAINT `fk_cartoon_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cartoon_creator1`
    FOREIGN KEY (`creator_id`)
    REFERENCES `creator` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cartoon_network1`
    FOREIGN KEY (`network_id`)
    REFERENCES `network` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cartoon_rating1`
    FOREIGN KEY (`rating_id`)
    REFERENCES `rating` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `media` ;

CREATE TABLE IF NOT EXISTS `media` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `url` TEXT NOT NULL,
  `cartoon_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `description` TEXT NOT NULL,
  `title` TEXT NOT NULL,
  `image` TEXT NULL,
  `episode_number` INT NULL,
  `season` INT NULL,
  `active` TINYINT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_media_cartoon1_idx` (`cartoon_id` ASC),
  INDEX `fk_media_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_media_cartoon1`
    FOREIGN KEY (`cartoon_id`)
    REFERENCES `cartoon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `comment` TEXT NOT NULL,
  `active` TINYINT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NULL,
  `reply_comment_id` INT NULL,
  `cartoon_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_forum_user1_idx` (`user_id` ASC),
  INDEX `fk_forum_comment_forum_comment1_idx` (`reply_comment_id` ASC),
  INDEX `fk_comment_cartoon1_idx` (`cartoon_id` ASC),
  CONSTRAINT `fk_forum_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_forum_comment_forum_comment1`
    FOREIGN KEY (`reply_comment_id`)
    REFERENCES `comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_cartoon1`
    FOREIGN KEY (`cartoon_id`)
    REFERENCES `cartoon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trivia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trivia` ;

CREATE TABLE IF NOT EXISTS `trivia` (
  `id` INT NOT NULL,
  `question` TEXT NOT NULL,
  `answer` VARCHAR(100) NOT NULL,
  `cartoon_id` INT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trivia_cartoon1_idx` (`cartoon_id` ASC),
  CONSTRAINT `fk_trivia_cartoon1`
    FOREIGN KEY (`cartoon_id`)
    REFERENCES `cartoon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merchandise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `merchandise` ;

CREATE TABLE IF NOT EXISTS `merchandise` (
  `id` INT NOT NULL,
  `cartoon_id` INT NOT NULL,
  `url` TEXT NOT NULL,
  `image` TEXT NULL,
  `user_id` INT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `update_date` DATETIME NULL,
  `active` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_merchandise_cartoon1_idx` (`cartoon_id` ASC),
  INDEX `fk_merchandise_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_merchandise_cartoon1`
    FOREIGN KEY (`cartoon_id`)
    REFERENCES `cartoon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_merchandise_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fact` ;

CREATE TABLE IF NOT EXISTS `fact` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fact` TEXT NOT NULL,
  `cartoon_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `active` TINYINT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fun_fact_cartoon1_idx` (`cartoon_id` ASC),
  INDEX `fk_fun_fact_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_fun_fact_cartoon1`
    FOREIGN KEY (`cartoon_id`)
    REFERENCES `cartoon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fun_fact_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite` ;

CREATE TABLE IF NOT EXISTS `favorite` (
  `cartoon_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`cartoon_id`, `user_id`),
  INDEX `fk_cartoon_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_cartoon_has_user_cartoon1_idx` (`cartoon_id` ASC),
  CONSTRAINT `fk_cartoon_has_user_cartoon1`
    FOREIGN KEY (`cartoon_id`)
    REFERENCES `cartoon` (`id`)
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
INSERT INTO `user` (`id`, `username`, `password`, `email`, `bio`, `image`, `active`, `role`, `first_name`, `last_name`, `created_date`, `updated_date`) VALUES (1, 'admin', 'admin', '', 'administrator', '', true, 'admin', NULL, NULL, '2022-09-22', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `bio`, `image`, `active`, `role`, `first_name`, `last_name`, `created_date`, `updated_date`) VALUES (2, 'user', 'user', NULL, 'user', NULL, true, 'user', NULL, NULL, '2022-09-22', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `creator`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (1, 'Craig Bartlett', 'Born in 1956, Chris also made childrens\' cartoons \"Dinosaur Train\" and \"Ready Jet Go!\".', 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Craig_Bartlett_2017.jpg/440px-Craig_Bartlett_2017.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/ce/Craig_Bartlett_2017.jpg', '2022-09-22', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (2, 'John R. Dilworth', 'Born in 1963, John is the founder of Stretch Films, started in 1991.', 'https://upload.wikimedia.org/wikipedia/commons/f/f0/DillyDali2014.jpg', 'https://en.wikipedia.org/wiki/John_R._Dilworth', '2022-09-22', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `network`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `network` (`id`, `name`, `description`, `image`, `url`, `created_date`, `updated_date`) VALUES (1, 'Nickelodeon', 'First American cable channel made for children, started in 1979.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Nickelodeon_2009_logo.svg/2560px-Nickelodeon_2009_logo.svg.png', 'https://www.nick.com/', '2022-09-22', NULL);
INSERT INTO `network` (`id`, `name`, `description`, `image`, `url`, `created_date`, `updated_date`) VALUES (2, 'Cartoon Network', 'Launched in 1992, this cartoon channel is the daytime broadcast of The Cartoon Network, Inc.', 'https://en.wikipedia.org/wiki/Cartoon_Network', 'www.cartoonnetwork.com', '2022-09-22', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `rating` (`id`, `rating`, `description`, `created_date`, `updated_date`) VALUES (1, 'PG', 'Parental guidance.', '2022-09-22', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cartoon`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (1, 'Hey Arnold', '1996-10-07', 'A young boy has humorous and at times intense philosophic adventures with friends in \'90s New York City. ', '2022-09-22', NULL, 'https://cdn.vox-cdn.com/thumbor/tBc_7lQ2WMFz6PB_O7j7clOZbPo=/0x0:670x377/1200x800/filters:focal(274x87:380x193)/cdn.vox-cdn.com/uploads/chorus_image/image/51248321/1_hey-arnold.0.jpg', 1, '2004-06-08', NULL, true, 1, 1, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (2, 'Courage The Cowardly Dog', '1996-02-18', 'A farm dog comically battles supernatural horrors to defend his owners.', '2022-09-22', NULL, 'https://m.media-amazon.com/images/M/MV5BMTU4MGEyNTItNzg5ZS00ZGU0LTk4NmEtODM0Y2UxYTY2YTUyXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_FMjpg_UX1000_.jpg', 2, '2002-11-22', 'https://en.wikipedia.org/wiki/Courage_the_Cowardly_Dog', true, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `media`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (1, 'https://www.youtube.com/watch?v=6jvYynOwKdo&list=PLLhOnau-tupT0auXzLM-f5iNjzHydd4XO', 1, 1, 'Clips of \"Hey Arnold!\"', 'Video Clip', NULL, NULL, NULL, true, '2022-09-22', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (2, 'https://www.youtube.com/watch?v=pyEKOY1TIbU', 2, 2, 'Full Episode of Courage The Cowardly Dog', 'Full Episode', NULL, NULL, NULL, true, '2022-09-22', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (1, 1, '\"This is my favorite feels toon.', true, '2022-09-22', NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trivia`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`) VALUES (1, 'In what historic event does Mr. Hyunh\'s backstory take place?', 'The Fall of Saigon.', 1, '2022-09-22', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `merchandise`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (1, 1, 'https://www.amazon.com/hey-arnold-merchandise/s?k=hey+arnold+merchandise', NULL, 1, '2022-09-22', NULL, true);

COMMIT;


-- -----------------------------------------------------
-- Data for table `fact`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (1, 'This cartoon bridged the late 90s to the mid 00s.', 1, 1, true, '2022-09-22', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (1, 1);

COMMIT;

