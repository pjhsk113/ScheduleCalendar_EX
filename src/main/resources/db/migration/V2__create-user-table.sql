--
-- V2: Create Schedule TABLE
--
--
CREATE TABLE `Schedule`(
`event_id` int NOT NULL AUTO_INCREMENT,
`title` varchar(50) NOT NULL,
`content` text NOT NULL,
`start_date` date NOT NULL,
`start_time` time NOT NULL,
`end_date` date NOT NULL,
`end_time` time NOT NULL,
`allday` tinyint(1) default 0,
`repeats` int(5) default 0,
`day` int,
`sub_date` int,
PRIMARY KEY(event_id))
ENGINE=InnoDB DEFAULT CHARSET `utf8`;