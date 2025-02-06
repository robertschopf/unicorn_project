# 🦄 **Unicorn Company: Data Exploration & Insights**

## 📄 Context
Unicorn is a family-owned e-commerce company. In three main categories: Technology, Furniture and Office Supplies, it offers a wide range of products. Unicorn's Data Analytics (DA) team is in the process of scaling up, although a lot of data has already been collected. The next step will be to use this data for analyses.

---

## 🎯 Objective
The aim of the project was to analyse the data provided, gain interesting insights and identify weaknesses and opportunities to increase Unicorn's business growth.
Finally, the results were to be summarised in an interactive dashboard and provide insights into Unicorn's business trend in the period from 2015 to 2018. The dashboard users should then be able to filter the results independently and customise them to their needs (departments).

---

## 🚀 Approach and Implementation
After analysing the data with SQL, I was able to design an interactive dashboard. The aim was to provide an overview of several key performance indicators (KPIs). The profit results of the individual divisions showed that the furniture division had by far the weakest results.

The company has shown continuous growth in turnover and sales. The peaks tended to be achieved in the months of May, September, November and December.
In the individual product categories, it was evident that technology and office supplies made a positive contribution to the company's results. The furniture category showed a negative trend, even posting a negative result in 2018. 

---

## 📊 Project Steps

**Step 1: SQL Queries**
* Schema Exploration:
  * Analyzed the database schema (table structures, relationships) using SQL queries (e.g., SELECT * FROM customers LIMIT 5;, DESCRIBE customers;) to understand the available data fields and their relationships.

* Data Extraction:
  * Wrote and executed SQL queries to answer key questions about:
  * Product Performance: Total sales by product category, best-selling products, product profitability.
  * Customer Segmentation: Customer demographics, purchase history, customer lifetime value.
  * Geographic Performance: Sales trends by region, city, and state.
  * Temporal Trends: Sales trends over time (monthly, quarterly, yearly).

* Data Documentation: Documented all SQL queries and their results with clear explanations to ensure reproducibility and facilitate future analysis.
  
**Step 2: Google-Sheets**
* Aggregation:  
   Pivot tables were used to aggregate key metrics such as total sales, profit and average order value for each combination of product category and customer segment to analyze their contribution to the overall result.
  
* Calculated key figures:  
  New metrics such as price per unit and profit margin have been developed to more accurately assess the profitability of individual products and orders.

* Conditional formatting:  
  Conditional formatting was used to visually highlight important trends and outliers. For example, rising sales, declining sales and particularly profitable segments were explicitly highlighted.

**Step 3: Tableau**  
  The dashboard provides a comprehensive overview of business performance and makes it possible to gain important insights. By visualizing KPIs and trends, well-founded decisions can be made.


<img width="1695" alt="Screenshot 2025-02-06 at 10 10 38" src="https://github.com/user-attachments/assets/3e1633d3-f525-43de-add5-bf15ba6fbd37" />

---

## 🔍 Insights
* **Overall performance:**  
   * This shows a positive sales and profit trend in the period from 2015 to 2018, with strong seasonal fluctuations in the KPIs sales and profit.
   * November and December are the most profitable months in terms of this special KPI`s.

* **Product category performance:**  
   * Technology and office supplies appear to be the most profitable categories.
   * while the Furniture category contains subcategories with very weak and below-average performance.

* **Regional performance:**  
   * The strongest sales and profit performance is achieved in the West and East regions.
   * This suggests potential for further market expansion in these regions.

---

## 🔮 Future Work
* **Price analysis:**  
   * Determine price elasticity: Conduct a detailed price analysis to determine the price elasticity of demand for different products and customer segments.
   * Identify price differentials: Investigate price differentials between regions, product categories, and customer segments.
   * Analyze discount patterns: Investigate the reasons for high discounts on certain products, such as clearance sales, competitive pressures, or potential inventory issues.

* **Product bundling:**  
   * Analyze purchase behavior: Investigate which products are frequently purchased together to identify potential cross-selling and up-selling opportunities.
   * Develop and test: Create and test attractive product bundles to increase average order value and customer satisfaction.

* **Data enrichment:**  
   * Collect additional data: Collect customer feedback on product conditions, return rates, and customer demographics (age, income, location) to gain deeper insights into customer behavior and preferences.
   * ntegrate external data: Consider integrating external data sources such as macroeconomic indicators, competitor information, and market trends.

---

## 🌟 Standout Section
**Beyond the core requirements, I enhanced my analysis by:**
   * Segmenting within Categories: I utilized calculated metrics in Google Sheets (e.g., price per unit, profit margin) to further segment sales and profit KPIs within each product category.
   * Refining Tableau Filters: I adjusted Tableau filters to analyze trends for specific product subcategories and to investigate the performance of different customer segments within each region. This allowed for a more in-depth analysis of product performance within each category and the identification of high-performing and underperforming subcategories.

---

## 📋 Executive Summary
* Executive Summary Document

---

## 🔗 Links
* Link to Tableau Dashboard:  View Dashboard
* Link to Google Sheets:      View Spreadsheet
* Link to SQL Documentation:  View SQL Documentation

---

## ✅ Recommendations

---

💡 Thank you for reviewing my project!
