> 📂 Download Full Dataset>>(https://www.kaggle.com/datasets/shrinivasv/retail-store-star-schema-dataset)


# Retail-Sales-Analysis-with-Advanced-SQL
Welcome to the **Retail Sales SQL Analysis Project**, where we dive deep into a structured retail database using SQL for data exploration, cleaning, advanced joins, and executive-level business insights. 

##  Executive Summary – Retail Sales Analysis

This report presents a complete SQL-based analysis of a multi-dimensional retail sales dataset. The primary objective was to derive actionable business insights from campaign performance, customer purchasing behavior, product sales, and store-level trends.

---
> *Note: All revenue figures are assumed to be in __INR (₹)__ based on typical price ranges. Please update if working with another currency context.*

##  1. Store Performance Analysis

* **Total Stores:** `__500__`
* **Top Performing Store:** `__NeoStore__` with total revenue of `__₹676595.97__`
* **Top 3 Store Locations by Revenue:**

  * `__San Antonio_` — `__₹494755.22__`
  * `__Indianapolis__` — `__₹464673.97__`
  * `_Fresno__` — `__₹453234.07__`

> 📌 *Insight:* These regions show the strongest demand and can be prioritized for future investment or expansion.

---

##  2. Customer Segmentation Insights

* **Total Customers:** `__58516__`
* **Customer Segments by Spend:**

  * `__Premium Shopper__` customers generated `__₹820687.40_` in sales
  * `__Budget Shopper__` customers contributed `__₹848191.17_`
  * `__Deal Seeker__` customers contributed `__₹889946.64__`
  * `__High Value__` customers contributed `__₹897383.76__`
  * `__Churn Risk	__` customers contributed `__₹941785.32__`
  * `__Online Shopper__` customers contributed `__₹952867.27__`
  * `__Loyal Customer__` customers contributed `__₹954807.26_`
  * `__First-time Buyer__` customers contributed `__₹956011.36_`
  * `__Loyal Customer__` customers contributed `__₹954807.26_`
  * `__Occasional Shopper__` customers contributed `__₹976510.32_`
  * `__In-Store Regular__` customers contributed `__₹1092768.46_`
    
* **Top Spending Customers:**
  (IDs: `__CUST_57356__`, `__CUST_08778__`,` __CUST_44253__`) spent over `__₹28077__`

> 📌 *Insight:* The "In-Store Regular" and "Occasional Shopper" segments generated the highest revenue. Meanwhile, "Loyal Customers" and "First-time Buyers" are both strong performers and should be nurtured through loyalty rewards.
---

## 3. Product Sales Performance

* **Total Products Sold:** `__5724_`
* **Top Selling Product:** `__Running Shoes__` with `__96__` units sold
* **Revenue by Product Category TOP 3:**
  
  * `__Sports & Outdoors__` — `__₹1026785.92__`
  * `__Clothing_` — `__₹864775.17__`
  * `__Furniture_` — `__₹858575.55__`
* **Top Brand by Revenue:** `__Nike__`

> 📌 *Insight:* __Sports and Outdoor__ categories and  __Nike__brands are outperforming others — inventory planning and promotions can focus here.

---

## 4. Time-Based Trends

* **Monthly Sales Trend:**

  * Highest month: `__June_` with `__₹283238.7_` in revenue
  * Lowest month: `__August__` with `__₹3126930.80__`
* **Quarterly Performance:**

  * Q1: `__₹777374.13__` | Q2: `__₹2982595.50__` | Q3: `__₹7525158.43__` | Q4: `__₹2025522.38__`
* **Weekday Trends:**

  * Busiest day: `__Tuesday__`
  * Slowest day: `__Saturday__`

> 📌 *Insight:* Sales peak in __June__ and __Tuesday__, enabling more effective staffing and marketing decisions.

---

## 5. Campaign Effectiveness

* **Total Distinct Campaigns:** `__50__`
* **Top Campaign:** `__Smart Shopper Week__` with sales of `__₹386484.44__`
  
* **Underperforming Campaigns : Campaign ROI ( Return on Investment) Overview:**
Most campaigns generated Negetive  ROI.
ROI = Revenue Generated - Campaign Budget.

> 📌 *Insight:* Those with negative ROI `__Early Bird Specials__`, `__Mid-Year Madness__`,`__Loyalty Rewards Blast__`, `__Final Call Frenzy__`, etc. should be reassessed or redesigned..

---

## 6. Salesperson Performance

* **Top Salesperson:** `__Julie Wells__` — `__₹35624.19__` revenue
* **Sales Distribution by Role:**

  * `__Sales Associate_`: `__₹3767680.77__`
  * `__Salesperson__`: `__₹3708419.37__`
  * `__Manager__`: `__₹3627057.83__`
  * `__Senior Salesperson__`: `__₹3349336.99__`

> 📌 *Insight:* High-performing reps can be used for training and best practices sharing.

---



##  Key Business Recommendations

* Focus marketing in regions like `__San Antonio__` and push `__Nike__` products.
* Schedule flash sales or events during `__June__` and on `__Tuesday__`.
* Reinvest in campaigns with proven ROI and reassess those with Negetive ROI.
* Empower top-performing salespersons and optimize underperforming teams.

---

##  Conclusion

This SQL project demonstrates a complete data analysis in a retail environment — including cleaning raw data, joining fact/dimension tables, advanced querying, and strategic reporting. It’s a powerful foundation for BI dashboards or executive summaries.

---
