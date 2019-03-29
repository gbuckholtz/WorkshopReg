use workshopbooking;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS PERSON;
DROP TABLE IF EXISTS ROLES;
DROP TABLE IF EXISTS DEPARTMENTS;
DROP TABLE IF EXISTS WORKSHOPS;
DROP TABLE IF EXISTS CATALOGUE;
DROP TABLE IF EXISTS REGISTRATIONS;
DROP TABLE IF EXISTS FACILITATORS;
DROP TABLE IF EXISTS WAITLIST;
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
    department_id INTEGER,
    -- add assumption: user do not need to belong to a department
    foreign key (department_id) references departments(department_id) on delete set null,
    foreign key (role_id) references roles(role_id) on delete cascade
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
    current_participants INTEGER NOT NULL,
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
    attend boolean NOT NULL,
    PRIMARY KEY(workshop_id, net_id),
    foreign key (workshop_id) references workshops(workshop_id) on delete cascade,
    foreign key (net_id) references person(net_id) on delete cascade
);

CREATE TABLE WAITLIST (
    workshop_id INTEGER NOT NULL,
    net_id VARCHAR(10) NOT NULL,
    PRIMARY KEY(workshop_id, net_id),
    foreign key (workshop_id) references workshops(workshop_id) on delete cascade,
    foreign key (net_id) references person(net_id) on delete cascade
);

CREATE TABLE REVIEWS (
    workshop_id INTEGER NOT NULL,
    net_id VARCHAR(10) NOT NULL,
    review VARCHAR(1000) NOT NULL,
    PRIMARY KEY(workshop_id, net_id),
    foreign key (workshop_id) references workshops(workshop_id) on delete cascade,
    foreign key (net_id) references person(net_id) on delete cascade
);

CREATE TABLE LOCATIONS (
    location_name VARCHAR(100) NOT NULL PRIMARY KEY
);

CREATE TABLE EVENT_STATUS (
    event_status VARCHAR(20) NOT NULL PRIMARY KEY
);

-- Constraints for table PERSON
ALTER TABLE PERSON ADD CONSTRAINT FOREIGN KEY (role_id) REFERENCES ROLES (role_id);
ALTER TABLE PERSON ADD CONSTRAINT FOREIGN KEY (department_id) REFERENCES DEPARTMENTS (department_id);
ALTER TABLE PERSON ALTER role_id SET DEFAULT 0;
ALTER TABLE PERSON ALTER department_id SET DEFAULT 1;

-- Constraints for table ROLES
-- none

-- Constraints for table DEPARTMENTS
-- none

-- Constraints for table WORKSHOPS
ALTER TABLE WORKSHOPS ADD CONSTRAINT FOREIGN KEY (workshop_creator_id) REFERENCES PERSON (net_id);
ALTER TABLE WORKSHOPS ADD CONSTRAINT FOREIGN KEY (department_id) REFERENCES DEPARTMENTS (department_id);
ALTER TABLE WORKSHOPS ADD CONSTRAINT FOREIGN KEY (event_status) REFERENCES EVENT_STATUS (event_status);
ALTER TABLE WORKSHOPS ALTER current_participants SET DEFAULT 0;
ALTER TABLE WORKSHOPS ALTER email_notification_name SET DEFAULT '';
ALTER TABLE WORKSHOPS ALTER email_confirmation_msg SET DEFAULT '';
ALTER TABLE WORKSHOPS ALTER email_waitlist_msg SET DEFAULT '';
ALTER TABLE WORKSHOPS ALTER email_cancellation_msg SET DEFAULT '';
ALTER TABLE WORKSHOPS ALTER email_evaluation_msg SET DEFAULT '';

-- Constraints for table FACILITATORS
ALTER TABLE FACILITATORS ADD CONSTRAINT FOREIGN KEY (workshop_id) REFERENCES WORKSHOPS (workshop_id);
ALTER TABLE FACILITATORS ADD CONSTRAINT FOREIGN KEY (facilitator_id) REFERENCES PERSON (net_id);

-- Constraints for table REGISTRATIONS
ALTER TABLE REGISTRATIONS ADD CONSTRAINT FOREIGN KEY (workshop_id) REFERENCES WORKSHOPS (workshop_id);
ALTER TABLE REGISTRATIONS ADD CONSTRAINT FOREIGN KEY (net_id) REFERENCES PERSON (net_id);

-- Constraints for table WAITLIST
ALTER TABLE WAITLIST ADD CONSTRAINT FOREIGN KEY (workshop_id) REFERENCES WORKSHOPS (workshop_id);
ALTER TABLE WAITLIST ADD CONSTRAINT FOREIGN KEY (net_id) REFERENCES PERSON (net_id);

-- Constraints for table REVIEWS
ALTER TABLE REVIEWS ADD CONSTRAINT FOREIGN KEY (workshop_id) REFERENCES WORKSHOPS (workshop_id);
ALTER TABLE REVIEWS ADD CONSTRAINT FOREIGN KEY (net_id) REFERENCES PERSON (net_id);

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
INSERT INTO DEPARTMENTS VALUES (3, "Arts & Science");

-- ADD LOCATIONS
INSERT INTO LOCATIONS VALUES ("Dunning Hall");
INSERT INTO LOCATIONS VALUES ("Walter Light Hall");
INSERT INTO LOCATIONS VALUES ("Goodes Hall");
INSERT INTO LOCATIONS VALUES ("Stauffer Lib");

-- ADD EVENT_STATUSES
INSERT INTO EVENT_STATUS VALUES ("Not Posted");
INSERT INTO EVENT_STATUS VALUES ("Posted");
INSERT INTO EVENT_STATUS VALUES ("Archived");

-- ADD FAKE DATA
INSERT INTO PERSON VALUES ("15dny", 12345678, "Daniel K.", "15dny@queensu.ca", 1, 2);
INSERT INTO PERSON VALUES ("13tpv", 62575632, "Tanner V.", "13tpv@queensu.ca", 1, DEFAULT);
INSERT INTO PERSON VALUES ("11ern", 85317453, "Elise N.", "11ern@queensu.ca", 1, DEFAULT);
INSERT INTO PERSON VALUES ("emmah", 57338531, "Emma H.", "emma_h@queensu.ca", 3, 2);
INSERT INTO WORKSHOPS VALUES (NULL, "emmah", 3, "How to Stay Awake in Class", "Learn to stay focused!", "Walter Light Hall", 100, 5,20, '2019-01-05 10:00:00', '2019-01-05 11:30:00', '2019-02-05 10:00:00', '2019-02-05 11:30:00', "Archived", DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO WORKSHOPS VALUES (NULL, "emmah", 1, "How to Study Effectively", "Learn how to study effectively!", "Dunning Hall", 100, DEFAULT,30, '2019-04-01 14:00:00', '2019-04-15 16:00:00', '2019-04-16 14:00:00', '2019-04-16 16:00:00', "Posted", "HelloName", "Cancel Message", "Wait Message", "cancel Message", "Eval Message");
INSERT INTO WORKSHOPS VALUES (NULL, "emmah", 2, "How to Make New Friends", "Get lots of friends!", "Goodes Hall", 100, DEFAULT,27, '2019-04-12 18:30:00', '2019-04-17 20:00:00', '2019-04-18 18:30:00', '2019-04-18 20:00:00', "Posted", DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO WORKSHOPS VALUES (NULL, "15dny", 1, "How to Think Smart", "Think less, learn more", "Goodes Hall", 100, DEFAULT,28, '2019-04-02 15:45:00', '2019-04-08 17:30:00', '2019-04-09 15:45:00', '2019-04-09 17:30:00', "Posted", DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO WORKSHOPS VALUES (NULL, "15dny", 3, "How to Express Yourself", "Get to know yourself before others!", "Dunning Hall", 100, DEFAULT,77, '2019-04-15 16:15:00', '2019-05-01 18:00:00', '2019-05-02 16:15:00', '2019-05-02 18:00:00', "Posted", DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO REVIEWS VALUES (1, "15dny", "Loved it!");

INSERT INTO REGISTRATIONS VALUES (1, "15dny",true);
INSERT INTO REGISTRATIONS VALUES (2, "15dny",true);
INSERT INTO REGISTRATIONS VALUES (3, "15dny",true);
INSERT INTO REGISTRATIONS VALUES (2, "13tpv",false);
INSERT INTO REGISTRATIONS VALUES (3, "13tpv",false);
INSERT INTO REGISTRATIONS VALUES (1, "11ern",false);
INSERT INTO FACILITATORS VALUES (1, "emmah");
INSERT INTO FACILITATORS VALUES (1, "13tpv");
