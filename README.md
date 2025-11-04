# Data Project: SQL Logic Queries

---

## 🧩 Project Description

This project contains a complete collection of 64 SQL queries developed to explore and practice logical data operations using PostgreSQL.
The database schema is based on a movie rental system, containing tables such as film, actor, customer, rental, payment, inventory, store, and category.

The goal of this project is to apply and demonstrate solid knowledge of SQL logic, including:
- Data retrieval and filtering (WHERE, BETWEEN, IN, LIKE)
- Sorting and grouping (ORDER BY, GROUP BY, HAVING)
- Use of aggregate functions (SUM, AVG, COUNT, STDDEV, VARIANCE)
- Different types of joins (INNER, LEFT, FULL, CROSS)
- Subqueries and common table expressions (CTE, WITH)
- Creation of views and temporary tables
  
---

## 📂 Project Structure

The project is organized as follows:
- **DataProject_SQLLogicQueries.sql** – Main file containing all 64 SQL queries with detailed comments.
- **README.md** – Project documentation and overview.
- **Diagram_SQLLogicQueries.png** – Database schema diagram used as a visual reference for the queries.

---

## ⚙️ Technical Details

- **Language:** SQL (PostgreSQL syntax)
- **File:** DataProject_LogicaConsultasSQL.sql
- **Tables used:** film, actor, film_actor, film_category, category, rental, customer, payment, inventory, store, staff
- Additional structures:
  - **Views:** actor_num_peliculas
  - **Temporary tables:** (cliente_rentas_temporal, peliculas_alquiladas, actor_category_table)

---

## ✅ Results and Conclusions

Throughout this project, I applied the theoretical concepts learned in class to practical, real-world SQL problems.
The 64 queries progressively explore filtering, grouping, joins, subqueries, and data aggregation, providing a complete view of relational database logic in PostgreSQL.

When encountering challenges — such as handling INTERVAL data types or using functions like STRING_AGG — I went beyond the classroom material to consult PostgreSQL documentation and additional resources.
This helped me deepen my understanding of SQL and strengthen my problem-solving abilities when working with more advanced database operations.

Overall, this project allowed me to consolidate the theoretical foundations of SQL while gaining the confidence to design clear, efficient, and scalable queries applicable to real-world data analysis.

---

**Author:** Clàudia Rafart Medina
