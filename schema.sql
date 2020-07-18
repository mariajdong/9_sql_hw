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