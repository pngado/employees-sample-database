# Employees Database Analysis in SQL

## Description
This project focuses on analyzing the Employees sample database using SQL. The Employees database is a large dataset consisting of approximately 160MB of data spread across six separate tables, totalling 4 million records. The project aims to demonstrate SQL skills through the implementation of various queries and operations on the database, including aggregate functions, joins, Common Table Expressions (CTEs), subqueries, and stored procedures. 

## Table of Contents
- [Introduction](#introduction)
- [Installation](#installation)
- [Database](#database)
- [SQL Skills Demonstrated](#sql-skills-demonstrated)
- [License](#license)

## Introduction
The Employees sample database was developed by Patrick Crews and Giuseppe Maxia. It offers a comprehensive collection of data to practice SQL skills and consists of six tables with a wide range of records. In addition to the data, the database includes a suite of tests to ensure data integrity during initial load and subsequent usage.

## Installation
1. Download the repository
2. Change the directory to the repository
   
Then run: 

```
mysql < employees.sql
```
Please refer to the employee-en.a4.pdf document for more information on the database and how to install it. 

## Database
The Employees database provides a combination of data spread over six separate tables, including information related to employees, departments, salaries, titles, and more. The tables are structured to be compatible with various storage engine types, and support for partitioned tables is also included.

## SQL Skills Demonstrated
This project demonstrates proficiency in the following SQL skills:

- Aggregate functions: Utilizing functions such as `COUNT`, `SUM`, `AVG`, etc., to perform calculations on groups of data.
- Joins: Combining data from multiple tables using different types of joins, such as inner joins, outer joins, and self-joins.
- Common Table Expressions (CTEs): Creating temporary result sets within SQL statements for easier data manipulation.
- Subqueries: Embedding queries within other queries to retrieve specific data or perform calculations.
- Stored procedures: Creating and executing stored procedures to encapsulate and reuse SQL code.

## License
This work is licensed under the [Creative Commons Attribution-Share Alike 3.0 Unported License](http://creativecommons.org/licenses/by-sa/3.0/). To view a copy of this license, visit the provided link or send a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco, California, 94105, USA.

Please note that the Employees sample database itself may have its own license terms. Refer to the database repository for more details.

