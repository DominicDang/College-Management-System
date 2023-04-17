CREATE DATABASE College
GO


CREATE TABLE Department(
	Dept_ID char(2) NOT NULL,
	Dept_Name varchar(50) NOT NULL,
	Established_Year int,
	Ins_Manager_ID varchar(10),
	constraint PK_Department primary key(Dept_ID)
)

CREATE TABLE Major (
	Major_ID char(2) NOT NULL, 
	Major_name varchar(50) NOT NULL, 
	Dept_ID char(2) NOT NULL,
	constraint PK_Major primary key(Major_ID),
	constraint FK_Major foreign key(Dept_ID) references Department(Dept_ID)
)

CREATE TABLE Student (
	Student_ID char(11) NOT NULL,
	First_name varchar(20) NOT NULL,
	Last_name varchar(20) NOT NULL,
	Dob date, 
	Gender char(1), 
	Email varchar(30),
	Major_ID char(2) NOT NULL,
	constraint PK_Student primary key(Student_ID),
	constraint FK_Student foreign key(Major_ID) references Major(Major_ID)
)






CREATE TABLE Instructor(
	Ins_ID varchar(10) NOT NULL, 
	Ins_name varchar(20) NOT NULL, 
	Dob Date, 
	Dept_ID char(2) NOT NULL
	constraint PK_instructor PRIMARY KEY(Ins_ID)
	constraint FK_instructor FOREIGN KEY(Dept_ID) references Department(Dept_ID)
)

CREATE TABLE Instructor_Email(
	Ins_ID varchar(10) NOT NULL,
	Email varchar(30) NOT NULL,
	constraint PK_Instructor_Email primary key(Ins_ID,Email),
	constraint FK_Instructor_Email foreign key(Ins_ID) references Instructor(Ins_ID)
)

CREATE TABLE Course
(
Course_ID char(7) not null, 
Course_Name varchar(50) not null, 
Credits int not null, 
Room varchar(10) not null, 
Dept_ID char(2) not null,
constraint PK_Course Primary Key(Course_ID),
constraint FK_Course Foreign Key (Dept_ID) references Department(Dept_ID)
)

CREATE TABLE Enrollment(
	Student_ID char(11), 
	Course_ID char(7),  
	Enrollment_ID int,
	Term int,
	constraint PK_enrollment PRIMARY KEY (Student_ID, Course_ID, Enrollment_ID),
	constraint FK_enrollment_1 FOREIGN KEY (Course_ID) references Course(Course_ID),
	constraint FK_enrollment_2 FOREIGN KEY (Student_ID) references Student(Student_ID)	
)



CREATE TABLE Section
(
Section_ID int not null, 
Section_Types varchar(10) not null, 
Room varchar(10) not null, 
Course_ID char(7) not null, 
Ins_ID varchar(10) not null,
constraint PK_Section Primary Key(Section_ID),
constraint FK_Section1 Foreign Key (Course_ID) references Course(Course_ID),
constraint FK_Section2 Foreign Key (Ins_ID) references Instructor(Ins_ID)
)



/* INSERT DATA
Major Table */
INSERT INTO Major(Major_ID, Major_name, Dept_ID)
VALUES ('MA','Applied Mathematics','MA'),
		('AR', 'Aquatic Resource Management', 'BT'),
		('EN','Arts in English Linguistics and Literature','EN'),
		('BT','BioTechnology','BT'),
		('BA','Business Management','BA'),
		('CE','Civil Engineering','CE'),
		('CE','Computer Engineering','IT'),
		('CS','Computer Science','IT'),
		('CM','Construction Management','CE'),
		('AC','Control Engineering and Automation','EE'),
		('DS','Data Science','IT'),
		('EE','Electronic and Telecommunication','EE'),
		('FT','Food Technology','BT'),
		('HM','Hospitality Management','BA'),
		('IE','Industrial System and Engineering','IE'),
		('IB','International Business Management','BA'),
		('LS','Logistics and Supply Chain Management','IE'),
		('MK','Marketing','BA'),
		('NE','Network Engineering','IT'),
		('SE','Space Engineering','PH'
		)

/* Department Table */
INSERT INTO Department(Dept_ID, Dept_Name, Established_Year, Ins_Manager_ID)
VALUES ('BA','School of Business',2003, 'INS21'),
		('BT','School of Biotechnology',2017, 'INS6'),
		('CE','School of Civil Engineering and Management',2021, 'INS5'),
		('EN','School of Languages',2017, 'INS7'),
		('IE','School of Industrial Engineering and Management',2009, 'INS52'),
		('IT','School of Computer Science and Engineering',2004, 'INS1'),
		('MA','Department of Mathematics',2013, 'INS4'),
		('PH','Department of Physics',2016, 'INS17'),
		('EE','School of Electrical Engineering',2004, 'INS26')

INSERT INTO Course(Course_ID, Course_Name,Credits,Room, Dept_ID)
VALUES
('BA003IU','Principles of Marketing',3, 'A1.201','BA'),
('BA005IU','Financial Accounting',	3,'A2.203',	'BA'),
('BA006IU','Business Communication',2,'A2.202','BA'),
('BA016IU','Fundamental of Financial Management',2, 'A1.205','BA'),
('BA018IU','Quality Management',1, 'A2.207','BA'),
('BA020IU','Business Ethics',3,'A1.307','BA'),
('EE097IU','Thesis',1, 'A1.507', 'EE'),
('EE010IU', 'Electromagnetic Theory',1,	'A2.606','EE'),
('EE049IU', 'Introduction to EE',3,'A1.202','EE'),
('EE051IU', 'Principles of EE' , 2, 'A1.402','EE'),
('EL001IU', 'Reading 1 B2-C1',3, 'A2.210','EN'),
('EL005IU', 'Advanced Grammar',	2,'A1.505',	'EN'),
('EL006IU', 'Presentation Skills',	2, 'A2.602','EN'),
('EL019IU', 'British Civilization',	1,'A2.107',	'EN'),
('IS001IU', 'Introduction to Industrial Engineering',2,'A1.701','IE'),
('IS004IU', 'Engineering Probability & Statistics',	4,'A2.408',	'IE'),
('IS019IU', 'Production Management',3,'A1.405',	'IE'),
('IS020IU', 'Engineering Economy',1, 'A2.308',	'IE'),
('IS090IU', 'Engineering Mechanics  Dynamics',2,'A1.402',	'IE'),
('IT013IU','Algorithms & Data Structures',4, 'LA2.101','IT'),
('IT024IU','Computer Graphics',3,'LA1.505','IT'),
('IT056IU','IT Project Management',4, 'LA2.101','IT'),
('IT058IU','Thesis',2, 'A2.604','IT'),
('IT069IU', 'Object-Oriented Programming',4, 'A1.301','IT'),
('IT079IU', 'Principles of Database Management',4, 'A1.301','IT'),
('IT082IU', 'Internship',3, 'LA1.505', 'IT'),
('MA001IU', 'Calculus 1',	4, 'A2.102',	'MA'),
('MA003IU', 'Calculus 2',	4,'A2.404',	'MA'),
('MA023IU', 'Calculus 3',	2,'A2.608',	'MA'),
('MA024IU', 'Differential Equations',4,	'A1.407','MA'),
('PH012IU', 'Physics 4 (Optics & Atomics)',	2, 'LA2.403','PH'),
('PH016IU', 'Physics 3 Lab',1, 'A1.408',	'PH'),
('PH025IU', 'Math for Engineers',	4, 'A2.108','PH'),
('PH028IU', 'Circuit theory',	2,'A1.405',	'PH'),
('BT155IU', 'General Biology',	4,'LA2.103','BT'),
('CH101IU', 'General Chemistry',	4,'A1.608',	'BT'),
('CH009IU', 'Organic chemistry',3,'A2.307',	'BT'),
('BT210IU', 'Human physiology',3,'A2.206',	'BT'),
('BT164IU', 'Microbiology',2,'A1.308', 'BT'),
('BT207IU', 'Human Pharmacology',3,'A2.107','BT')

/* Instructor_Email Table */
INSERT INTO Instructor_Email(Ins_ID,Email)
VALUES
('INS1',  'patrickgarcia@example.com'),
('INS4',  'catherineobrien@example.com'),	
('INS5',  'danaadkins@example.com'),
('INS6',  'dianamunoz@example.org'),
('INS7',  'robert28@example.net'),
('INS9',  'qerickson@example.org'),
('INS10', 'james39@example.net'),
('INS17', 'qhendricks@example.org'),
('INS21', 'michael66@example.org'),
('INS22', 'williamsonbrandi@example.com'),
('INS24', 'mli@example.com'),
('INS25', 'deleonthomas@example.net'),
('INS26', 'jgarcia@example.net'),
('INS28', 'traciewalters@example.org'),
('INS29', 'williamsaustin@example.org'),
('INS52', 'klane@example.net'),
('INS32', 'cwalker@example.com'),
('INS35', 'scott26@example.com'),
('INS37', 'anne29@example.net'),
('INS40', 'njohnson@example.org'),
('INS44', 'lisawilliams@example.com'),
('INS46', 'wpowell@example.net'),
('INS48', 'edawson@example.net'),
('INS54', 'crystalmorton@example.com'),
('INS58', 'michael55@example.com'),
('INS61', 'kristin81@example.net'),
('INS67', 'chad86@example.com'),
('INS68', 'kellerjason@example.net'),
('INS80', 'richardsonemily@example.net'),
('INS83', 'jenniferprice@example.org')







			
			
			
			
			
			
			
			
			
			
			





