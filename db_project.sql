use finalyearproject
create table department(D_Id varchar(10) not null,D_name varchar(20),D_floor varchar(10),D_Inaguration_date date,D_No_Of_Employees int,primary key(D_Id))
insert into department values('d001','cs','1st floor','2022-02-02',120)
create table employee(e_id varchar(10) not null,e_name varchar(20),e_adress varchar(30),e_gender char(1)  check(e_gender='m' or e_gender='M' or e_gender='f' or e_gender='F'),e_salary int check (e_salary>10000),e_phone char(11),e_mail varchar(30),e_postcode varchar(20),e_dept varchar(10) not null,e_position varchar(10),primary key(e_id),foreign key(e_dept) references department(D_Id)on delete cascade on update cascade)
create table hods(h_id varchar(10) not null,h_name varchar(20),h_adress varchar(30),h_gender char(1)check(h_gender='m' or h_gender='M' or h_gender='f' or h_gender='F'),h_salary int,h_phone char(11),h_email varchar(30),h_postcode varchar(20),h_dept varchar(10) unique,primary key(h_id), foreign key(h_dept) references department(D_Id)on delete cascade on update cascade)
create table internies(i_id varchar(10) not null,i_name varchar(20),i_adress varchar(30),i_gender char(1) check(i_gender='m' or i_gender='M' or i_gender='f' or i_gender='F'),i_salary int,i_phone char(11),i_email varchar(30),i_postcode varchar(20),i_dept varchar(10) not null,i_workhour int,primary key(i_id),foreign key(i_dept) references department(D_Id)on delete cascade on update cascade)
create table ProjectDetail(p_id varchar(10), c_id varchar(10),no_of_employee_work int,foreign key (p_id) references project(p_id)on delete cascade on update cascade,foreign key(c_id) references customers(c_id)on delete cascade on update cascade)
create table project(p_id varchar(10) not null,p_name varchar(30),p_assignDate date,p_submitDate date,p_cost int,p_discount int,p_lateDateCost int,p_description varchar(40),primary key(p_id))
create table customers(c_id varchar(10),c_name varchar(21),c_adress varchar(30),c_assigndate date,c_age int,c_phone char(10),c_email varchar(30),c_postcode varchar(20),c_project varchar(10),c_description varchar(40),primary key(c_id),foreign key(c_project) references project(p_id)on delete cascade on update cascade)
create table staff (s_id varchar(10) not null,s_name varchar(20),s_adress varchar(30),s_gender char(1)check(s_gender='m' or s_gender='M' or s_gender='f' or s_gender='F'),s_salary int,s_phone char(10),s_email varchar(30),s_postcode varchar(20),s_dept varchar(10) not null,s_date date,primary key(s_id),foreign key(s_dept) references department(D_Id)on delete cascade on update cascade)
select *from staff
drop table employee
drop table customers
drop table department
drop table hods
drop table internies

drop table project 
drop table project_group
drop table staff
drop table auditData
drop table auditprojectreport
create table auditData(id char(4) not null, Name varchar(20),AuditDate date)

<--trigger to keep a report when insert employees data 
drop trigger TRinsertEmployee
DELIMITER $$
CREATE TRIGGER TRinsertEmployee
AFTER INSERT
ON employee FOR EACH ROW 
BEGIN
insert into auditData(id,Name,AuditDate) values(NEW.e_id,NEW.e_name,CURRENT_DATE);
end $$
DELIMITER ; 
SELECT *FROM auditData

create table auditProjectReport(id char(4) not null,pname varchar(30),AuditDate date,AuditTime time)
<-- create a trigger on project table after the data is modified and produce a report of the project id and project name and date on which is modified-->
DELIMITER $$
CREATE TRIGGER trUpdateProject
AFTER UPDATE
ON employee FOR EACH ROW 
BEGIN
insert into auditProjectReport(id,pname,AuditDate,AuditTime) values(NEW.e_id,NEW.e_name,CURRENT_DATE,CURRENT_TIME);
end $$
DELIMITER ; 
select *from auditprojectreport;
update project set p_name='network system' where p_id='p003';
SELECT *FROM auditProjectReport;

drop trigger trUpdateEmployee
DELIMITER $$
CREATE PROCEDURE empGender(in sex char(1)
)

BEGIN
select *from employee where sex=e_gender;
END$$
CALL empGender('F');
DROP procedure empManager
use finalyearproject
DELIMITER $$
CREATE PROCEDURE projectFloor()
BEGIN
select *from department where D_floor='1st floor';
END$$

drop procedure spempManager



DELIMITER $$
CREATE PROCEDURE empSalary(in salary int
)

BEGIN
select *from employee where salary<e_salary;
END$$
CALL empSalary(12000);
DELIMITER $$
CREATE PROCEDURE empSalaryAverage()

BEGIN
select avg(e_salary) as avgSalary from employee;
END$$
CALL empSalaryAverage();

DELIMITER $$
create PROCEDURE empadress()
BEGIN
select *from employee where e_adress like '%chu%';
END$$
CALL empadress();

drop procedure empadress
create view ProjectCustomers





