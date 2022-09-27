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
INSERT INTO `user` (`id`, `username`, `password`, `email`, `bio`, `image`, `active`, `role`, `first_name`, `last_name`, `created_date`, `updated_date`) VALUES (3, 'Monica', '$2a$10$Dm9/iOs3ozBHDKqqcjVe4ugFE6KVPBzRpC3Vvo2JRiWqrJ8YMENqy', 'user1@user.com', 'Grew up in the 90s, came for the nostalgia', 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/57/Monica_lewinsky.jpg/1024px-Monica_lewinsky.jpg', true, 'user', 'Monica', 'Lew', '2022-09-23', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `bio`, `image`, `active`, `role`, `first_name`, `last_name`, `created_date`, `updated_date`) VALUES (4, 'Abe', '$2a$10$Dm9/iOs3ozBHDKqqcjVe4ugFE6KVPBzRpC3Vvo2JRiWqrJ8YMENqy', 'user2@user.com', 'Here to reminisce on the glory days of toonage', 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Abraham_Lincoln_by_Nicholas_Shepherd%2C_1846-crop.jpg/1024px-Abraham_Lincoln_by_Nicholas_Shepherd%2C_1846-crop.jpg', true, 'user', 'Abe', 'Lincler', '2022-09-23', NULL);

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
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (10, 'Ron Rodecker', 'Born in 1930, Ron spent years as a principal in the Marshall Islands.', 'https://scontent-nrt1-1.xx.fbcdn.net/v/t1.6435-9/142670894_2947624095526864_4145963171878444620_n.jpg?stp=dst-jpg_p261x260&_nc_cat=100&ccb=1-7&_nc_sid=110474&_nc_ohc=4wtQsJWegTIAX9-n-KK&_nc_ht=scontent-nrt1-1.xx&edm=AHOlnoIEAAAA&oh=00_AT8GvKPORIi4w3gbk6zRtaDd1sSCrOLHtGzVHVhzFv4DUA&oe=6356FEE8', 'https://en.wikipedia.org/wiki/Ron_Rodecker', '2022-09-28', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (11, 'Van Partible', 'Born in 1971 in Manila, Phillippines, Van moved to California when we was nine years old.', 'http://t3.gstatic.com/licensed-image?q=tbn:ANd9GcQmsgqeQ4QQEjzdh5hCHYiXMA2YGQTzajduMBx4VFOkoUKiAqAHbo84UOQqryP40x0g', 'https://en.wikipedia.org/wiki/Van_Partible', '2022-09-28', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (12, 'Joe Ansolabehere', 'Born in 1959, Joe is of Basque decent and constantly moved around the CONUS as a child.', 'https://static.wikia.nocookie.net/disney/images/4/40/Joe_Ansolabehere.png/revision/latest/scale-to-width-down/250?cb=20160515064920', 'https://en.wikipedia.org/wiki/Joe_Ansolabehere', '2022-09-28', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `network`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `network` (`id`, `name`, `description`, `image`, `url`, `created_date`, `updated_date`) VALUES (1, 'Nickelodeon', 'First American cable channel made for children, started in 1979.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Nickelodeon_2009_logo.svg/2560px-Nickelodeon_2009_logo.svg.png', 'https://www.nick.com/', '2022-09-22', NULL);
INSERT INTO `network` (`id`, `name`, `description`, `image`, `url`, `created_date`, `updated_date`) VALUES (2, 'Cartoon Network', 'Launched in 1992, this cartoon channel is the daytime broadcast of The Cartoon Network, Inc.', 'https://en.wikipedia.org/wiki/Cartoon_Network', 'www.cartoonnetwork.com', '2022-09-22', NULL);
INSERT INTO `network` (`id`, `name`, `description`, `image`, `url`, `created_date`, `updated_date`) VALUES (3, 'Disney Television Animation (DTVA)', 'Established in 1984, DTVA ran the Saturday morning cartoon time block on ABC.', 'https://upload.wikimedia.org/wikipedia/en/thumb/4/4e/Disney_Television_Animation_logo.svg/440px-Disney_Television_Animation_logo.svg.png', 'https://en.wikipedia.org/wiki/Disney_Television_Animation', '2022-09-22', NULL);
INSERT INTO `network` (`id`, `name`, `description`, `image`, `url`, `created_date`, `updated_date`) VALUES (4, 'Public Broadcasting Service (PBS)', 'Started in 1969 in Arlington, VA, this station made a block for childrens\' cartoons in 1994.', 'https://upload.wikimedia.org/wikipedia/en/thumb/3/33/PBS_logo.svg/440px-PBS_logo.svg.png', 'https://en.wikipedia.org/wiki/PBS', '2022-09-28', NULL);

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
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (15, 'Dragon Tales', '1999-09-06', 'Two young children find a magic dragon scale that allows them to meet dragons and have adventures.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/0/07/Dragon_Tales_main_characters.JPG', 3, '2005-11-25', 'https://en.wikipedia.org/wiki/Dragon_Tales', true, 10, 4, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (16, 'Johnny Bravo', '1997-07-14', 'A muscular young man who lives with his mother trys and fails to find dates while finding himself in contant predicaments.', '2022-09-28', NULL, 'data:image/png;base64,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', 3, '2004-08-27', 'https://en.wikipedia.org/wiki/Johnny_Bravo', true, 11, 2, 2);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (17, 'Recess', '1997-09-13', 'The misadventures of middle schoolers in the 90s.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/4/40/Recess_characters.png', 3, '2001-11-05', 'https://en.wikipedia.org/wiki/Recess_(TV_series)', true, 12, 3, 1);

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
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (13, 'https://www.youtube.com/watch?v=MdxgN5ATUVQ', 15, 3, 'Full Episode of \"Dragon Tales\"', 'Full Episode', 'https://upload.wikimedia.org/wikipedia/en/0/08/Dragon_Tales_logo.jpg', 28, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (14, 'https://www.youtube.com/watch?v=rHVrhX91V-U', 16, 3, 'Full Episode of \"Johnny Bravo\"', 'Full Episode', 'data:image/jpeg;base64,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', 18, 3, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (15, 'https://www.youtube.com/watch?v=-UtUuT8AJjQ', 17, 3, 'Full Episode of \"Recess\"', 'Full Episode', 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Disney%27s_Recess_logo.png', 1, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (16, 'https://www.youtube.com/watch?v=MjIu2U58FVY', 1, 1, 'Video Clip of \"Hey Arnold\"', 'Video Clip', 'https://upload.wikimedia.org/wikipedia/en/2/2a/HeyArnold%21.jpg', 5, 7, true, '2022-09-28', NULL);

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
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (13, 3, '\"Wish I had a scale too\"', true, '2022-09-28', NULL, NULL, 15);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (14, 3, '\"Hey therrrre mama\"', true, '2022-09-28', NULL, NULL, 16);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (15, 3, '\"Yooooo Randall was there worst\"', true, '2022-09-28', NULL, NULL, 17);

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
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (13, 'What is the name of the old wise dragon?', 'Quetzal', 15, '2022-09-28', NULL, true, 3);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (14, 'From what show does the name \"Johnny Bravo\" originate? ', 'The Brady Bunch.', 16, '2022-09-28', NULL, true, 3);

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
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (12, 15, 'https://www.redbubble.com/shop/dragon+tales', 'https://ih1.redbubble.net/image.1391167555.9001/st,small,507x507-pad,600x600,f8f8f8.jpg', 3, '2022-09-28', NULL, true);
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (13, 16, 'https://www.redbubble.com/shop/johnny+bravo', 'https://ih1.redbubble.net/image.3187633336.3350/st,small,507x507-pad,600x600,f8f8f8.jpg', 3, '2022-09-28', NULL, true);
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`) VALUES (14, 1, 'https://www.redbubble.com/shop/hey+arnold', 'https://ih1.redbubble.net/image.1026516834.9524/st,small,507x507-pad,600x600,f8f8f8.jpg', 1, '2022-09-28', NULL, true);

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
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (13, 'The creator of this series was a principal in the Marshall Islands for two years.', 15, 3, true, '2022-09-28', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (14, 'This series helped launch the career of Seth MacFarlane.', 16, 3, true, '2022-09-28', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (15, 'The main characters actually have a final appearance in the Lilo and Stitch Series.', 17, 3, true, '2022-09-28', NULL);

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
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (15, 3);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (16, 3);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (17, 3);

COMMIT;

