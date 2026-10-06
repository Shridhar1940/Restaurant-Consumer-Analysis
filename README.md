# 🍽️ Restaurant & Consumer Data Analysis using MySQL

## 📌 Project Overview

This project focuses on analyzing **restaurant and consumer data using MySQL** to understand consumer preferences, restaurant performance, ratings, and demographic patterns.

The project uses a relational database containing information about consumers, restaurants, cuisines, consumer preferences, and ratings. SQL queries are used to extract meaningful insights that can support both **consumer-focused analysis and restaurant business decisions**.

---

## 🎯 Project Objective

The main objective of this project is to:

* Analyze consumer demographics and behavior.
* Understand consumer cuisine preferences.
* Analyze restaurant ratings and performance.
* Identify patterns based on consumer location, age, occupation, budget, and transportation.
* Perform advanced SQL analysis to generate meaningful business insights.
* Demonstrate practical SQL skills using a relational database.

---

## 🛠️ Tools & Technologies

* **MySQL**
* **MySQL Workbench**
* **SQL**

---

## 🗂️ Database Tables

The project contains the following main tables:

| Table                  | Description                                            |
| ---------------------- | ------------------------------------------------------ |
| `consumers`            | Contains consumer demographic and personal information |
| `restaurants`          | Contains restaurant details                            |
| `ratings`              | Contains consumer ratings for restaurants              |
| `restaurant_cuisines`  | Contains cuisines offered by restaurants               |
| `Consumer_Preferences` | Contains consumer cuisine preferences                  |

---

## 🔗 Database Design

The database was designed as a relational database with relationships between consumers, restaurants, ratings, cuisines, and consumer preferences.

### ER Diagram

![ER Diagram](ER_Diagram.png)

---

## 📊 Analysis Performed

### 👤 Consumer Analysis

* Analyzed consumers based on **city, age, occupation, budget, and transportation method**.
* Identified consumer groups based on different demographic characteristics.
* Analyzed students and their preferences.
* Examined consumers who have provided restaurant ratings.

### 🍴 Restaurant Analysis

* Analyzed restaurant ratings.
* Compared restaurant performance based on overall ratings.
* Identified restaurants based on cuisine and location.
* Analyzed highly rated restaurants.

### 🌮 Cuisine Analysis

* Analyzed consumer cuisine preferences.
* Identified Mexican, Italian, and other cuisine-related preferences.
* Connected consumer preferences with restaurants and ratings.

### ⭐ Rating Analysis

* Analyzed overall, food, and service ratings.
* Identified consumers based on their rating behavior.
* Compared ratings across restaurants and locations.
* Used ranking techniques to analyze restaurant ratings.

---

## 🧠 SQL Concepts Used

The project demonstrates both basic and advanced SQL concepts, including:

* `SELECT`
* `WHERE`
* `ORDER BY`
* `GROUP BY`
* `HAVING`
* Aggregate Functions
* `CASE` Statements
* `INNER JOIN`
* `LEFT JOIN`
* Subqueries
* Derived Tables
* Common Table Expressions (CTEs)
* Window Functions
* `ROW_NUMBER()`
* `RANK()`
* `DENSE_RANK()`
* `LEAD()`
* `LAG()`
* `NTILE()`
* `PERCENT_RANK()`
* `CUME_DIST()`
* `EXISTS`
* `NOT EXISTS`
* Views
* Stored Procedures
* Triggers
* Constraints
* `SIGNAL SQLSTATE`

---

## 🔍 Advanced SQL Analysis

Some of the advanced analysis performed includes:

* Ranking restaurant ratings within cities using window functions.
* Calculating average ratings using window functions.
* Finding consumers who meet specific rating criteria.
* Analyzing consumers from specific cities and their restaurant choices.
* Finding average consumer age by occupation.
* Identifying consumers with specific cuisine preferences.
* Using CTEs to simplify complex queries.
* Using derived tables to analyze consumers who have submitted ratings.
* Using ranking and percentile functions for analytical comparisons.

---

## 📈 Key Insights

The analysis helps identify:

* Consumer demographic patterns.
* Differences in preferences across consumer groups.
* Popular cuisine preferences.
* Restaurant performance based on consumer ratings.
* Relationship between consumer characteristics and restaurant choices.
* High-performing restaurants and cuisines.
* Rating patterns across different locations.

These insights can help restaurants better understand their customers and improve **customer targeting, menu planning, and service quality**.

---

## 📁 Project Files

```text
Restaurant-Consumer-SQL-Analysis/
│
├── SQL_Queries.sql
├── ER_Diagram.png
├── README.md
└── Project_Presentation.pptx
```

---

## 💡 Business Value

This project demonstrates how SQL can be used to convert raw relational data into meaningful business insights.

The analysis can be useful for:

**Restaurants**

* Understanding customer preferences
* Improving menu offerings
* Monitoring restaurant performance
* Improving customer experience

**Consumers**

* Understanding restaurant and cuisine preferences
* Identifying highly rated restaurants
* Comparing restaurant performance

---

## 👨‍💻 Skills Demonstrated

* SQL Data Analysis
* Relational Database Design
* Data Exploration
* Business Analytics
* Advanced SQL
* MySQL Workbench
* Analytical Thinking
* Business Insight Generation

````

### One small change I recommend

If your actual SQL file has a specific name, replace:

`SQL_Queries.sql`

with the **exact filename** you uploaded to GitHub.

Also make sure your ER diagram filename matches:

```text
![ER Diagram](ER_Diagram.png)
````

If your image is named something like `ER Diagram.png`, either rename it to `ER_Diagram.png` or change that line accordingly.
