CREATE TABLE [User]
(
	Username		CHAR(10)		NOT NULL, 
    Fname			varchar(20),
	Lname			varchar(20),
	pass			CHAR(7),
	Email			varchar(50),
    Sex      		CHAR(1),
	Birth_date      CHAR(8)
 PRIMARY  KEY (Username)
);

CREATE TABLE Employee
(
	employee_id		CHAR(10)		NOT NULL, 
    salary			DECIMAL(5),
	Username		CHAR(10)		NOT NULL, 
 PRIMARY  KEY (employee_id),
 foreign key (Username) references [User](Username)
);

CREATE TABLE [Admin]
(
	admin_id		CHAR(10)		NOT NULL, 
	Username		CHAR(10)		NOT NULL, 
 PRIMARY  KEY (admin_id),
 foreign key (Username) references [User](Username)
);

CREATE TABLE Educational_Assistant
(
	assistant_id		CHAR(10)		NOT NULL, 
	Username			CHAR(10)		NOT NULL, 
	admin_id			CHAR(10)		NOT NULL,
 PRIMARY  KEY (assistant_id),
 foreign key (Username) references [User](Username),
 foreign key (Admin_id) references [Admin](admin_id)
);

CREATE TABLE Professor
(
	professor_id	CHAR(10)		NOT NULL, 
    Dept			varchar(20),
	Username		CHAR(10)		NOT NULL,  
	assistant_id	CHAR(10)		NOT NULL, 
 PRIMARY  KEY (professor_id),
 foreign key (Username) references [User](Username),
 foreign key (assistant_id) references Educational_Assistant(assistant_id)
);

CREATE TABLE student
(
	student_id		CHAR(10)		NOT NULL, 
    Dept			varchar(20),
	Username		CHAR(10)		NOT NULL, 
	assistant_id	CHAR(10)		NOT NULL, 
 PRIMARY  KEY (student_id),
 foreign key (Username) references [User](Username),
 foreign key (assistant_id) references Educational_Assistant(assistant_id)
);

CREATE TABLE TA
(
	TA_id			CHAR(10)		NOT NULL,
	employee_id		CHAR(10)		NOT NULL, 
	professor_id	CHAR(10)		NOT NULL,
	assistant_id	CHAR(10)		NOT NULL, 
 PRIMARY  KEY (TA_id),
 foreign key (employee_id) references Employee(employee_id),
 foreign key (student_id) references student(student_id),
 foreign key (professor_id) references Professor(professor_id),
 foreign key (assistant_id) references Educational_Assistant(assistant_id)
);

CREATE TABLE Personal_Files
(
	Personal_files_id		CHAR(10)		NOT NULL, 
    Title					varchar(20),
	[Date]					int,
	[time]					int,
	Link					varchar(40),
	[Description]			varchar(50),
	[File]					varbinary(25), 
	--ذخیره 1تا 800 بایت
	Username				CHAR(10),
 PRIMARY  KEY (Personal_files_id),
 foreign key (Username) references [User](Username),
);

CREATE TABLE [Messages]
(
	messages_id				CHAR(10)		NOT NULL, 
	Link					varchar(40),
	[Description]			varchar(50),
	[File]					varbinary(25), 
	Sender					varbinary(25),
	[Date]					int,
	[Time]					int,
	Username				CHAR(10),
 PRIMARY  KEY (messages_id),
 foreign key (Username) references [User](Username),
);

CREATE TABLE Calendar
(
	calendar_id				CHAR(10)		NOT NULL, 
    Calender_name			varchar(20),
	[Date]					int,
	[Event]					varchar(50),
	[Description]			varchar(50),
	Username				CHAR(10),
 PRIMARY  KEY (calendar_id),
 foreign key (Username) references [User](Username),
);

CREATE TABLE Lessons
(	
	Lesson_code				CHAR(10)			NOT NULL, 
    [Name]					varchar(20),
	Dept					varchar(20),
	Term					int,
	professor_id			CHAR(10)			NOT NULL,
	assistant_id			CHAR(10)			NOT NULL, 
  PRIMARY  KEY (Lesson_code),
  foreign key (Professor_id) references Professor(Professor_id),
  foreign key (assistant_id) references Educational_Assistant(assistant_id)
 );

 CREATE TABLE student_has_Lesson
(	
	Lesson_code				CHAR(10)			NOT NULL,
   	student_id				CHAR(10)			NOT NULL, 
 PRIMARY  KEY (Lesson_code , student_id)
);

 CREATE TABLE ta_has_Lesson
(	
	Lesson_code				CHAR(10)			NOT NULL,
    TA_id					CHAR(10)			NOT NULL, 
 PRIMARY  KEY (Lesson_code , TA_id)
);

CREATE TABLE Notifications
(	
	Notifications_id		CHAR(10)			NOT NULL, 
    Title					varchar(20),	
	[Date]					int,
	[Time]					int,
	Link					varchar(40),
	[Description]			varchar(50),
	[File]					varbinary(25), 
	professor_id			CHAR(10)			NOT NULL,
	TA_id					CHAR(10)			NOT NULL, 
	Lesson_code				CHAR(10)			NOT NULL, 
 PRIMARY  KEY (Notifications_id),
 foreign key (Professor_id) references Professor(Professor_id),
 foreign key (TA_id) references TA(TA_id),
 foreign key (Lesson_code) references Lessons(Lesson_code),
);

CREATE TABLE student_see_notifications
(	
	Notifications_id		CHAR(10)			NOT NULL, 
   	student_id				CHAR(10)			NOT NULL, 
 PRIMARY  KEY (Notifications_id , student_id)
);

CREATE TABLE Offline_class
(	
	[file_id]				CHAR(10)			NOT NULL, 
	Link					varchar(40),
	[Description]			varchar(50),
    Title					varchar(20),	
	[File]					varbinary(25), 
    Upload_date				int,
	Upload_time				int,
	professor_id			CHAR(10)			NOT NULL,
	Lesson_code				CHAR(10)			NOT NULL, 
 PRIMARY  KEY ([file_id]),
 foreign key (Professor_id) references Professor(Professor_id),
 foreign key (Lesson_code) references Lessons(Lesson_code),
);

CREATE TABLE Download
(	
	[file_id]				CHAR(10)			NOT NULL, 
   	student_id				CHAR(10)			NOT NULL, 
 PRIMARY  KEY ([file_id] , student_id)
);

CREATE TABLE ta_manages_files
(	
	[file_id]				CHAR(10)			NOT NULL, 
   	TA_id					CHAR(10)			NOT NULL, 
 PRIMARY  KEY ([file_id] , TA_id)
);

CREATE TABLE Exercise
(	
	exercise_id				CHAR(10)			NOT NULL, 
	Title					varchar(20),
	Delivery_date			int,
	Link					varchar(40),
	[Description]			varchar(50),
	[File]					varbinary(25), 
    Upload_date				int,
	Upload_time				int,
	score					int,
	professor_id			CHAR(10)			NOT NULL,
	student_id				CHAR(10)			NOT NULL, 
	Lesson_code				CHAR(10)			NOT NULL, 
 PRIMARY  KEY (exercise_id),
 foreign key (Professor_id) references Professor(Professor_id),
 foreign key (student_id) references student(student_id),
 foreign key (Lesson_code) references Lessons(Lesson_code),
);

CREATE TABLE ta_manages_exercises
(	
	exercise_id				CHAR(10)			NOT NULL, 
   	TA_id					CHAR(10)			NOT NULL, 
 PRIMARY  KEY (exercise_id , TA_id)
);

CREATE TABLE Exams
(	
	exams_id				CHAR(10)			NOT NULL,
	score					int,
	Link					varchar(40),
	[Description]			varchar(50),
	[File]					varbinary(25), 
	Title					varchar(20),
	[Time]					int,
	Start_time				int,
	Close_time				int,
	N_alloweded_tries		int,
	professor_id			CHAR(10)			NOT NULL,
	TA_id					CHAR(10)			NOT NULL, 
	student_id				CHAR(10)			NOT NULL, 
	Lesson_code				CHAR(10)			NOT NULL, 
 PRIMARY  KEY (exams_id),
 foreign key (Professor_id) references Professor(Professor_id),
 foreign key (TA_id) references TA(TA_id),
 foreign key (student_id) references student(student_id),
 foreign key (Lesson_code) references Lessons(Lesson_code),
);

CREATE TABLE Online_class
(	
	class_id				CHAR(10)			NOT NULL,
	[Description]			varchar(50),
	Link					varchar(40),
	[File]					varbinary(25), 
	[Time]					int,
	[Date]					int,
	Title					varchar(20),
	professor_id			CHAR(10)			NOT NULL,
	TA_id					CHAR(10)			NOT NULL, 
	Lesson_code				CHAR(10)			NOT NULL, 
 PRIMARY  KEY (class_id),
 foreign key (Professor_id) references Professor(Professor_id),
 foreign key (TA_id) references TA(TA_id),
 foreign key (Lesson_code) references Lessons(Lesson_code),
);

CREATE TABLE Participation
(	
	class_id				CHAR(10)			NOT NULL, 
   	student_id				CHAR(10)			NOT NULL, 
 PRIMARY  KEY (class_id , student_id)
);

