# Group
# Matt De Filippo (30202259)
# Gi-E Thang (30031722)
# Jeremy Sugimoto (30232526)
# Shad Sajid (30021753)

DROP DATABASE IF EXISTS CIRQUEDUSOLEIL;
CREATE DATABASE CIRQUEDUSOLEIL; 
USE CIRQUEDUSOLEIL;

DROP TABLE IF EXISTS PERFORMER;
CREATE TABLE PERFORMER (
	PerformerID				int not null,
    FName					varchar(50),
    LName					varchar(50),
    Citizenship				varchar(50),
    Birthdate				DATE,
    Medications				text,
    Diet					text,
    Classification		varchar(50),
    UnderstudyID			int UNIQUE,
    foreign key (UnderstudyID) references PERFORMER(PerformerID) ON DELETE CASCADE ON UPDATE CASCADE,
    primary key (PerformerID)
);

INSERT INTO PERFORMER (PerformerID, FName, LName, Citizenship, Birthdate, Medications, Diet, Classification, UnderstudyID)
VALUES
(2100, 'Chris', 'Moore', 'Canada', '1995-04-23', 'None', 'Vegan', 'Musician', NULL),
(3535, 'Alison', 'Grave', 'USA', '1998-05-18', 'Antibiotics', 'None', 'Entertainer', 2100),
(6666, 'Bob', 'Johnson', 'Australia', '1990-10-11', 'None', 'None', 'Aerialist', NULL),
(1234, 'Emily', 'Smith', 'UK', '1993-08-15', 'None', 'Vegetarian', 'Musician', NULL),
(5678, 'David', 'Lee', 'South Korea', '1996-03-27', 'None', 'Paleo', 'Entertainer', 1234),
(9999, 'Jessica', 'Miller', 'USA', '1988-12-05', 'Allergy medication', 'Gluten-free', 'Aerialist', NULL);

DROP TABLE IF EXISTS SHOWS;
CREATE TABLE SHOWS (
	Show_name				varchar(100),
    Performance_year		integer,
    Sponsor 				varchar(50),
    Producer				varchar(50),
    primary key (Show_name, Performance_year)
);

INSERT INTO SHOWS (Show_name, Performance_year, Sponsor, Producer)
VALUES
('Alegeria', 2020, 'SunLife', 'Matthieu Laplante'),
('Bazzar', 2023, 'Mastercard', 'Chriss Angel');

DROP TABLE IF EXISTS PERFORMS_IN;
CREATE TABLE PERFORMS_IN (
PerformerID				int,
Show_name 				varchar(50),
Performance_year 		int,
primary key (PerformerID, Show_name, Performance_year),
 foreign key (Show_name, Performance_year) references SHOWS(Show_name, Performance_year) ON DELETE CASCADE ON UPDATE CASCADE,
foreign key (PerformerID) references PERFORMER(PerformerID) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO PERFORMS_IN (PerformerID, Show_name, Performance_year)
VALUES
(2100, 'Alegeria', 2020),
(3535, 'Alegeria', 2020),
(6666, 'Bazzar', 2023),
(1234, 'Bazzar', 2023);


DROP TABLE IF EXISTS VENUE;
CREATE TABLE VENUE (
	VenueID					int not null,
    Venue_name			    varchar(100),
    Capacity				integer,
    Street_address			varchar(35),
    City					varchar(50),
    Province_state			varchar(50),
    Transit_accessible		boolean,
    primary key (VenueID)
);

INSERT INTO VENUE (VenueID, Venue_name, Capacity, Street_address, City, Province_state, Transit_accessible)
VALUES
('001', 'Big Four', '4000', '1801 Big Four Trail SE', 'Calgary', 'Alberta', '1'),
('002', 'Edmonton Convention Centre', '5000', '9797 Jasper Ave', 'Edmonton', 'Alberta', '0');

DROP TABLE IF EXISTS HOST;
CREATE TABLE HOST (
	Show_name 				varchar(50),
    Performance_year 		integer,
    VenueID					int,
    Show_date				DATE,
    Host_date				DATE,
    Host_location			varchar(50),
    PRIMARY KEY (Show_name, Performance_Year, VenueID),
    foreign key (Show_name, Performance_year) references SHOWS(Show_name, Performance_year) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (VenueID) references VENUE(VenueID) ON DELETE CASCADE ON UPDATE CASCADE
    
);

INSERT INTO HOST (Show_Name, Performance_year, VenueID, Show_date, Host_date, Host_location)
VALUES
('Alegeria', 2020, '001', '2020-02-16', '2020-02-16', 'Big Four'),
('Bazzar', 2023, '002', '2023-12-07', '2023-12-07', 'Edmonton Convention Centre');


DROP TABLE IF EXISTS EMERGENCY_CONTACT;
CREATE TABLE EMERGENCY_CONTACT (
	PerformerID				int not null,
    Contact_FName			varchar(50),
    Contact_LName			varchar(50),
    PhoneNumber				varchar(50),
    Relationship			varchar(50),
    PRIMARY KEY (PerformerID),
    foreign key (PerformerID) references PERFORMER(PerformerID) ON DELETE CASCADE ON UPDATE CASCADE
	);
    
INSERT INTO EMERGENCY_CONTACT (PerformerID, Contact_FName, Contact_LName, PhoneNumber, Relationship)
VALUES
('2100', 'John', 'Moore', '403-327-4723', 'Father'),
('3535', 'Jane', 'Grave', '780-482-1648', 'Mother'),
('6666', 'Louis', 'Johnson', '587-245-3566', 'Wife'),
('1234', 'Michael', 'Smith', '44-20-7123-4567', 'Brother'),
('5678', 'Sophia', 'Lee', '82-2-3456-7890', 'Sister'),
('9999', 'Richard', 'Miller', '1-800-555-1234', 'Spouse');


DROP TABLE IF EXISTS MUSICIAN;
CREATE TABLE MUSICIAN (
	PerformerID				int not null,
    PRIMARY KEY (PerformerID),
    foreign key (PerformerID) references PERFORMER(PerformerID) ON DELETE CASCADE ON UPDATE CASCADE
    );
    
INSERT INTO MUSICIAN (PerformerID)
VALUES
('2100'),
('1234');

DROP TABLE IF EXISTS INSTRUMENTS;
CREATE TABLE INSTRUMENTS (
	PerformerID				int not null,
    Instrument_name			varchar(50),
    PRIMARY KEY (PerformerID),
    foreign key (PerformerID) references Musician(PerformerID) ON DELETE CASCADE ON UPDATE CASCADE
    );

DROP TABLE IF EXISTS MEDICATIONS;
CREATE TABLE MEDICATIONS (
	PerformerID				int not null,
    Medication		varchar(50),
    PRIMARY KEY (PerformerID),
    foreign key (PerformerID) references performer(PerformerID) ON DELETE CASCADE ON UPDATE CASCADE
    );

INSERT INTO INSTRUMENTS (PerformerID, Instrument_name)
VALUES
('2100', 'Guitar'),
('1234', 'Piano');

DROP TABLE IF EXISTS AERIALIST;
CREATE TABLE AERIALIST (
	PerformerID 			int not null,
    Sport					varchar(50),
    Equipment				varchar(50),
    PRIMARY KEY (PerformerID),
    foreign key (PerformerID) references PERFORMER(PerformerID) ON DELETE CASCADE ON UPDATE CASCADE
    );
    
INSERT INTO AERIALIST (PerformerID, Sport, Equipment)
VALUES
('6666', 'Lyra Hoop', 'Metal Hoop'),
('9999', 'Aerial Bungee', 'Bungee Cord');

DROP TABLE IF EXISTS ENTERTAINER;
CREATE TABLE ENTERTAINER (
	PerformerID				int not null,
    MainAct					varchar(50),
    PRIMARY KEY (PerformerID),
    foreign key (PerformerID) references PERFORMER(PerformerID) ON DELETE CASCADE ON UPDATE CASCADE
    );
    
INSERT INTO ENTERTAINER (PerformerID, MainAct)
VALUES
('3535', 'Magician'),
('5678', 'Juggler');


# Triggers

# Updated Classification tables upon update of Performer
DELIMITER //
CREATE TRIGGER Update_Classification
AFTER UPDATE ON PERFORMER
FOR EACH ROW
BEGIN
    -- Check if Classification has changed
    IF NEW.Classification != OLD.Classification OR (NEW.Classification IS NOT NULL AND OLD.Classification IS NULL) OR (NEW.Classification IS NULL AND OLD.Classification IS NOT NULL) THEN
        IF New.Classification = 'aerialist' THEN
			INSERT INTO aerialist (PerformerID)
			VALUES (NEW.PerformerID);
        END IF;    
		IF New.Classification = 'musician' THEN
			INSERT INTO musician (PerformerID)
			VALUES (NEW.PerformerID);
		END IF;
        IF New.Classification = 'entertainer' THEN
			INSERT INTO entertainer(PerformerID)
			VALUES (NEW.PerformerID);
		END IF;   
		IF OLD.Classification = 'aerialist' THEN
			DELETE FROM aerialist 
			WHERE PerformerID = NEW.PerformerID;
		END IF;
		IF OLD.Classification = 'musician' THEN
			DELETE FROM musician
			WHERE PerformerID = NEW.PerformerID;
		END IF;
        IF OLD.Classification = 'entertainer' THEN
			DELETE FROM entertainer
			WHERE PerformerID = NEW.PerformerID;
		END IF;
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Insert_Classification
AFTER INSERT ON PERFORMER
FOR EACH ROW
BEGIN
    -- Check if Classification has changed
    IF NEW.Classification IS NOT NULL THEN
        IF New.Classification = 'aerialist' THEN
			INSERT INTO aerialist (PerformerID)
			VALUES (NEW.PerformerID);
        END IF;    
		IF New.Classification = 'musician' THEN
			INSERT INTO musician (PerformerID)
			VALUES (NEW.PerformerID);
		END IF;
        IF New.Classification = 'entertainer' THEN
			INSERT INTO entertainer(PerformerID)
			VALUES (NEW.PerformerID);
		END IF;   
    END IF;
END;
//
DELIMITER ;

    