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
  `airing_date` DATE NULL,
  `description` TEXT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NULL,
  `image` TEXT NULL,
  `user_id` INT NOT NULL,
  `finale_date` DATE NULL,
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
  `description` TEXT NULL,
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
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (13, 'Jim Jinkins', 'Born in 1953, Jim was born and raised in Richmond, VA.', NULL, 'https://en.wikipedia.org/wiki/Jim_Jinkins', '2022-09-28', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (14, 'Genndy Tartakovsky', 'In 1970, Genndy was born in the Soviet Union. He moved to the USA when he was seven years old.', 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Genndy_Tartakovsky_2018.jpg', 'https://en.wikipedia.org/wiki/Genndy_Tartakovsky', '2022-09-28', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (15, 'Bruce Timm', 'Born in 1961, Tim made numerous contributions to the DC Universe, including creating Harley Quinn.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Bruce_Timm_by_Gage_Skidmore.jpg/440px-Bruce_Timm_by_Gage_Skidmore.jpg', 'https://en.wikipedia.org/wiki/Bruce_Timm', '2022-09-28', NULL);
INSERT INTO `creator` (`id`, `name`, `bio`, `image`, `url`, `created_date`, `updated_date`) VALUES (16, 'Tom Ruegger', 'Born in 1955, Tom was raised in New Jersey and started his animation skills drawing Flintstones when it aired as a child.', 'https://images.mubicdn.net/images/cast_member/38817/cache-557586-1592455839/image-w856.jpg?size=800x', 'https://en.wikipedia.org/wiki/Tom_Ruegger', '2022-09-28', NULL);

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
INSERT INTO `network` (`id`, `name`, `description`, `image`, `url`, `created_date`, `updated_date`) VALUES (5, 'Fox Kids', 'A programming block for children in Fox Broadcasting Company for kids.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/FOX_Kids_logo.svg/1280px-FOX_Kids_logo.svg.png', 'https://en.wikipedia.org/wiki/Fox_Kids', '2022-09-28', NULL);

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
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (15, 'Dragon Tales', '1999-09-06', 'Two young children find a magic dragon scale that allows them to meet dragons and have adventures.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/0/07/Dragon_Tales_main_characters.JPG', 3, '2005-11-25', 'https://en.wikipedia.org/wiki/Dragon_Tales', true, 10, 4, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (16, 'Johnny Bravo', '1997-07-14', 'A muscular young man who lives with his mother trys and fails to find dates while finding himself in contant predicaments.', '2022-09-28', NULL, 'data:image/png;base64,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', 3, '2004-08-27', 'https://en.wikipedia.org/wiki/Johnny_Bravo', true, 11, 2, 2);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (17, 'Recess', '1997-09-13', 'The misadventures of middle schoolers in the 90s.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/4/40/Recess_characters.png', 3, '2001-11-05', 'https://en.wikipedia.org/wiki/Recess_(TV_series)', true, 12, 3, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (18, 'Doug', '1991-08-11', 'An adolescent boy wants to fit in, but his strong morality guides him to stand out.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Doug-72210-2.png', 3, '1999-06-26', 'https://en.wikipedia.org/wiki/Doug_(TV_series)', true, 13, 3, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (19, 'Dexter\'s Laboratory', '1996-04-28', 'A young genius keeps a secret lab under his parents\' house and is constantly derailed by a dimwitted sister. ', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Dexter-logo.png', 4, '2003-11-20', 'https://en.wikipedia.org/wiki/Dexter%27s_Laboratory', true, 14, 2, 2);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (20, 'Batman: The Animated Series', '1992-09-05', 'Animated batman series in a 20s noir style', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/f/f3/Batmananimated32.png', 4, '1999-01-06', 'https://en.wikipedia.org/wiki/Batman:_The_Animated_Series', true, 15, 5, 2);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (21, 'Animaniacs', '1993-09-13', 'The Warner brothers live in the WB water tower and cause mischief wherever they go.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/d/d2/Totallyinsaney.jpg', 4, '1999-11-14', 'https://en.wikipedia.org/wiki/Animaniacs', true, 16, 5, 1);
INSERT INTO `cartoon` (`id`, `name`, `airing_date`, `description`, `created_date`, `updated_date`, `image`, `user_id`, `finale_date`, `url`, `active`, `creator_id`, `network_id`, `rating_id`) VALUES (22, 'Pinky and the Brain', '1995-09-09', 'Two mice, one smart, one stupid, try and fail to take over the world.', '2022-09-28', NULL, 'https://upload.wikimedia.org/wikipedia/en/4/47/Pinky_and_the_Brain_vol1.jpg', 4, '1998-11-14', 'https://en.wikipedia.org/wiki/Pinky_and_the_Brain', true, 16, 5, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `media`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (1, 'https://www.youtube.com/watch?v=6jvYynOwKdo&list=PLLhOnau-tupT0auXzLM-f5iNjzHydd4XO', 1, 1, 'Clips of \"Hey Arnold!\"', 'Stinky Goes Hollywood/Olga Gets Engaged', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Hey_Arnold%21_logo.svg/2560px-Hey_Arnold%21_logo.svg.png', 5, 3, true, '2022-09-22', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (2, 'https://www.youtube.com/watch?v=pyEKOY1TIbU', 2, 2, 'Full Episode of Courage The Cowardly Dog', 'The Shadow of Courage/Le Quack', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Courage_The_Cowardly_Dog_logo.png/500px-Courage_The_Cowardly_Dog_logo.png', 2, 1, true, '2022-09-22', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (3, 'https://www.youtube.com/watch?v=YZI-Q118lYY', 3, 3, 'Live feed of Spongebob Squarepants.', 'Something Narwhal This Way Comes', 'https://upload.wikimedia.org/wikipedia/en/thumb/2/22/SpongeBob_SquarePants_logo_by_Nickelodeon.svg/2560px-SpongeBob_SquarePants_logo_by_Nickelodeon.svg.png', 4, 13, true, '2022-09-23', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (4, 'https://www.youtube.com/watch?v=t9fVEsLVwxw', 4, 4, 'Half Episode of Grim & Evil', 'Brain-Eating Meteor', 'https://upload.wikimedia.org/wikipedia/en/4/47/Grim_%26_Evil_Logo.jpg', 13, 1, true, '2022-09-23', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (5, 'https://www.youtube.com/watch?v=NvQgiDEJBUs&list=PL8_Qxk_IYLL-ut-xwrudvP1xkkmUXrTXT&index=2', 5, 1, 'Full Episode of The Wild Thornberrys', 'Queen of Denial', 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Thornberryslogo.gif', 6, 3, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (6, 'https://www.youtube.com/watch?v=G-4hBxOMl34', 6, 1, 'Full Episode of Pepper Ann', 'Ziterella', 'https://upload.wikimedia.org/wikipedia/en/9/91/Pepper_Ann_-_logo_%28English%29.jpeg', 1, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (7, 'https://www.youtube.com/watch?v=FOKIW_5iaUw&list=PLLhOnau-tupQ0EFBJ_OAu4NnB1kTv9KFP', 7, 1, 'Full Episode of Rugrats', 'Tommy\'s First Birthday', 'https://upload.wikimedia.org/wikipedia/en/6/66/Rugrats_logo.png', 1, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (8, 'https://www.youtube.com/watch?v=BdPlZGtfhB0', 8, 1, 'Clip of \"Rocket Power\"', 'The Longest Day/Ottoman and the Sea', 'https://upload.wikimedia.org/wikipedia/en/3/3c/Rocket_Power_title.jpg', 4, 2, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (9, 'https://www.youtube.com/watch?v=J7uTcjFq5U0', 9, 2, 'Full Episode of \"The Powerpuff Girls\"', 'Speed Demon/Mojo Jonesin', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/The_Powerpuff_Girls_logo.svg/500px-The_Powerpuff_Girls_logo.svg.png', 12, 2, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (10, 'https://www.youtube.com/watch?v=jPKJDYH1St0', 10, 2, 'Video Clip of Aaahh!!! Real Monsters\"', 'Who\'ll Stop the Brain?/Cement Heads', 'https://upload.wikimedia.org/wikipedia/en/thumb/b/ba/Aaahh_Real_Monsters_Logo.svg/500px-Aaahh_Real_Monsters_Logo.svg.png', 2, 3, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (11, 'https://www.youtube.com/watch?v=yesCKR128IM', 11, 2, 'Full Episode of \"Cow and Chicken\"', 'Field Trip to Folsom Prison/The Girls\' Bathroom', 'https://upload.wikimedia.org/wikipedia/commons/c/c8/Cow_and_Chicken_logo.png', 1, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (12, 'https://www.youtube.com/watch?v=oDDg-L2izvY', 12, 2, 'Full Episode of \"CatDog\"', 'A Dog Ate My Homework/The End', 'https://upload.wikimedia.org/wikipedia/en/6/64/CatDog.jpeg', 2, 3, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (13, 'https://www.youtube.com/watch?v=MdxgN5ATUVQ', 15, 3, 'Full Episode of \"Dragon Tales\"', 'Sand Castle Hassle/A True-Blue Friend', 'https://upload.wikimedia.org/wikipedia/en/0/08/Dragon_Tales_logo.jpg', 28, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (14, 'https://www.youtube.com/watch?v=rHVrhX91V-U', 16, 3, 'Full Episode of \"Johnny Bravo\"', 'A Johnny Bravo Christmas', 'https://upload.wikimedia.org/wikipedia/commons/b/be/Johnny_Bravo_series_logo.png', 18, 3, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (15, 'https://www.youtube.com/watch?v=-UtUuT8AJjQ', 17, 3, 'Full Episode of \"Recess\"', 'The Break-In', 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Disney%27s_Recess_logo.png', 1, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (16, 'https://www.youtube.com/watch?v=MjIu2U58FVY', 1, 1, 'Video Clip of \"Hey Arnold\"', 'Helga\'s Locket/Sid and Germs', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Hey_Arnold%21_logo.svg/2560px-Hey_Arnold%21_logo.svg.png', 7, 5, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (17, 'https://www.youtube.com/watch?v=H6bz9bMWwV4', 18, 3, 'Full Episode of \"Doug\"', 'Doug\'s Big Switch', 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Doug-72210-2.png', 13, 5, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (18, 'https://www.youtube.com/watch?v=8nW3-9gdjYA', 19, 4, 'Video Clip of \"Dexter\'s Laboratory\"', 'Doll House Drama /Krunk\'s Date /The Big Cheese', 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Dexter-logo.png', 9, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (19, 'https://www.youtube.com/watch?v=VjFftiur7Ik&list=PL09e5Ll8BFRBMR29eujY7yx-3KYCM_D1R', 20, 4, 'Video Clip of \"Batman: The Animated Series', 'The Cat & the Claw (Part 2)', 'https://upload.wikimedia.org/wikipedia/commons/6/69/BTAS_logo.png', 8, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (20, 'https://www.youtube.com/watch?v=m3zZykavVWo', 21, 4, 'Video Clip of \"Animaniacs\"', 'De-Zanitized /The Monkey Song /Nighty Night Toon', 'https://upload.wikimedia.org/wikipedia/en/8/8a/Animaniacs.png', 1, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (21, 'https://www.youtube.com/watch?v=ws8mBLZEnBc&list=PLLhOnau-tupQubHGGSs42R2ufqPtaB5az&index=2', 22, 4, 'Video Clip of \"Pinky and the Brain\"', 'A Pinky and the Brain Christmas', 'https://upload.wikimedia.org/wikipedia/en/a/a6/Pinky_and_The_Brain_%28logo%29.png', 8, 1, true, '2022-09-28', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (22, 'https://www.youtube.com/watch?v=lvJj-kpmsdM', 1, 3, 'Video Clip of \"Hey Arnold!\"', '24 Hours to Live', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Hey_Arnold%21_logo.svg/2560px-Hey_Arnold%21_logo.svg.png', 18, 1, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (23, 'https://www.youtube.com/watch?v=KD1D9YS327Q', 1, 2, 'Video Clip of \"Hey Arnold!\"', 'The List', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Hey_Arnold%21_logo.svg/2560px-Hey_Arnold%21_logo.svg.png', 8, 1, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (24, 'https://www.youtube.com/watch?v=zjd1gIdDoZY', 1, 4, 'Video Clip of \"Hey Arnold!\"', 'Field Trip', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Hey_Arnold%21_logo.svg/2560px-Hey_Arnold%21_logo.svg.png', 2, 1, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (25, 'https://www.youtube.com/watch?v=whqB5oRKN6s&list=PLLhOnau-tupT0auXzLM-f5iNjzHydd4XO&index=3', 1, 2, 'Video Clip of \"Hey Arnold!\"', 'Grand Prix', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Hey_Arnold%21_logo.svg/2560px-Hey_Arnold%21_logo.svg.png', 15, 3, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (26, 'https://www.youtube.com/watch?v=x5OQq4KsYA4&list=PLLhOnau-tupT0auXzLM-f5iNjzHydd4XO&index=4', 1, 3, 'Video Clip of \"Hey Arnold!\"', 'Cool Party', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Hey_Arnold%21_logo.svg/2560px-Hey_Arnold%21_logo.svg.png', 12, 3, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (27, 'https://www.youtube.com/watch?v=PW0Z-C5ywuU&list=PLLhOnau-tupS6kcWVPWziaNhMpctiZ8kz&index=2', 2, 3, 'Video Clip of \"Courage the Cowardly Dog\"', 'Squatting Tiger, Hidden Dog', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Courage_The_Cowardly_Dog_logo.png/500px-Courage_The_Cowardly_Dog_logo.png', 8, 4, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (28, 'https://www.youtube.com/watch?v=PhtKCb4ovjQ&list=PLLhOnau-tupS6kcWVPWziaNhMpctiZ8kz&index=3', 2, 1, 'Video Clip of \"Courage the Cowardly Dog\"', 'Profiles in Courage', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Courage_The_Cowardly_Dog_logo.png/500px-Courage_The_Cowardly_Dog_logo.png', 4, 6, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (29, 'https://www.youtube.com/watch?v=-nGe6mxE26c&list=PLLhOnau-tupS6kcWVPWziaNhMpctiZ8kz&index=4', 2, 1, 'Video Clip of \"Courage the Cowardly Dog\"', 'Goat Pain', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Courage_The_Cowardly_Dog_logo.png/500px-Courage_The_Cowardly_Dog_logo.png', 4, 5, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (30, 'https://www.youtube.com/watch?v=PCTBVJHKLTw&list=PLLhOnau-tupS6kcWVPWziaNhMpctiZ8kz&index=6', 2, 3, 'Video Clip of \"Courage the Cowardly Dog\"', 'Bride of Swamp Monster', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Courage_The_Cowardly_Dog_logo.png/500px-Courage_The_Cowardly_Dog_logo.png', 5, 4, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (31, 'https://www.youtube.com/watch?v=XPb-OfacoUI&list=PLLhOnau-tupS6kcWVPWziaNhMpctiZ8kz&index=7', 2, 3, 'Video Clip of \"Courage the Cowardly Dog\"', 'Record Deal', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Courage_The_Cowardly_Dog_logo.png/500px-Courage_The_Cowardly_Dog_logo.png', 2, 3, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (32, 'https://www.youtube.com/watch?v=5-nABwMR67c&list=PLLhOnau-tupS6kcWVPWziaNhMpctiZ8kz&index=8', 2, 4, 'Video Clip of \"Courage the Cowardly Dog\"', 'Campsite of Terror', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Courage_The_Cowardly_Dog_logo.png/500px-Courage_The_Cowardly_Dog_logo.png', 2, 3, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (33, 'https://www.youtube.com/watch?v=-LFOdlGdnp0', 3, 1, 'Full Episode of \"Spongebob Squarepants\"', 'Plankton\'s Old Chum', 'https://upload.wikimedia.org/wikipedia/en/thumb/2/22/SpongeBob_SquarePants_logo_by_Nickelodeon.svg/2560px-SpongeBob_SquarePants_logo_by_Nickelodeon.svg.png', 1, 12, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (34, 'https://www.youtube.com/watch?v=nUAeebYXGdA', 3, 2, 'Full Episode of \"Spongebob Squarepants\"', 'Under The Small Top/ Squidward Sick Daze', 'https://upload.wikimedia.org/wikipedia/en/thumb/2/22/SpongeBob_SquarePants_logo_by_Nickelodeon.svg/2560px-SpongeBob_SquarePants_logo_by_Nickelodeon.svg.png', 2, 13, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (35, 'https://www.youtube.com/watch?v=zSERUgANiYk', 3, 4, 'Full Episode of \"Spongebob Squarepants\"', 'Spin the Bottle', 'https://upload.wikimedia.org/wikipedia/en/thumb/2/22/SpongeBob_SquarePants_logo_by_Nickelodeon.svg/2560px-SpongeBob_SquarePants_logo_by_Nickelodeon.svg.png', 3, 11, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (36, 'https://www.youtube.com/watch?v=7QmGe--FXqU', 3, 2, 'Video Clip of \"Spongebob Squarepants\"', 'The Hall Monitor', 'https://upload.wikimedia.org/wikipedia/en/thumb/2/22/SpongeBob_SquarePants_logo_by_Nickelodeon.svg/2560px-SpongeBob_SquarePants_logo_by_Nickelodeon.svg.png', 7, 1, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (37, 'https://www.youtube.com/watch?v=Bxpdqc84hQI', 3, 3, 'Video Clip of \"Spongebob Squarepants\"', 'Chocolate with Nuts', 'https://upload.wikimedia.org/wikipedia/en/thumb/2/22/SpongeBob_SquarePants_logo_by_Nickelodeon.svg/2560px-SpongeBob_SquarePants_logo_by_Nickelodeon.svg.png', 12, 3, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (38, 'https://www.youtube.com/watch?v=IiyKh1d_U7o', 3, 1, 'Video Clip of \"Spongebob Squarepants\"', 'Squeaky Boots', 'https://upload.wikimedia.org/wikipedia/en/thumb/2/22/SpongeBob_SquarePants_logo_by_Nickelodeon.svg/2560px-SpongeBob_SquarePants_logo_by_Nickelodeon.svg.png', 1, 8, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (39, 'https://www.youtube.com/watch?v=aJB9GuYH0tw&list=PLyCq5M5QVVb-tEXn5axt_DDfFiifycpmJ&index=6', 4, 2, 'Full Episode of \"Grim and Evil\"', 'The Pie Who Loved Me', 'https://upload.wikimedia.org/wikipedia/en/4/47/Grim_%26_Evil_Logo.jpg', 23, 1, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (40, 'https://www.youtube.com/watch?v=DfO2ij0WCSo&list=PLyCq5M5QVVb-tEXn5axt_DDfFiifycpmJ&index=2', 4, 1, 'Intro to Grim and Evil', 'Intro', 'https://upload.wikimedia.org/wikipedia/en/4/47/Grim_%26_Evil_Logo.jpg', 1, 1, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (41, 'https://www.youtube.com/watch?v=N9KGfgg-d8s', 4, 4, 'Video Clip of \"Grim and Evil\"', 'Attack of the Clowns', 'https://upload.wikimedia.org/wikipedia/en/4/47/Grim_%26_Evil_Logo.jpg', 7, 4, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (42, 'https://www.youtube.com/watch?v=z_ZE9I8FbIA', 4, 3, 'Video Clip of \"Grim and Evil\"', 'Attack of the Clowns', 'https://upload.wikimedia.org/wikipedia/en/4/47/Grim_%26_Evil_Logo.jpg', 7, 4, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (43, 'https://www.youtube.com/watch?v=GeSB7C7XQPc', 4, 2, 'Video Clip of \"Grim and Evil\"', 'Dream Mutt', 'https://upload.wikimedia.org/wikipedia/en/4/47/Grim_%26_Evil_Logo.jpg', 10, 4, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (44, 'https://www.youtube.com/watch?v=kIoiw-MB0Vw', 4, 2, 'Video Clip of \"Grim and Evil\"', 'Cod VS Hector', 'https://upload.wikimedia.org/wikipedia/en/4/47/Grim_%26_Evil_Logo.jpg', 3, 1, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (45, 'https://www.youtube.com/watch?v=sOnWSanmwfw', 5, 3, 'Full Episode of \"The Wild Thornberrys\"', 'You Ain\'t Seen Nothin Yeti', 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Thornberryslogo.gif', 11, 2, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (46, 'https://www.youtube.com/watch?v=I9r7MXfSuXc', 5, 1, 'Video Clip of \"The Wild Thornberrys\"', 'Thornberry Island', 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Thornberryslogo.gif', 7, 2, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (47, 'https://www.youtube.com/watch?v=ECWHUxgUFbw', 5, 4, 'Video Clip of \"The Wild Thornberrys\"', 'Dances With Dingos', 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Thornberryslogo.gif', 18, 2, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (48, 'https://www.youtube.com/watch?v=NDO-8N6Z9Ww', 5, 4, 'Video Clip of \"The Wild Thornberrys\"', 'Hot Air', 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Thornberryslogo.gif', 6, 4, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (49, 'https://www.youtube.com/watch?v=oRpUqPAA10o', 5, 1, 'Video Clip of \"The Wild Thornberrys\"', 'The Otter You Know', 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Thornberryslogo.gif', 20, 2, true, '2022-09-29', NULL);
INSERT INTO `media` (`id`, `url`, `cartoon_id`, `user_id`, `description`, `title`, `image`, `episode_number`, `season`, `active`, `created_date`, `updated_date`) VALUES (50, 'https://www.youtube.com/watch?v=5SCgVyzUZPg', 5, 3, 'Video Clip of \"The Wild Thornberrys\"', 'Dinner With Darwin', 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Thornberryslogo.gif', 2, 1, true, '2022-09-29', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (1, 1, 'This is my favorite feels toon.', true, '2022-09-22', NULL, NULL, 1);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (2, 2, 'Love this one!', true, '2022-09-22', NULL, NULL, 2);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (3, 3, 'The feed goes on and on and on.', true, '2022-09-23', NULL, NULL, 3);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (4, 4, 'This series shouldn\'t have turned into Billy and Mandy.', true, '2022-09-23', NULL, NULL, 4);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (5, 1, 'I identify with Donnie on a spiritual level.', true, '2022-09-28', NULL, NULL, 5);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (6, 1, 'I almost forgot about this show', true, '2022-09-28', NULL, NULL, 6);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (7, 1, 'Everyone wants to be Tommy but we all Chucky fr', true, '2022-09-28', NULL, NULL, 7);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (8, 1, 'This was the first cartoon i saw when my family got cable', true, '2022-09-28', NULL, NULL, 8);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (9, 2, 'HIM is the best character.', true, '2022-09-28', NULL, NULL, 9);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (10, 2, 'This toon goes all the way back for me.', true, '2022-09-28', NULL, NULL, 10);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (11, 2, 'Has me laughing laughing everytime', true, '2022-09-28', NULL, NULL, 11);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (12, 2, 'How do they go to the bathroom', true, '2022-09-28', NULL, NULL, 12);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (13, 3, 'Wish I had a scale too', true, '2022-09-28', NULL, NULL, 15);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (14, 3, 'Hey therrrre mama', true, '2022-09-28', NULL, NULL, 16);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (15, 3, 'Yooooo Randall was the worst', true, '2022-09-28', NULL, NULL, 17);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (16, 3, 'Always threw me off that some charcters were blue', true, '2022-09-28', NULL, NULL, 18);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (17, 4, 'What a throwback!', true, '2022-09-28', NULL, NULL, 19);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (18, 4, 'I remember watching this with my brother when I was 5.', true, '2022-09-28', NULL, NULL, 20);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (19, 4, 'This might be better than Looney Tunes', true, '2022-09-28', NULL, NULL, 21);
INSERT INTO `comment` (`id`, `user_id`, `comment`, `active`, `created_date`, `updated_date`, `reply_comment_id`, `cartoon_id`) VALUES (20, 4, 'What are we gonna do tonight?', true, '2022-09-28', NULL, NULL, 22);

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
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (15, 'What is the made up swear word TJ makes up?', 'Womps', 17, '2022-09-28', NULL, true, 3);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (16, 'What is the name of the girl Doug likes?', 'Patti', 18, '2022-09-28', NULL, true, 3);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (17, 'What is the side story called for Dexter\'s monkey?', 'Dial M for Monkey', 19, '2022-09-28', NULL, true, 4);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (18, 'Who made the soundtrack for this series?', 'Danny Elfman', 20, '2022-09-28', NULL, true, 4);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (19, 'What are the names of the Warner brothers and sister?', 'Yakko, Wakko, and Dot', 21, '2022-09-28', NULL, true, 4);
INSERT INTO `trivia` (`id`, `question`, `answer`, `cartoon_id`, `created_date`, `updated_date`, `active`, `user_id`) VALUES (20, 'What is the president that appears in this series?', 'Bill Clinton', 22, '2022-09-28', NULL, true, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `merchandise`
-- -----------------------------------------------------
START TRANSACTION;
USE `toonthrowbackdb`;
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (1, 1, 'https://www.amazon.com/Funko-Pop-Television-Arnold-Collectible/dp/B0759B2LQP/ref=sr_1_2?keywords=hey+arnold+merchandise&qid=1664378817&qu=eyJxc2MiOiI2LjE5IiwicXNhIjoiNS43MCIsInFzcCI6IjQuMDIifQ%3D%3D&sr=8-2', 'https://m.media-amazon.com/images/I/31p+ys6mnGL._AC_UL640_FMwebp_QL65_.jpg', 1, '2022-09-22', NULL, true, 'Bobblehead of Arnold');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (2, 2, 'https://www.amazon.com/Courage-Cowardly-Evil-Inside-T-Shirt/dp/B07RM9X2B3/ref=sr_1_8?keywords=courage+the+cowardly+dog+shirt&qid=1664378931&qu=eyJxc2MiOiI1Ljc3IiwicXNhIjoiNS41MiIsInFzcCI6IjQuODQifQ%3D%3D&sr=8-8', '0%2C2000%7C81OIGV84npL.png%7C0%2C0%2C2140%2C2000%2B0.0%2C0.0%2C2140.0%2C2000.0_AC_UX679_.png', 2, '2022-09-22', NULL, true, 'T-shirt of Courage freaking out');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (3, 3, 'https://www.amazon.com/Spongebob-SquarePants-Attack-Humorous-T-Shirt/dp/B07C8Y7XVS/ref=sr_1_2?keywords=Spongebob+Merchandise&qid=1664379048&qu=eyJxc2MiOiI3LjYxIiwicXNhIjoiNy4yMyIsInFzcCI6IjYuMzEifQ%3D%3D&sr=8-2', 'https://m.media-amazon.com/images/I/A13usaonutL._CLa%7C2140%2C2000%7CA1mG0Kg15GL.png%7C0%2C0%2C2140%2C2000%2B0.0%2C0.0%2C2140.0%2C2000.0_AC_UX679_.png', 3, '2022-09-23', NULL, true, 'Spongebob shark attack T-Shirt');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (4, 5, 'https://www.truffleshuffle.co.uk/product/33252/the-wild-thornberrys-nigel-smashing-green-hoodie', 'https://c49d16a6c82563251344-1ab5a5b00ecdd96a368a8d8d17482920.ssl.cf2.rackcdn.com/images/TS_The_Wild_Thornberrys_Nigel_Smashing_Green_Hoodie_39_99_1-380-405.jpg', 1, '2022-09-28', NULL, true, '\"Smashing\" Nigel Thornberry Hoody');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (5, 6, 'https://www.redbubble.com/i/iphone-case/Pepper-Ann-retro-by-deadbeatdaughtr/80163132.9YLDE', 'https://ih1.redbubble.net/image.2433806037.3132/icr,iphone_14_tough,back,a,x600-pad,600x600,f8f8f8.jpg', 1, '2022-09-28', NULL, true, 'Pepper Ann retro iPhone case');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (6, 7, 'https://www.amazon.com/Nickelodeon-Ladies-Rugrats-Reptar-Slides/dp/B0B7KDLFTM/ref=sr_1_3?keywords=Rugrats&qid=1664379357&qu=eyJxc2MiOiI1Ljg1IiwicXNhIjoiNy41NiIsInFzcCI6IjQuNDkifQ%3D%3D&s=apparel&sr=1-3', 'https://m.media-amazon.com/images/I/81eslPlVmJL._AC_UY695_.jpg', 1, '2022-09-28', NULL, true, 'Rugrats themed sliders');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (7, 8, 'https://www.redbubble.com/i/sticker/Rocket-Power-Speed-Skate-by-hrubiks/32955129.EJUG5', 'https://ih1.redbubble.net/image.608450741.5129/st,small,507x507-pad,600x600,f8f8f8.jpg', 1, '2022-09-28', NULL, true, 'Otto Rocket skating sticker');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (8, 9, 'https://www.hottopic.com/product/the-powerpuff-girls-him-glitter-enamel-pin/19047566.html', 'https://cdn.media.amplience.net/s/hottopic/19047565_hi?$productMainDesktopRetina$', 2, '2022-09-28', NULL, true, 'Powerpuff Girls\' HIM enamel pin');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (9, 10, 'https://www.redbubble.com/i/sticker/Krumm-by-vfall/34274149.EJUG5', 'https://ih1.redbubble.net/image.3775611624.4149/st,small,507x507-pad,600x600,f8f8f8.u3.jpg', 2, '2022-09-28', NULL, true, 'Krumm sticker');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (10, 11, 'https://www.hottopic.com/product/cartoon-network-cow-and-chicken-thankful-pumpkins-t-shirt/19928596.html', 'https://cdn.media.amplience.net/s/hottopic/19928596_hi?$productMainDesktopRetina$', 2, '2022-09-28', NULL, true, 'Thanksgiving themed Cow and Chicken T-shirt');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (11, 12, 'https://www.redbubble.com/i/throw-blanket/CATDOG-by-hendysoegiar/42556575.NZ8A6', 'https://ih1.redbubble.net/image.971688602.6575/ur,blanket_large_bed,square,x600.1.jpg', 2, '2022-09-28', NULL, true, 'CatDog throw blanket');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (12, 15, 'https://www.redbubble.com/i/t-shirt/Dragon-Tales-Graphic-by-zachhay/57687343.WFLAH', 'https://ih1.redbubble.net/image.1663537768.7343/ssrco,classic_tee,mens,fafafa:ca443f4786,front_alt,square_product,600x600.jpg', 3, '2022-09-28', NULL, true, 'Dragon Tales all characters T-shirt');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (13, 16, 'https://www.redbubble.com/i/sticker/Johnny-Bravo-Whoa-Mama-Meme-3d-Effect-by-sketchNkustom/47180453.EJUG5', 'https://ih1.redbubble.net/image.1163198425.0453/st,small,507x507-pad,600x600,f8f8f8.u1.jpg', 3, '2022-09-28', NULL, true, 'Jonny Bravo \"Woah Mama\" sticker');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (14, 1, 'https://www.redbubble.com/i/sticker/Arnold-Hey-by-redblueyellowd/50013377.EJUG5', 'https://ih1.redbubble.net/image.1294169184.3377/st,small,507x507-pad,600x600,f8f8f8.jpg', 1, '2022-09-28', NULL, true, 'Arnold meditating sticker');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (15, 17, 'https://www.etsy.com/uk/listing/708003558/king-bob-recess-custom-enamel-pin-pins?ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=recess&ref=sc_gallery-1-3&plkey=9cc58e07802d938bb021e54dc296986c52502986%3A708003558', 'https://i.etsystatic.com/20047974/r/il/43d60f/1992357159/il_1588xN.1992357159_2waj.jpg', 3, '2022-09-28', NULL, true, 'Recess\' King Bob enamel pin');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (16, 18, 'https://www.etsy.com/uk/listing/1172179702/dougs-new-shoes-enamel-pin?ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=doug&ref=sc_gallery-1-3&cns=1&sts=1&plkey=8dd76e705f6561cea5fd720694e1395c1faccaf6%3A1172179702', 'https://i.etsystatic.com/12692063/r/il/1058db/3696615770/il_1588xN.3696615770_g9u1.jpg', 3, '2022-09-28', NULL, true, 'Doug\'s new shoes enamel pin');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (17, 19, 'https://www.etsy.com/uk/listing/1015129206/90s-retro-unisex-cartoon-socks?ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=dexters+laboratory&ref=sr_gallery-1-4&frs=1&col=1', 'https://i.etsystatic.com/30174915/r/il/5ce09b/4029188780/il_1588xN.4029188780_eq4s.jpg', 4, '2022-09-28', NULL, true, 'Dexter unisex socks');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (18, 20, 'https://www.amazon.com/Batman-Animated-Logo-Shirt-Stickers/dp/B07N961B3D', 'https://m.media-amazon.com/images/I/61UxpC8FjkL._AC_UX679_.jpg', 4, '2022-09-28', NULL, true, 'Batman: TAS T-Shirt');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (19, 21, 'https://www.zazzle.com/animaniacs_yakkos_world_map_graphic_trucker_hat-148710240659770076', 'https://rlv.zcache.com/animaniacs_yakkos_world_map_graphic_trucker_hat-r63a79e217a284d059560d42a66216477_eahwb_8byvr_648.jpg', 4, '2022-09-28', NULL, true, 'Yakko world map trucker hat');
INSERT INTO `merchandise` (`id`, `cartoon_id`, `url`, `image`, `user_id`, `created_date`, `update_date`, `active`, `description`) VALUES (20, 22, 'https://www.amazon.com/Pinky-Brain-T-Shirt/dp/B0866125MP', 'https://m.media-amazon.com/images/I/B1OGJ8t+8ZS._CLa%7C2140%2C2000%7C71Av-BCk6DL.png%7C0%2C0%2C2140%2C2000%2B0.0%2C0.0%2C2140.0%2C2000.0_AC_UX679_.png', 4, '2022-09-28', NULL, true, 'The Brain T-shirt');

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
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (16, 'The town Doug lives in, Bluffington, is based on Richmond, VA.', 18, 3, true, '2022-09-28', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (17, 'A season two episode was removed because the censors would not allow even bleeped curses.', 19, 4, true, '2022-09-28', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (18, 'This was the first super hero franchise to portray in film noir style.', 20, 4, true, '2022-09-28', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (19, 'This series was moved to The WB after showing success on Fox.', 21, 4, true, '2022-09-28', NULL);
INSERT INTO `fact` (`id`, `fact`, `cartoon_id`, `user_id`, `active`, `created_date`, `updated_date`) VALUES (20, 'This is one of four animations co created by Steven Spielberg.', 22, 3, true, '2022-09-28', NULL);

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
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (18, 3);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (19, 4);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (20, 4);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (21, 4);
INSERT INTO `favorite` (`cartoon_id`, `user_id`) VALUES (22, 4);

COMMIT;

