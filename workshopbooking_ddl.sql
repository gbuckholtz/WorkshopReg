use workshopbooking;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS PERSON;
DROP TABLE IF EXISTS ROLES;
DROP TABLE IF EXISTS DEPARTMENTS;
DROP TABLE IF EXISTS WORKSHOPS;
DROP TABLE IF EXISTS CATALOGUE;
DROP TABLE IF EXISTS FACILITATORS;
DROP TABLE IF EXISTS REGISTRATIONS;
DROP TABLE IF EXISTS WAITLIST;
DROP TABLE IF EXISTS ATTENDANCE;
DROP TABLE IF EXISTS REVIEWS;
DROP TABLE IF EXISTS LOCATIONS;
DROP TABLE IF EXISTS EVENT_STATUS;

CREATE TABLE PERSON (
    net_id VARCHAR(10) NOT NULL PRIMARY KEY,
    -- Todo: Should this empl_id have the same var as net_id? 
    empl_id INTEGER NOT NULL,
    common_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    role_id INTEGER NOT NULL,
    department_id INTEGER
);

CREATE TABLE ROLES (
    role_id INTEGER NOT NULL PRIMARY KEY,
    role_name VARCHAR(20) NOT NULL
);

CREATE TABLE DEPARTMENTS (
    department_id INTEGER NOT NULL PRIMARY KEY,
    department_name VARCHAR(20) NOT NULL
);

CREATE TABLE WORKSHOPS (
    workshop_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    workshop_creator_id VARCHAR(10) NOT NULL,
    department_id INTEGER NOT NULL,
    title VARCHAR(100) NOT NULL,
    details VARCHAR(500) NOT NULL,
    location VARCHAR(200) NOT NULL,
    max_participants INTEGER NOT NULL,
    waitlist_limit INTEGER NOT NULL,
	registration_start DATETIME NOT NULL,
    registration_end DATETIME NOT NULL,
    event_start DATETIME NOT NULL,
    event_end DATETIME NOT NULL,
    event_status VARCHAR(20) NOT NULL,
    email_notification_name VARCHAR(50),
    email_confirmation_msg VARCHAR(300),
    email_waitlist_msg VARCHAR(300),
    email_cancellation_msg VARCHAR(300),
    email_evaluation_msg VARCHAR(300)
);

CREATE TABLE FACILITATORS (
	workshop_id INTEGER NOT NULL,
    facilitator_id VARCHAR(10) NOT NULL,
    PRIMARY KEY(workshop_id, facilitator_id)
);

CREATE TABLE REGISTRATIONS (
    workshop_id INTEGER NOT NULL,
    net_id VARCHAR(10) NOT NULL,
    PRIMARY KEY(workshop_id, net_id)
);

CREATE TABLE WAITLIST (
    workshop_id INTEGER NOT NULL,
    net_id VARCHAR(10) NOT NULL,
	datetime_applied DATETIME NOT NULL,
    PRIMARY KEY(workshop_id, net_id)
);

CREATE TABLE ATTENDANCE (
    workshop_id INTEGER NOT NULL,
    net_id VARCHAR(10) NOT NULL,
    attended boolean NOT NULL,
    PRIMARY KEY(workshop_id, net_id)
);

CREATE TABLE REVIEWS (
    workshop_id INTEGER NOT NULL,
    net_id VARCHAR(10) NOT NULL,
    review VARCHAR(1000) NOT NULL,
    PRIMARY KEY(workshop_id, net_id)
);

CREATE TABLE LOCATIONS (
    location_name VARCHAR(100) NOT NULL PRIMARY KEY
);

CREATE TABLE EVENT_STATUS (
    event_status VARCHAR(20) NOT NULL PRIMARY KEY
);

-- Constraints for table PERSON
ALTER TABLE PERSON ADD CONSTRAINT FOREIGN KEY (role_id) REFERENCES ROLES (role_id) ON DELETE CASCADE;
ALTER TABLE PERSON ADD CONSTRAINT FOREIGN KEY (department_id) REFERENCES DEPARTMENTS (department_id) ON DELETE CASCADE;
ALTER TABLE PERSON ALTER role_id SET DEFAULT 0;
ALTER TABLE PERSON ALTER department_id SET DEFAULT 0;

-- Constraints for table ROLES
-- none

-- Constraints for table DEPARTMENTS
-- none

-- Constraints for table WORKSHOPS
ALTER TABLE WORKSHOPS ADD CONSTRAINT FOREIGN KEY (workshop_creator_id) REFERENCES PERSON (net_id) ON DELETE CASCADE;
ALTER TABLE WORKSHOPS ADD CONSTRAINT FOREIGN KEY (department_id) REFERENCES DEPARTMENTS (department_id) ON DELETE CASCADE;
ALTER TABLE WORKSHOPS ADD CONSTRAINT FOREIGN KEY (event_status) REFERENCES EVENT_STATUS (event_status) ON DELETE CASCADE;
ALTER TABLE WORKSHOPS ALTER email_notification_name SET DEFAULT '';
ALTER TABLE WORKSHOPS ALTER email_confirmation_msg SET DEFAULT '';
ALTER TABLE WORKSHOPS ALTER email_waitlist_msg SET DEFAULT '';
ALTER TABLE WORKSHOPS ALTER email_cancellation_msg SET DEFAULT '';
ALTER TABLE WORKSHOPS ALTER email_evaluation_msg SET DEFAULT '';

-- Constraints for table FACILITATORS
ALTER TABLE FACILITATORS ADD CONSTRAINT FOREIGN KEY (workshop_id) REFERENCES WORKSHOPS (workshop_id) ON DELETE CASCADE;
ALTER TABLE FACILITATORS ADD CONSTRAINT FOREIGN KEY (facilitator_id) REFERENCES PERSON (net_id) ON DELETE CASCADE;

-- Constraints for table REGISTRATIONS
ALTER TABLE REGISTRATIONS ADD CONSTRAINT FOREIGN KEY (workshop_id) REFERENCES WORKSHOPS (workshop_id) ON DELETE CASCADE;
ALTER TABLE REGISTRATIONS ADD CONSTRAINT FOREIGN KEY (net_id) REFERENCES PERSON (net_id) ON DELETE CASCADE;

-- Constraints for table WAITLIST
ALTER TABLE WAITLIST ADD CONSTRAINT FOREIGN KEY (workshop_id) REFERENCES WORKSHOPS (workshop_id) ON DELETE CASCADE;
ALTER TABLE WAITLIST ADD CONSTRAINT FOREIGN KEY (net_id) REFERENCES PERSON (net_id) ON DELETE CASCADE;

-- Constraints for table ATTENDANCE
ALTER TABLE ATTENDANCE ADD CONSTRAINT FOREIGN KEY (workshop_id) REFERENCES WORKSHOPS (workshop_id) ON DELETE CASCADE;
ALTER TABLE ATTENDANCE ADD CONSTRAINT FOREIGN KEY (net_id) REFERENCES PERSON (net_id) ON DELETE CASCADE;
ALTER TABLE ATTENDANCE ALTER attended SET DEFAULT FALSE;

-- Constraints for table REVIEWS
ALTER TABLE REVIEWS ADD CONSTRAINT FOREIGN KEY (workshop_id) REFERENCES WORKSHOPS (workshop_id) ON DELETE CASCADE;
ALTER TABLE REVIEWS ADD CONSTRAINT FOREIGN KEY (net_id) REFERENCES PERSON (net_id) ON DELETE CASCADE;

-- Constraints for table LOCATIONS
-- none

-- Constraints for table EVENT_STATUS
-- none


-- ADD ROLES
INSERT INTO ROLES VALUES (0, "Guest");
INSERT INTO ROLES VALUES (1, "Authenticated User");
INSERT INTO ROLES VALUES (2, "Workshop Host");
INSERT INTO ROLES VALUES (3, "Workshop Creator");
INSERT INTO ROLES VALUES (4, "Department Head");
INSERT INTO ROLES VALUES (5, "Administrator");

-- ADD DEPARTMENTS
INSERT INTO DEPARTMENTS VALUES (1, "Medical");
INSERT INTO DEPARTMENTS VALUES (2, "Engineering");
INSERT INTO DEPARTMENTS VALUES (3, "Arts and Science");
INSERT INTO DEPARTMENTS VALUES (4, "Queens ITS");

-- ADD LOCATIONS
INSERT INTO LOCATIONS VALUES ("Dunning Hall");
INSERT INTO LOCATIONS VALUES ("Walter Light Hall");
INSERT INTO LOCATIONS VALUES ("Goodes Hall");
INSERT INTO LOCATIONS VALUES ("Stauffer Library");

-- ADD EVENT_STATUSES
INSERT INTO EVENT_STATUS VALUES ("Not Posted");
INSERT INTO EVENT_STATUS VALUES ("Posted");
INSERT INTO EVENT_STATUS VALUES ("Archived");

-- ADD FAKE DATA
INSERT INTO PERSON VALUES ("15dny", 12345678, "Daniel K.", "15dny@queensu.ca", 3, 2);
INSERT INTO PERSON VALUES ("13tpv", 62575632, "Tanner V.", "13tpv@queensu.ca", 1, DEFAULT);
INSERT INTO PERSON VALUES ("11ern", 85317453, "Elise N.", "11ern@queensu.ca", 1, DEFAULT);
INSERT INTO PERSON VALUES ("emmah", 57338531, "Emma H.", "emma_h@queensu.ca", 3, 2);
INSERT INTO PERSON VALUES ("HostForAll", 11111111, "TestHoster", "test.host@queensu.ca", 2, 1);
INSERT INTO PERSON VALUES ("Admin_A", 99999999, "Sterling Archer", "archer@queensu.ca", 5, 4);
INSERT INTO PERSON VALUES ("D_Krieger", 88888888, "Dr. Krieger", "krieger@queensu.ca", 4, 4);
INSERT INTO PERSON VALUES ("Creator", 77777777, "Cheryl Tunt", "cheryl@queensu.ca", 3, 4);
INSERT INTO PERSON VALUES ("HostLana", 66666666, "Lana Kane", "lana.k@queensu.ca", 2, 4);

INSERT INTO WORKSHOPS VALUES (NULL, "Creator", 3, "How to Stay Awake in Class", "Learn to stay focused!", "Walter Light Hall", 100, 20, '2019-01-05 10:00:00', '2019-01-05 11:30:00', '2019-02-05 10:00:00', '2019-02-05 11:30:00', "Archived", "Hello Workshop1", "Confirm Message Workshop1", "Wait Message Workshop1", "Cancel Message Workshop1", "Eval Message Workshop1");
INSERT INTO WORKSHOPS VALUES (NULL, "emmah", 1, "How to Study Effectively", "Learn how to study effectively!", "Dunning Hall", 100, 30, '2019-04-01 14:00:00', '2019-04-15 16:00:00', '2019-04-16 14:00:00', '2019-04-16 16:00:00', "Posted", "Hello Name", "Confirm Message", "Wait Message", "Cancel Message", "Eval Message");
INSERT INTO WORKSHOPS VALUES (NULL, "emmah", 2, "How to Make New Friends", "Get lots of friends!", "Goodes Hall", 100, 27, '2019-04-12 18:30:00', '2019-04-17 20:00:00', '2019-04-18 18:30:00', '2019-04-18 20:00:00', "Posted", DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO WORKSHOPS VALUES (NULL, "15dny", 1, "How to Think Smart", "Think less, learn more", "Goodes Hall", 100, 28, '2019-04-02 15:45:00', '2019-04-08 17:30:00', '2019-04-09 15:45:00', '2019-04-09 17:30:00', "Posted", DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO WORKSHOPS VALUES (NULL, "15dny", 3, "How to Express Yourself", "Get to know yourself before others!", "Dunning Hall", 100, 77, '2019-04-15 16:15:00', '2019-05-01 18:00:00', '2019-05-02 16:15:00', '2019-05-02 18:00:00', "Posted", DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO REVIEWS VALUES (1, "15dny", "Loved it!");
INSERT INTO REVIEWS VALUES (1, "13tpv", "Enjoy!");

INSERT INTO REGISTRATIONS VALUES (1, "15dny");
INSERT INTO REGISTRATIONS VALUES (3, "15dny");
INSERT INTO REGISTRATIONS VALUES (2, "13tpv");
INSERT INTO REGISTRATIONS VALUES (1, "13tpv");
INSERT INTO REGISTRATIONS VALUES (3, "13tpv");
INSERT INTO REGISTRATIONS VALUES (1, "11ern");
INSERT INTO REGISTRATIONS VALUES (1, "HostForAll");
INSERT INTO REGISTRATIONS VALUES (2, "HostForAll");
INSERT INTO REGISTRATIONS VALUES (3, "HostForAll");
INSERT INTO REGISTRATIONS VALUES (4, "HostForAll");
INSERT INTO REGISTRATIONS VALUES (5, "HostForAll");

INSERT INTO ATTENDANCE VALUES (1, "15dny", true);
INSERT INTO ATTENDANCE VALUES (3, "15dny", true);
INSERT INTO ATTENDANCE VALUES (2, "13tpv", false);
INSERT INTO ATTENDANCE VALUES (3, "13tpv", false);
INSERT INTO ATTENDANCE VALUES (1, "11ern", false);
INSERT INTO ATTENDANCE VALUES (1, "HostForAll", true);
INSERT INTO ATTENDANCE VALUES (2, "HostForAll", true);
INSERT INTO ATTENDANCE VALUES (3, "HostForAll", true);
INSERT INTO ATTENDANCE VALUES (4, "HostForAll", true);
INSERT INTO ATTENDANCE VALUES (5, "HostForAll", true);

INSERT INTO FACILITATORS VALUES (1, "emmah");
INSERT INTO FACILITATORS VALUES (1, "13tpv");
INSERT INTO FACILITATORS VALUES (1, "HostForAll");
INSERT INTO FACILITATORS VALUES (2, "HostForAll");
INSERT INTO FACILITATORS VALUES (3, "HostForAll");
INSERT INTO FACILITATORS VALUES (4, "HostForAll");
INSERT INTO FACILITATORS VALUES (5, "HostForAll");
INSERT INTO FACILITATORS VALUES (5,"HostLana");
