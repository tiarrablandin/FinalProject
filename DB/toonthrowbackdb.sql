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
  `created_date` DATETIME NOT NULL,
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `question` TEXT NOT NULL,
  `answer` VARCHAR(100) NOT NULL,
  `cartoon_id` INT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NULL,
  `active` TINYINT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trivia_cartoon1_idx` (`cartoon_id` ASC),
  INDEX `fk_trivia_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_trivia_cartoon1`
    FOREIGN KEY (`cartoon_id`)
    REFERENCES `cartoon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trivia_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merchandise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `merchandise` ;

CREATE TABLE IF NOT EXISTS `merchandise` (
  `id` INT NOT NULL AUTO_INCREMENT,
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
INSERT INTO `user` (`id`, `username`, `password`, `email`, `bio`, `image`, `active`, `role`, `first_name`, `last_name`, `created_date`, `updated_date`) VALUES (1, 'admin', '$2a$10$Dm9/iOs3ozBHDKqqcjVe4ugFE6KVPBzRpC3Vvo2JRiWqrJ8YMENqy', 'admin@admin.com', 'administrator', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Geiko_Kimiha.jpg/800px-Geiko_Kimiha.jpg', true, 'admin', 'Paul', 'Jones', '2022-09-22', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `bio`, `image`, `active`, `role`, `first_name`, `last_name`, `created_date`, `updated_date`) VALUES (2, 'Willie1914', '$2a$10$Dm9/iOs3ozBHDKqqcjVe4ugFE6KVPBzRpC3Vvo2JRiWqrJ8YMENqy', 'user@user.com', 'Just another cat that loves ye olde toons.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Kaiser_Wilhelm_II_of_Germany_-_1902%28cropped%29.jpg/800px-Kaiser_Wilhelm_II_of_Germany_-_1902%28cropped%29.jpg', true, 'user', 'Willie', 'Hohen', '2022-09-22', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `bio`, `image`, `active`, `role`, `first_name`, `last_name`, `created_date`, `updated_date`) VALUES (3, 'user1', '$2a$10$Dm9/iOs3ozBHDKqqcjVe4ugFE6KVPBzRpC3Vvo2JRiWqrJ8YMENqy', 'user1@user.com', 'user1', NULL, true, 'user1', 'user1', 'user1', '2022-09-23', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `bio`, `image`, `active`, `role`, `first_name`, `last_name`, `created_date`, `updated_date`) VALUES (4, 'user2', '$2a$10$Dm9/iOs3ozBHDKqqcjVe4ugFE6KVPBzRpC3Vvo2JRiWqrJ8YMENqy', NULL, 'user2', NULL, true, 'user2', NULL, NULL, '2022-09-23', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `creator`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (1, 'Craig Bartlett', 'Born in 1956, Chris also made childrens\' cartoons \"Dinosaur Train\" and \"Ready Jet Go!\".', 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Craig_Bartlett_2017.jpg/440px-Craig_Bartlett_2017.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/ce/Craig_Bartlett_2017.jpg', '2022-09-22', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (2, 'John R. Dilworth', 'Born in 1963, John is the founder of Stretch Films, started in 1991.', 'https://upload.wikimedia.org/wikipedia/commons/f/f0/DillyDali2014.jpg', 'https://en.wikipedia.org/wiki/John_R._Dilworth', '2022-09-22', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (3, 'Stephen Hillenburg', 'Born in 1961, Stephen is a marine science educator.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Stephen_Hillenburg_by_Carlos_Cazurro.jpg/1024px-Stephen_Hillenburg_by_Carlos_Cazurro.jpg', 'https://en.wikipedia.org/wiki/Stephen_Hillenburg', '2022-09-23', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (4, 'Adam Maxwell Burton', 'Burton is known professionally as Maxwell Atoms.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Maxwell_Atoms_.jpg/1920px-Maxwell_Atoms_.jpg', 'https://en.wikipedia.org/wiki/Maxwell_Atoms', '2022-09-23', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (5, 'Arlene Klasky', 'Co-founder of Klasky Csupo Inc. with her ex-husband Gabor Csupo, Klasky was born in 1949.', 'https://upload.wikimedia.org/wikipedia/commons/2/20/Arlene_Klasky_%286271167330%29.jpg', 'https://en.wikipedia.org/wiki/Arlene_Klasky', '2022-09-28', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (6, 'Susan Rose', 'Born in 1952, Susan is also the creator of the international graffiti character, \"Fido Dido.\"', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/7UP_mural_%28Pune%2C_Maharashtra%29_%28cropped%29.jpg/2560px-7UP_mural_%28Pune%2C_Maharashtra%29_%28cropped%29.jpg', 'https://en.wikipedia.org/wiki/Sue_Rose', '2022-09-28', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (7, ' Craig McCracken', 'Born in 1971, Craig is regarded by his peers as a \"staple of American modern animated television.\"', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Craig_McCracken_1.jpg/1024px-Craig_McCracken_1.jpg', 'https://en.wikipedia.org/wiki/Craig_McCracken', '2022-09-28', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (8, 'David Feiss', 'Born in 1959, David joined Hanna-Barbera in 1978 right after graduating.', 'https://upload.wikimedia.org/wikipedia/commons/e/e9/David_Feiss_at_Chile_Monos_2018_%28cropped%2C_1%29.jpg', 'https://en.wikipedia.org/wiki/David_Feiss', '2022-09-28', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (9, 'Peter Hannan', 'Born in 1954, Peter has also been an art teacher for various levels from preschool to college.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Peter-hannan-05.jpg/1920px-Peter-hannan-05.jpg', 'https://en.wikipedia.org/wiki/Peter_Hannan_(producer)', '2022-09-28', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `network`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `network` (`id`, `name`, `description`, `image`, `url`, `created_date`, `updated_date`) VALUES (1, 'Nickelodeon', 'First American cable channel made for children, started in 1979.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Nickelodeon_2009_logo.svg/2560px-Nickelodeon_2009_logo.svg.png', 'https://www.nick.com/', '2022-09-22', NULL);
INSERT INTO `network` (`id`, `name`, `description`, `image`, `url`, `created_date`, `updated_date`) VALUES (2, 'Cartoon Network', 'Launched in 1992, this cartoon channel is the daytime broadcast of The Cartoon Network, Inc.', 'https://en.wikipedia.org/wiki/Cartoon_Network', 'www.cartoonnetwork.com', '2022-09-22', NULL);
INSERT INTO `network` (`id`, `name`, `description`, `image`, `url`, `created_date`, `updated_date`) VALUES (3, 'Disney Television Animation (DTVA)', 'Established in 1984, DTVA ran the Saturday morning cartoon time block on ABC.', 'https://upload.wikimedia.org/wikipedia/en/thumb/4/4e/Disney_Television_Animation_logo.svg/440px-Disney_Television_Animation_logo.svg.png', 'https://en.wikipedia.org/wiki/Disney_Television_Animation', '2022-09-22', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `rating` (`id`, `rating`, `description`, `created_date`, `updated_date`) VALUES (1, 'PG', 'Parental guidance.', '2022-09-22', NULL);
INSERT INTO `rating` (`id`, `rating`, `description`, `created_date`, `updated_date`) VALUES (2, 'PG10', 'Parental guidance under 10 years old.', '2022-09-22', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cartoon`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (1, 'Hey Arnold', '1996-10-07', 'A young boy has humorous and at times intense philosophic adventures with friends in \'90s New York City. ', '2022-09-22', NULL, 'https://cdn.vox-cdn.com/thumbor/tBc_7lQ2WMFz6PB_O7j7clOZbPo=/0x0:670x377/1200x800/filters:focal(274x87:380x193)/cdn.vox-cdn.com/uploads/chorus_image/image/51248321/1_hey-arnold.0.jpg', 1, '2004-06-08', 'https://en.wikipedia.org/wiki/Hey_Arnold!', true, 1, 1, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (2, 'Courage The Cowardly Dog', '1996-02-18', 'A farm dog comically battles supernatural horrors to defend his owners.', '2022-09-22', NULL, 'https://m.media-amazon.com/images/M/MV5BMTU4MGEyNTItNzg5ZS00ZGU0LTk4NmEtODM0Y2UxYTY2YTUyXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_FMjpg_UX1000_.jpg', 2, '2002-11-22', 'https://en.wikipedia.org/wiki/Courage_the_Cowardly_Dog', true, 2, 2, 2);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (3, 'Spongebob Squarepants', '1999-05-01', 'A humanoid sponge living in a pineapple under the sea has comedic misadventures.', '2022-09-23', NULL, 'https://upload.wikimedia.org/wikipedia/en/thumb/3/3b/SpongeBob_SquarePants_character.svg/1024px-SpongeBob_SquarePants_character.svg.png', 3, NULL, 'http://www.nick.com.au/spongebob-squarepants/', true, 3, 1, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (4, 'Grim & Evil', '2001-08-24', 'A double segmented series about the Grim Reaper befriended by two children and and Hector Con Carne.', '2022-09-23', NULL, 'https://upload.wikimedia.org/wikipedia/en/4/47/Grim_%26_Evil_Logo.jpg', 4, '2003-10-01', 'https://en.wikipedia.org/wiki/Grim_%26_Evil', true, 4, 2, 2);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (5, 'The Wild Thornberrys', '1998-09-01', 'A traveling family shooting a nature show has a daughter who can talk to animals.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/8/80/Tv_hi_wildthornberrys.jpg', 1, '2004-06-11', 'https://en.wikipedia.org/wiki/The_Wild_Thornberrys', true, 5, 1, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (6, 'Pepper Ann', '1997-09-13', 'A series following a twelve year old\'s daily life in and out of middle school.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/9/91/Pepper_Ann_-_logo_%28English%29.jpeg', 1, '2000-11-18', 'https://en.wikipedia.org/wiki/Pepper_Ann#Overview', true, 1, 3, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (7, 'Rugrats', '1991-08-11', 'A slice of life comedy following the lives of toddler Tommy and his friends.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/9/9b/Rugrats_cast.png', 1, '2004-08-01', 'https://en.wikipedia.org/wiki/Rugrats#Premise', true, 5, 1, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (8, 'Rocket Power', '1999-08-16', 'Four kids into extreme sports have adventures around southern California.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/0/03/Rocket_Power.jpg', 1, '2004-07-30', 'https://en.wikipedia.org/wiki/Rocket_Power', true, 5, 1, 2);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (9, 'The Powerpuff Girls', '1998-11-18', 'Three girls with superpowers are created by a professor to fight evil.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/9/95/Powerpuff_girls_characters.jpg', 2, '2005-03-25', 'https://en.wikipedia.org/wiki/The_Powerpuff_Girls', true, 7, 2, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (10, 'Aaahh!!! Real Monsters', '1994-10-29', 'Three young monsters attend school under a dump to learn to frighten humans.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/4/4d/Aaahh%21%21%21_Real_Monsters_cast.jpeg', 2, '1997-10-06', 'https://en.wikipedia.org/wiki/Aaahh!!!_Real_Monsters', true, 5, 1, 2);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (11, 'Cow and Chicken', '1997-07-15', 'A cow and a chicken are adopted by human parents and have surreal comedic mishaps.', '2022-09-28', NULL, 'https://ih1.redbubble.net/image.431623936.0918/papergc,300x,w,f8f8f8-pad,600x600,f8f8f8.u2.jpg', 2, '1999-07-24', 'https://en.wikipedia.org/wiki/Cow_and_Chicken', true, 8, 2, 2);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (12, 'CatDog', '1998-04-04', 'A conjoined cat and dog sibling(s) have opposite personalities, hilarity ensues.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/6/64/CatDog.jpeg', 2, '2005-06-15', 'https://en.wikipedia.org/wiki/CatDog', true, 9, 1, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (13, 'test1', '2000-01-01', 'test1', '2000-01-01', NULL, 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Human_Feces.jpg/1920px-Human_Feces.jpg', 1, '2000-01-01', 'test1', true, 1, 1, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (14, 'test2', '2000-01-01', 'test2', '2000-01-01', NULL, 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Human_Feces.jpg/1920px-Human_Feces.jpg', 2, '2000-01-01', 'test2', true, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `media`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (1, 'https://www.youtube.com/watch?v=6jvYynOwKdo&list=PLLhOnau-tupT0auXzLM-f5iNjzHydd4XO', 1, 1, 'Clips of \"Hey Arnold!\"', 'Video Clip', 'https://upload.wikimedia.org/wikipedia/en/2/2a/HeyArnold%21.jpg', 5, 3, true, '2022-09-22', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (2, 'https://www.youtube.com/watch?v=pyEKOY1TIbU', 2, 2, 'Full Episode of Courage The Cowardly Dog', 'Full Episode', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Courage_The_Cowardly_Dog_logo.png/2560px-Courage_The_Cowardly_Dog_logo.png', 2, 1, true, '2022-09-22', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (3, 'https://www.youtube.com/watch?v=YZI-Q118lYY', 3, 3, 'Live feed of Spongebob Squarepants.', 'Live Feed', 'https://upload.wikimedia.org/wikipedia/en/thumb/c/ce/Mrs._Puff.svg/1280px-Mrs._Puff.svg.png', 4, 13, true, '2022-09-23', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (4, 'https://www.youtube.com/watch?v=t9fVEsLVwxw', 4, 4, 'Half Episode of Grim & Evil', 'Half Episode', 'https://upload.wikimedia.org/wikipedia/en/0/0d/BillyandMandyScreen.jpg', 13, 1, true, '2022-09-23', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (5, 'https://www.youtube.com/watch?v=NvQgiDEJBUs&list=PL8_Qxk_IYLL-ut-xwrudvP1xkkmUXrTXT&index=2', 5, 1, 'Full Episode of The Wild Thornberrys', 'Full Episode', 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Thornberryslogo.gif', 6, 3, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (6, 'https://www.youtube.com/watch?v=G-4hBxOMl34', 6, 1, 'Full Episode of Pepper Ann', 'Full Episode', 'https://upload.wikimedia.org/wikipedia/en/9/91/Pepper_Ann_-_logo_%28English%29.jpeg', 1, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (7, 'https://www.youtube.com/watch?v=FOKIW_5iaUw&list=PLLhOnau-tupQ0EFBJ_OAu4NnB1kTv9KFP', 7, 1, 'Full Episode of Rugrats', 'Full Episode', 'https://upload.wikimedia.org/wikipedia/en/6/66/Rugrats_logo.png', 1, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (8, 'https://www.youtube.com/watch?v=BdPlZGtfhB0', 8, 1, 'Clip of \"Rocket Power\"', 'Video Clip', 'https://i.ytimg.com/vi/BdPlZGtfhB0/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAk3tWijTr01YpwavYIq0-vDLXKPw', 4, 2, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (9, 'https://www.youtube.com/watch?v=J7uTcjFq5U0', 9, 2, 'Full Episode of \"The Powerpuff Girls\"', 'Full Episode', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/The_Powerpuff_Girls_logo.svg/2560px-The_Powerpuff_Girls_logo.svg.png', 12, 2, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (10, 'https://www.youtube.com/watch?v=jPKJDYH1St0', 10, 2, 'Video Clip of Aaahh!!! Real Monsters\"', 'Video Clip', 'https://upload.wikimedia.org/wikipedia/en/thumb/b/ba/Aaahh_Real_Monsters_Logo.svg/1920px-Aaahh_Real_Monsters_Logo.svg.png', 2, 3, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (11, 'https://www.youtube.com/watch?v=yesCKR128IM', 11, 2, 'Full Episode of \"Cow and Chicken\"', 'Full Episode', 'https://upload.wikimedia.org/wikipedia/commons/c/c8/Cow_and_Chicken_logo.png', 1, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (12, 'https://www.youtube.com/watch?v=oDDg-L2izvY', 12, 2, 'Full Episode of \"CatDog\"', 'Full Episode', 'https://upload.wikimedia.org/wikipedia/en/a/a4/Cat-and-Dog.gif', 2, 3, true, '2022-09-28', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (1, 1, '\"This is my favorite feels toon.', true, '2022-09-22', NULL, NULL, 1);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (2, 2, '\"ooo spoopy\"', true, '2022-09-22', NULL, NULL, 2);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (3, 3, '\"The feed goes on and on and on.\"', true, '2022-09-23', NULL, NULL, 3);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (4, 4, '\"This series shouldn\'t have turned into Billy and Mandy.\"', true, '2022-09-23', NULL, NULL, 4);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (5, 1, '\"I identify with Donnie on a spiritual level.\"', true, '2022-09-28', NULL, NULL, 5);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (6, 1, '\"I almost forgot about this show\"', true, '2022-09-28', NULL, NULL, 6);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (7, 1, '\"Everyone wants to be Tommy but we all Chucky fr\"', true, '2022-09-28', NULL, NULL, 7);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (8, 1, '\"This was the first cartoon i saw when my family got cable\"', true, '2022-09-28', NULL, NULL, 8);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (9, 2, '\"HIM is the best character.\"', true, '2022-09-28', NULL, NULL, 9);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (10, 2, '\"This toon goes all the way back for me.\"', true, '2022-09-28', NULL, NULL, 10);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (11, 2, '\"Has me laughing laughing everytime\"', true, '2022-09-28', NULL, NULL, 11);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (12, 2, '\"How do they go to the bathroom\"', true, '2022-09-28', NULL, NULL, 12);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trivia`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (1, 'In what historic event does Mr. Hyunh\'s backstory take place?', 'The Fall of Saigon.', 1, '2022-09-22', NULL, true, 1);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (2, 'What does mummy Rameses moan outside the farmhouse?', '\"Return the Slab!\"', 2, '2022-09-22', NULL, true, 2);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (3, 'What is the name of the spatula handed boogey man in Spongebob?', 'The Hash Slinging Slasher.', 3, '2022-09-23', NULL, true, 3);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (4, 'What are the only two parts of Hector left?', 'His brain and stomach.', 4, '2022-09-23', NULL, true, 4);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (5, 'What is the name of Eliza\'s talking primate friend?', 'Darwin.', 5, '2022-09-28', NULL, true, 1);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (6, 'What is Pepper Ann\'s favorite night?', 'Taco Night', 6, '2022-09-28', NULL, true, 1);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (7, 'What is the name of the dinosaur monster beloved by all the babies?', 'Reptar', 7, '2022-09-28', NULL, true, 1);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (8, 'What is the fast food shop called that the Rocket family runs?', 'Shore Shack', 8, '2022-09-28', NULL, true, 1);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (9, 'What is the name of the big brained monkey villain?', 'Mojo Jo-Jo', 9, '2022-09-28', NULL, true, 2);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (10, 'What are the names of the three main monsters?', 'Ickis, Oblina, and Krumm', 10, '2022-09-28', NULL, true, 2);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (11, 'What is the name of the devil in this show?', 'Red Guy', 11, '2022-09-28', NULL, true, 2);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (12, 'What is the name of the blue mouse that lives in CatDog\'s house?', 'Winslow Thelonious Oddfellow', 12, '2022-09-28', NULL, true, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `merchandise`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (1, 1, 'https://www.amazon.com/hey-arnold-merchandise/s?k=hey+arnold+merchandise', 'https://upload.wikimedia.org/wikipedia/en/a/ac/Helga_Pataki.jpg', 1, '2022-09-22', NULL, true);
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (2, 2, 'https://www.amazon.com/courage-cowardly-dog-shirt/s?k=courage+the+cowardly+dog+shirt', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Courage_The_Cowardly_Dog_logo.png/2560px-Courage_The_Cowardly_Dog_logo.png', 2, '2022-09-22', NULL, true);
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (3, 3, 'https://www.amazon.com/Spongebob-Merchandise/s?k=Spongebob+Merchandise', 'https://upload.wikimedia.org/wikipedia/en/0/0b/Nickelodeon_SpongeBob_SquarePants_Characters_Cast.png', 3, '2022-09-23', NULL, true);
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (4, 5, 'https://www.truffleshuffle.co.uk/cartoons/the-wild-thornberrys', 'https://ih1.redbubble.net/image.1411052255.9460/st,small,507x507-pad,600x600,f8f8f8.u2.jpg', 1, '2022-09-28', NULL, true);
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (5, 6, 'https://www.redbubble.com/shop/pepper+ann', 'https://ih1.redbubble.net/image.764480007.6328/st,small,507x507-pad,600x600,f8f8f8.u2.jpg', 1, '2022-09-28', NULL, true);
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (6, 7, 'https://www.amazon.com/Rugrats-Clothing-Shoes-Jewelry/s?k=Rugrats&rh=n%3A7141123011', 'https://m.media-amazon.com/images/I/71tJgIY-hRL._AC_UL640_FMwebp_QL65_.jpg', 1, '2022-09-28', NULL, true);
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (7, 8, 'https://www.redbubble.com/shop/rocket+power', 'https://ih1.redbubble.net/image.991229436.4337/st,small,507x507-pad,600x600,f8f8f8.jpg', 1, '2022-09-28', NULL, true);
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (8, 9, 'https://www.hottopic.com/pop-culture/shop-by-license/the-powerpuff-girls/', 'https://cdn.media.amplience.net/s/hottopic/19047565_hi?$productTileDesktopRetina$', 2, '2022-09-28', NULL, true);
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (9, 10, 'https://www.redbubble.com/shop/aaahh+real+monsters', 'https://ih1.redbubble.net/image.3775611624.4149/st,small,507x507-pad,600x600,f8f8f8.u3.jpg', 2, '2022-09-28', NULL, true);
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (10, 11, 'hottopic.com/pop-culture/shop-by-license/cow-and-chicken/', 'https://i.etsystatic.com/31518612/r/il/feeda5/3286923762/il_680x540.3286923762_s2bm.jpg', 2, '2022-09-28', NULL, true);
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (11, 12, 'https://www.redbubble.com/shop/catdog', 'https://ih1.redbubble.net/image.1895121660.1127/st,small,507x507-pad,600x600,f8f8f8.jpg', 2, '2022-09-28', NULL, true);

COMMIT;


-- -----------------------------------------------------
-- Data for table `fact`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (1, 'This cartoon bridged the late 90s to the mid 00s.', 1, 1, true, '2022-09-22', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (2, 'This is the only \"children\'s horror/black comedy\" combination on the network.', 2, 2, true, '2022-09-22', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (3, 'This TV series was created by a marine biologist.', 3, 3, true, '2022-09-23', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (4, 'This series was split into two seperate cartoons after 2003.', 4, 4, true, '2022-09-23', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (5, 'Tim Curry voices the father, Nigel Thornberry', 5, 1, true, '2022-09-28', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (6, 'This was the first DTVA show created by a woman.', 6, 1, true, '2022-09-28', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (7, 'This was the first American cartoon to depict a practicing Jewish family.', 7, 1, true, '2022-09-28', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (8, 'This show was made by the same creators as Rugrats.', 8, 1, true, '2022-09-28', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (9, 'The original name of \"Chemical X\" was \"can of Whoopass.\"', 9, 2, true, '2022-09-28', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (10, 'The dump the monsters inhabit is Fresh Kills Landfill of New York.', 10, 2, true, '2022-09-28', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (11, 'The episode \"Buffalo Gals\" was banned from cartoon network over its sexual jokes.\"', 11, 2, true, '2022-09-28', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (12, 'This seriess was co-animated via American and South Korean studios', 12, 2, true, '2022-09-28', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (1, 1);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (2, 2);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (3, 3);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (4, 4);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (5, 1);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (6, 1);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (7, 1);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (8, 1);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (9, 2);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (10, 2);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (11, 2);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (12, 2);

COMMIT;

