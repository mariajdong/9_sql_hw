--create tables, import accordingly

--employee title ID/job title
create table titles (
	title_id varchar primary key,
	title varchar
);

--dept #/dept title
create table depts (
	dept_num varchar primary key,
	dept_name varchar
);
	
--full employee register; employee # = unique
create table emps (
	emp_num varchar primary key,
	title_id varchar,
		foreign key (title_id) references titles (title_id),
	dob varchar,
	first_name varchar,
	last_name varchar,
	sex varchar (1),
	hire_date varchar
);

--employee #/dept #, many-to-many
create table dept_emp (
	emp_num varchar,
		foreign key (emp_num) references emps (emp_num),
	dept_num varchar,
		foreign key (dept_num) references depts (dept_num)
);

--employee #/dept# of only managers
create table dept_manager (
	dept_num varchar,
		foreign key (dept_num) references depts (dept_num),
	emp_num varchar,
		foreign key (emp_num) references emps (emp_num)
);

--employee #/salary
create table salaries (
	emp_num varchar primary key,
	salary int
);

--assignments for output

--1. list employee #, last name, first name, sex, salary
select
	e.emp_num, e.last_name, e.first_name, e.sex,
	s.salary
from emps as e
left join salaries as s
on e.emp_num = s.emp_num;

--2. list first name, last name, & hire dates for: hire dates in 1986
select first_name, last_name, hire_date
from emps
where hire_date like '%1986';

--3. list dept #, dept name, employee #, last name, first name for: manager of each dept
select dm.*, d.dept_name, e.last_name, e.first_name
from emps as e
right join dept_manager as dm
	on e.emp_num = dm.emp_num
left join depts as d
	on dm.dept_num = d.dept_num
;

--4. list employee #, last name, first name, dept name by dept
create table emp_dept_jxn as (
	select e.emp_num, e.last_name, e.first_name, de.dept_num, d.dept_name
	from emps as e
	full outer join dept_emp as de
		on e.emp_num = de.emp_num
	full outer join depts as d
		on de.dept_num = d.dept_num
);

select * from emp_dept_jxn
order by dept_name;

--5. list first name, last name, sex for: first name "Hercules", last name starting w/ "B"
select first_name, last_name, sex
from emps
where
	first_name = 'Hercules' and
	last_name like 'B%'
;

--6. list employee #, last name, first name, dept name for: employees in sales dept
select emp_num, last_name, first_name, dept_name
from emp_dept_jxn
where dept_name = 'Sales';

--7. list employee #, last name, first name, dept name for: employees in both sales & development depts
select emp_num, last_name, first_name, dept_name
from emp_dept_jxn
where
	dept_name = 'Development' and
	emp_num in (
		select emp_num
		from emps
		where dept_name = 'Sales'
	)
;

--or just employees in either sales or development? since the above query returns no results
select emp_num, last_name, first_name, dept_name
from emp_dept_jxn
where
	dept_name = 'Sales' or
	dept_name = 'Development'
;

--8. list count of last names in descending order
select last_name, count (last_name) as last_name_count
from emps
group by last_name
order by last_name_count desc;