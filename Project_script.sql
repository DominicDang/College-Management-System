USE [College]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Student_ID] [char](11) NOT NULL,
	[First_name] [varchar](20) NOT NULL,
	[Last_name] [varchar](20) NOT NULL,
	[Dob] [date] NULL,
	[Gender] [char](1) NULL,
	[Email] [varchar](30) NULL,
	[Major_ID] [char](2) NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[Course_ID] [char](7) NOT NULL,
	[Course_Name] [varchar](50) NOT NULL,
	[Credits] [int] NOT NULL,
	[Dept_ID] [char](2) NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrollment]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollment](
	[Student_ID] [char](11) NOT NULL,
	[Course_ID] [char](7) NOT NULL,
	[Enrollment_ID] [int] NOT NULL,
	[Term] [int] NOT NULL,
	[Registration_Date] [date] NOT NULL,
 CONSTRAINT [PK_enrollment] PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC,
	[Course_ID] ASC,
	[Enrollment_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[The_Most_Registered_Course]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[The_Most_Registered_Course] 
AS 
select *
from Course 
where Course_ID in	(select E1.Course_ID
					from Enrollment E1
					where not exists	(select Student_ID 
										from Student
										except 
										select Student_ID
										from Enrollment E2
										where E1.Course_ID = E2.Course_ID))
GO
/****** Object:  Table [dbo].[Section]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Section](
	[Section_ID] [int] NOT NULL,
	[Section_Types] [varchar](10) NOT NULL,
	[Room] [varchar](10) NOT NULL,
	[Course_ID] [char](7) NOT NULL,
	[Ins_ID] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Section] PRIMARY KEY CLUSTERED 
(
	[Section_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[The_Course_Have_Both_Of_Lab_and_Theory]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[The_Course_Have_Both_Of_Lab_and_Theory]
as (
select *
from Course 
where Course_ID in	(select Course_ID
					from Section 
					Group By Course_ID
					Having Count(Section_Types) >= ALL(select Count(Section_Types)
													from Section 
													Group By Course_ID)))
GO
/****** Object:  Table [dbo].[Department]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Dept_ID] [char](2) NOT NULL,
	[Dept_Name] [varchar](50) NOT NULL,
	[Established_Year] [int] NULL,
	[Ins_Manager_ID] [varchar](10) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Dept_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[Ins_ID] [varchar](10) NOT NULL,
	[Ins_name] [varchar](20) NOT NULL,
	[Dob] [date] NULL,
	[Dept_ID] [char](2) NOT NULL,
 CONSTRAINT [PK_instructor] PRIMARY KEY CLUSTERED 
(
	[Ins_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Header_Of_Department]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[Header_Of_Department] 
as 
select Department.Ins_Manager_ID, Instructor.Ins_name,Department.Dept_Name
from Department
	join Instructor on Department.Ins_Manager_ID = Instructor.Ins_ID
GO
/****** Object:  View [dbo].[All_Students_Have_The_Smallest_Age_In_Each_Course]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[All_Students_Have_The_Smallest_Age_In_Each_Course]
AS
select Student.Student_ID, Student.First_name + ' ' + Student.Last_name 'Full_Name', 
Year(CURRENT_TIMESTAMP) - Year(Student.Dob) 'Age', Course.Course_ID, Course.Course_Name,
Course.Credits, Course.Dept_ID
from Student 
		join Enrollment on Student.Student_ID = Enrollment.Student_ID
		join Course on Course.Course_ID = Enrollment.Course_ID
where Student.Student_ID in (
select Student.Student_ID 
from  Student 
where Year(Student.Dob) >= All	
							(select Year(Student.Dob)
							from Student)
)
GO
/****** Object:  Table [dbo].[Condition]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Condition](
	[Prerequisite_Course_ID] [char](7) NOT NULL,
	[Course_ID] [char](7) NOT NULL,
 CONSTRAINT [PK_Condition] PRIMARY KEY CLUSTERED 
(
	[Prerequisite_Course_ID] ASC,
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor_Email]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor_Email](
	[Ins_ID] [varchar](10) NOT NULL,
	[Email] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Instructor_Email] PRIMARY KEY CLUSTERED 
(
	[Ins_ID] ASC,
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Major]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Major](
	[Major_ID] [char](2) NOT NULL,
	[Major_name] [varchar](50) NOT NULL,
	[Dept_ID] [char](2) NOT NULL,
 CONSTRAINT [PK_Major] PRIMARY KEY CLUSTERED 
(
	[Major_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Relative]    Script Date: 5/3/2023 10:38:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Relative](
	[Student_ID] [char](11) NOT NULL,
	[Relative_name] [varchar](20) NOT NULL,
	[Relative_phone] [bigint] NULL,
	[Gender] [char](1) NULL,
 CONSTRAINT [PK_Dependent] PRIMARY KEY CLUSTERED 
(
	[Relative_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Condition]  WITH CHECK ADD  CONSTRAINT [FK_Condition_1] FOREIGN KEY([Prerequisite_Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
GO
ALTER TABLE [dbo].[Condition] CHECK CONSTRAINT [FK_Condition_1]
GO
ALTER TABLE [dbo].[Condition]  WITH CHECK ADD  CONSTRAINT [FK_Condition_2] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
GO
ALTER TABLE [dbo].[Condition] CHECK CONSTRAINT [FK_Condition_2]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course] FOREIGN KEY([Dept_ID])
REFERENCES [dbo].[Department] ([Dept_ID])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department] FOREIGN KEY([Ins_Manager_ID])
REFERENCES [dbo].[Instructor] ([Ins_ID])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_enrollment_1] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_enrollment_1]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_enrollment_2] FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_enrollment_2]
GO
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD  CONSTRAINT [FK_instructor] FOREIGN KEY([Dept_ID])
REFERENCES [dbo].[Department] ([Dept_ID])
GO
ALTER TABLE [dbo].[Instructor] CHECK CONSTRAINT [FK_instructor]
GO
ALTER TABLE [dbo].[Instructor_Email]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Email] FOREIGN KEY([Ins_ID])
REFERENCES [dbo].[Instructor] ([Ins_ID])
GO
ALTER TABLE [dbo].[Instructor_Email] CHECK CONSTRAINT [FK_Instructor_Email]
GO
ALTER TABLE [dbo].[Major]  WITH CHECK ADD  CONSTRAINT [FK_Major] FOREIGN KEY([Dept_ID])
REFERENCES [dbo].[Department] ([Dept_ID])
GO
ALTER TABLE [dbo].[Major] CHECK CONSTRAINT [FK_Major]
GO
ALTER TABLE [dbo].[Relative]  WITH CHECK ADD  CONSTRAINT [FK_Dependent] FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Relative] CHECK CONSTRAINT [FK_Dependent]
GO
ALTER TABLE [dbo].[Section]  WITH CHECK ADD  CONSTRAINT [FK_Section1] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
GO
ALTER TABLE [dbo].[Section] CHECK CONSTRAINT [FK_Section1]
GO
ALTER TABLE [dbo].[Section]  WITH CHECK ADD  CONSTRAINT [FK_Section2] FOREIGN KEY([Ins_ID])
REFERENCES [dbo].[Instructor] ([Ins_ID])
GO
ALTER TABLE [dbo].[Section] CHECK CONSTRAINT [FK_Section2]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student] FOREIGN KEY([Major_ID])
REFERENCES [dbo].[Major] ([Major_ID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student]
GO
