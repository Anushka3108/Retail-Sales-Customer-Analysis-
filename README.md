🛒 Retail Sales Analysis (SQL Project)

This project focuses on analyzing large-scale retail sales data using SQL to uncover business insights, track performance, and optimize query efficiency.

📌 Project Overview

The analysis is built on structured retail datasets including sales, products, stores, categories, and warranty information.

It answers key business questions around:

Product performance
Regional and store-wise sales
Category contribution
Time-based trends
Demand patterns
🗂️ Database Schema

The project consists of the following tables:

sales → transactional data (revenue, quantity, date)
products → product details and pricing
category → product categorization
stores → store location and region
warranty → product warranty details
🚀 Key Analysis Performed
🔹 1. Business Overview
Total orders, revenue, and units sold
Sales date range
🔹 2. Product Performance
Top 10 revenue-generating products
Bottom-performing products
🔹 3. Revenue Concentration Analysis
Identified top 25% products contributing maximum revenue using NTILE()
🔹 4. Store & Regional Analysis
Revenue by store
Region-wise performance comparison
🔹 5. Category Insights
Revenue and units sold per category
🔹 6. Time-Based Trends
Monthly revenue trends
Peak sales days
🔹 7. Demand Analysis
Most frequently purchased products
🔹 8. Warranty Impact
Revenue distribution based on warranty period
🔹 9. Advanced SQL Analysis
Running revenue using window functions
Top-performing product per region using RANK()
⚙️ SQL Techniques Used
Joins (INNER JOIN)
Aggregations (SUM, COUNT)
Window Functions (RANK, NTILE, OVER)
CTEs (Common Table Expressions)
Date Functions (DATE_TRUNC)
Indexing for performance optimization
📈 Performance Optimization
Created indexes on:
product_id
store_id
Improved query performance and reporting speed
📊 Key Insights
Top-performing products contribute a significant portion of total revenue
Regional differences highlight targeted expansion opportunities
Sales trends show clear peak periods and demand cycles
High-demand products can guide inventory and marketing strategies
🛠️ Tech Stack
SQL (PostgreSQL / MySQL compatible)
Database Optimization Techniques
🎯 Outcomes
Enabled data-driven decision-making
Improved reporting efficiency
Identified actionable business insights for growth and optimization
