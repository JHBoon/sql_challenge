-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/Uq4Pon
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


SET XACT_ABORT ON

BEGIN TRANSACTION QUICKDBD

CREATE TABLE [departments] (
    [dept_no] VARCHAR  NOT NULL ,
    [dept_name] VARCHAR  NOT NULL ,
    [d001] marketing  NOT NULL ,
    [d002] Finance  NOT NULL ,
    [d003] Human Resources  NOT NULL ,
    [d004] Production  NOT NULL ,
    [d005] Development  NOT NULL ,
    [d006] Quality Management  NOT NULL ,
    [d007] Sales  NOT NULL ,
    [d008] Research  NOT NULL ,
    [d009] Customer Service  NOT NULL ,
    CONSTRAINT [PK_departments] PRIMARY KEY CLUSTERED (
        [dept_no] ASC
    )
)

CREATE TABLE [dept_emp] (
    [emp_no] int  NOT NULL ,
    [dept_no] VARCHAR  NOT NULL ,
    CONSTRAINT [PK_dept_emp] PRIMARY KEY CLUSTERED (
        [emp_no] ASC
    )
)

CREATE TABLE [dept_manager] (
    [dept_no] VARCHAR  NOT NULL ,
    [emp_no] INT  NOT NULL ,
    CONSTRAINT [PK_dept_manager] PRIMARY KEY CLUSTERED (
        [emp_no] ASC
    )
)

CREATE TABLE [employees] (
    [emp_no] int  NOT NULL ,
    [emp_title_id] VARCHAR  NOT NULL ,
    [birth_date] DATE  NOT NULL ,
    [first_name] VARCHAR  NOT NULL ,
    [last_name] VARCHAR  NOT NULL ,
    [sex] VARCHAR  NOT NULL ,
    [hire_date] DATE  NOT NULL ,
    CONSTRAINT [PK_employees] PRIMARY KEY CLUSTERED (
        [emp_no] ASC
    )
)

CREATE TABLE [salaries] (
    [emp_no] int  NOT NULL ,
    [salary] int  NOT NULL ,
    CONSTRAINT [PK_salaries] PRIMARY KEY CLUSTERED (
        [emp_no] ASC
    )
)

CREATE TABLE [titles] (
    [title_id] VARCHAR  NOT NULL ,
    [title] VARCHAR  NOT NULL 
)

ALTER TABLE [departments] WITH CHECK ADD CONSTRAINT [FK_departments_dept_no] FOREIGN KEY([dept_no])
REFERENCES [dept_manager] ([dept_no])

ALTER TABLE [departments] CHECK CONSTRAINT [FK_departments_dept_no]

ALTER TABLE [dept_manager] WITH CHECK ADD CONSTRAINT [FK_dept_manager_emp_no] FOREIGN KEY([emp_no])
REFERENCES [dept_emp] ([emp_no])

ALTER TABLE [dept_manager] CHECK CONSTRAINT [FK_dept_manager_emp_no]

ALTER TABLE [employees] WITH CHECK ADD CONSTRAINT [FK_employees_emp_no] FOREIGN KEY([emp_no])
REFERENCES [dept_manager] ([emp_no])

ALTER TABLE [employees] CHECK CONSTRAINT [FK_employees_emp_no]

ALTER TABLE [employees] WITH CHECK ADD CONSTRAINT [FK_employees_emp_title_id] FOREIGN KEY([emp_title_id])
REFERENCES [titles] ([title])

ALTER TABLE [employees] CHECK CONSTRAINT [FK_employees_emp_title_id]

ALTER TABLE [salaries] WITH CHECK ADD CONSTRAINT [FK_salaries_emp_no] FOREIGN KEY([emp_no])
REFERENCES [employees] ([emp_no])

ALTER TABLE [salaries] CHECK CONSTRAINT [FK_salaries_emp_no]

COMMIT TRANSACTION QUICKDBD