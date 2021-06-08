/* SQL_School_Database
The International Language School is a language training school.
It offers language classes for corporate clients,
which can be conducted at the School or at the offices of the client as they prefer.
The School employs teachers, each of whom may teach multiple courses.
The school has clients, each of whom may offer multiple courses via the school.
Clients offer courses to their employees, who have the option to participate.
Each course is offered by one client. Each course has one teacher at any given time.
Participants in the courses are employees of the client companies, i.e. 
they work for the client companies. Each participant can be employed by one company at a time.
Participants may be enrolled in more than one course. */ 

/* Create the database */ 

CREATE DATABASE school 

USE school

/* Create tables */ 

CREATE TABLE teacher (
  teacher_id INT PRIMARY KEY,
  first_name VARCHAR(40) NOT NULL,
  last_name VARCHAR(40) NOT NULL,
  language_1 VARCHAR(3) NOT NULL,
  language_2 VARCHAR(3),
  dob DATE,
  tax_id INT UNIQUE,
  phone_no VARCHAR(20)
  );

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40) NOT NULL,
  address VARCHAR(60) NOT NULL,
  industry VARCHAR(20)
);

CREATE TABLE participant (
  participant_id INT PRIMARY KEY,
  first_name VARCHAR(40) NOT NULL,
  last_name VARCHAR(40) NOT NULL,
  phone_no VARCHAR(20),
  client INT
);

CREATE TABLE course (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(40) NOT NULL,
  language VARCHAR(3) NOT NULL,
  level VARCHAR(2),
  course_length_weeks INT,
  start_date DATE,
  in_school varchar(20),
  teacher INT,
  client INT
);

CREATE TABLE takes_course(participant_id INT, course_id INT, PRIMARY KEY(participant_id, course_id), FOREIGN KEY(participant_id) REFERENCES participant(participant_id) ON DELETE CASCADE, 
FOREIGN KEY(course_id) REFERENCES course(course_id) ON DELETE CASCADE); 



/* Altering tables to add FK, PK */ 

ALTER TABLE Participant 
ADD FOREIGN KEY(Client)
REFERENCES Client(client_id)
ON DELETE SET NULL; 

ALTER TABLE Course 
ADD FOREIGN KEY(Teacher)
REFERENCES Teacher(teacher_id)
ON DELETE SET NULL; 

ALTER TABLE Course
ADD FOREIGN KEY(Client)
REFERENCES Client(client_id)
ON DELETE SET NULL; 

ALTER TABLE Teacher 
ADD dob varchar(20); 

/* In case we need to delete Tables 

DROP TABLE Client; 
DROP TABLE Course; 
DROP TABLE Participant; 
DROP TABLE takes_course; 
DROP TABLE Teacher; */ 


/* Inserting or populating the table */ 

INSERT INTO teacher VALUES
(1,  'James', 'Smith', 'ENG', NULL, '1985-04-20', 12345, '+491774553676'),
(2, 'Stefanie',  'Martin',  'FRA', NULL,  '1970-02-17', 23456, '+491234567890'), 
(3, 'Steve', 'Wang',  'MAN', 'ENG', '1990-11-12', 34567, '+447840921333'),
(4, 'Friederike',  'Müller-Rossi', 'DEU', 'ITA', '1987-07-07',  45678, '+492345678901'),
(5, 'Isobel', 'Ivanova', 'RUS', 'ENG', '1963-05-30',  56789, '+491772635467'),
(6, 'Niamh', 'Murphy', 'ENG', 'IRI', '1995-09-08',  67890, '+491231231232');


INSERT INTO client VALUES
(101, 'Big Business Federation', '123 Falschungstraße, 10999 Berlin', 'NGO'),
(102, 'eCommerce GmbH', '27 Ersatz Allee, 10317 Berlin', 'Retail'),
(103, 'AutoMaker AG',  '20 Künstlichstraße, 10023 Berlin', 'Auto'),
(104, 'Banko Bank',  '12 Betrugstraße, 12345 Berlin', 'Banking'),
(105, 'WeMoveIt GmbH', '138 Arglistweg, 10065 Berlin', 'Logistics');


INSERT INTO participant VALUES
(101, 'Marina', 'Berg','491635558182', 101),
(102, 'Andrea', 'Duerr', '49159555740', 101),
(103, 'Philipp', 'Probst',  '49155555692', 102),
(104, 'René',  'Brandt',  '4916355546',  102),
(105, 'Susanne', 'Shuster', '49155555779', 102),
(106, 'Christian', 'Schreiner', '49162555375', 101),
(107, 'Harry', 'Kim', '49177555633', 101),
(108, 'Jan', 'Nowak', '49151555824', 101),
(109, 'Pablo', 'Garcia',  '49162555176', 101),
(110, 'Melanie', 'Dreschler', '49151555527', 103),
(111, 'Dieter', 'Durr',  '49178555311', 103),
(112, 'Max', 'Mustermann', '49152555195', 104),
(113, 'Maxine', 'Mustermann', '49177555355', 104),
(114, 'Heiko', 'Fleischer', '49155555581', 105);


INSERT INTO course VALUES
(12, 'English for Logistics', 'ENG', 'A1', 10, '2020-02-01', 'TRUE',  1, 105),
(13, 'Beginner English', 'ENG', 'A2', 40, '2019-11-12',  'FALSE', 6, 101),
(14, 'Intermediate English', 'ENG', 'B2', 40, '2019-11-12', 'FALSE', 6, 101),
(15, 'Advanced English', 'ENG', 'C1', 40, '2019-11-12', 'FALSE', 6, 101),
(16, 'Mandarin für Autoindustrie', 'MAN', 'B1', 15, '2020-01-15', 'TRUE', 3, 103),
(17, 'Français intermédiaire', 'FRA', 'B1',  18, '2020-04-03','FALSE', 2, 101),
(18, 'Deutsch für Anfänger', 'DEU', 'A2', 8, '2020-02-14', 'TRUE', 4, 102),
(19, 'Intermediate English', 'ENG', 'B2', 10, '2020-03-29', 'FALSE', 1, 104),
(20, 'Fortgeschrittenes Russisch', 'RUS', 'C1',  4, '2020-04-08',  'FALSE' , 5, 103);


INSERT INTO takes_course VALUES
(101, 15),
(101, 17),
(102, 17),
(103, 18),
(104, 18),
(105, 18),
(106, 13),
(107, 13),
(108, 13),
(109, 14),
(109, 15),
(110, 16),
(110, 20),
(111, 16),
(114, 12),
(112, 19),
(113, 19);



/* creating some queries */ 

-- Selecting all the details from the teacher's table ---

SELECT * FROM  teacher 

-- get the last name and the birthdays of all the teachers --

SELECT last_name, dob from teacher; 

-- find all courses in English --

SELECT * FROM course WHERE language = 'ENG' ;

-- find all English courses at B2 level --

SELECT * FROM course WHERE language = 'ENG' and level = 'B2'; 

-- find all course where the languges is not English and level is not C1 -- 
SELECT * FROM course WHERE language != 'ENG' and level != 'C1' 

SELECT * FROM course WHERE NOT language = 'ENG' and NOT level = 'C1' 

-- Get the names and phone numbers of all teachers born before 1990 --

SELECT first_name, last_name, phone_no FROM teacher WHERE dob < '1990-01-01' 

-- find all courses which start in January --

SELECT * FROM course WHERE start_date LIKE '%_____01___%'

-- find some intermediate course --

SELECT * FROM course WHERE course_name LIKE '%Intermediate%'

-- find participants whose last name Garcia, Nowak or Mustermann --

SELECT * FROM participant WHERE last_name IN ('Garcia', 'Nowak', 'Mustermann') 

-- Identify teachers who only teach one or two languages --

SELECT * FROM teacher WHERE language_2 IS NULL 

SELECT * FROM teacher WHERE language_2 IS NOT NULL 

-- find the average length of a course --

SELECT * FROM course 
SELECT AVG(course_length_weeks) AS AVG_course FROM course 

-- find the average length of a course group by client 

SELECT client, AVG(course_length_weeks) AS AVG_course FROM course GROUP BY client 

-- count the number of courses -- 

SELECT COUNT(*) AS count FROM course 

-- how many courses does the school offer in each language?--

SELECT language, count(*) AS count FROM course GROUP BY language  

-- find all the teachers whose birthdate is above the average teacher's birthdate --

SELECT * 
FROM teacher
WHERE dob > 
(SELECT AVG(dob) FROM teacher )

-- Get the course details for all courses which take place at the client's offices. 

SELECT * FROM course 
SELECT * FROM client 
SELECT * FROM teacher 

SELECT * FROM course 
INNER JOIN client 
ON course.client = client.client_id 
WHERE in_school = 'FALSE';

-- Get the course details for all courses which take place at the client's offices, which are taught
-- by Stefanie Martin (as above, but with added details).

SELECT * FROM course 
INNER JOIN client 
ON course.client = client.client_id 
INNER JOIN teacher 
ON course.teacher = teacher.teacher_id 
WHERE course.in_school = 'FALSE' and course.teacher = 2 


-- Get all particpants in classes taught by Niamh Murphy

SELECT * FROM teacher 
select * from course
SELECT * FROM participant 
SELECT participant.first_name, participant.last_name
FROM participant
JOIN takes_course ON takes_course.participant_id = participant.participant_id 
JOIN course ON takes_course.course_id = course.course_id
WHERE takes_course.course_id = 
    (SELECT takes_course.course_id 
    WHERE course.teacher = 6);


