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




   
  
          *   * `__Budget__` customers contributed `__₹XXXXX__`
* **Top Spending Customers:**
  (IDs: `__CUST123__`, `__CUST456__`) spent over `__₹XXXXX__`

> 📌 *Insight:* Premium customers contribute a disproportionate share of revenue. Targeted loyalty programs may increase retention.

---

## 📦 3. Product Sales Performance

* **Total Products Sold:** `__XXXX__`
* **Top Selling Product:** `__Product Name__` with `__X,XXX__` units sold
* **Revenue by Product Category:**

  * `__Category A__` — `__₹XXXXX__`
  * `__Category B__` — `__₹XXXXX__`
* **Top Brand by Revenue:** `__Brand Name__`

> 📌 *Insight:* Specific product categories and brands are outperforming others — inventory planning and promotions can focus here.

---

## 📈 4. Time-Based Trends

* **Monthly Sales Trend:**

  * Highest month: `__Month Name__` with `__₹XXXXX__` in revenue
  * Lowest month: `__Month Name__` with `__₹XXXXX__`
* **Quarterly Performance:**

  * Q1: `__₹XXX__` | Q2: `__₹XXX__` | Q3: `__₹XXX__` | Q4: `__₹XXX__`
* **Weekday Trends:**

  * Busiest day: `__Monday__`
  * Slowest day: `__Tuesday__`

> 📌 *Insight:* Sales peak in specific months and weekdays, enabling more effective staffing and marketing decisions.

---

## 🎯 5. Campaign Effectiveness

* **Total Campaigns:** `__XX__`
* **Top Campaign:** `__Campaign Name__` with sales of `__₹XXXXX__`
* **Underperforming Campaigns (Bottom 25%):**

  * `__Campaign A__`, `__Campaign B__`, etc.

> 📌 *Insight:* Evaluate low-performing campaigns for potential redesign or discontinuation.

---

## 🧑‍💼 6. Salesperson Performance

* **Top Salesperson:** `__Name__` — `__₹XXXXX__` revenue
* **Sales Distribution by Role:**

  * `__Senior Reps__`: `__₹XXXXX__`
  * `__Junior Reps__`: `__₹XXXXX__`

> 📌 *Insight:* High-performing reps can be used for training and best practices sharing.

---

## 🧹 7. Data Cleaning Summary

* `dim_dates.full_date` had inconsistent formats (some serials like `58628`)

  * ✅ Cleaned using `DATE_ADD('1899-12-30', INTERVAL full_date DAY)`
* `fact_sales_normalized.sales_date` contained timestamp (`T15:28:02`)

  * ✅ Extracted clean date using `DATE(f.sales_date)` → `clean_sales_date`
* ✅ Deduplicated `dim_dates` using `GROUP BY full_date HAVING COUNT(*) > 1`

> 📌 *Insight:* Clean date joins were essential to accurate time-based analysis.

---

## 💡 Key Business Recommendations

* Focus marketing in regions like `__Top Location__` and push `__Top Brand__` products.
* Schedule flash sales or events during `__Busiest Month__` and on `__Top Weekday__`.
* Reinvest in campaigns with proven ROI and reassess those below 25th percentile.
* Empower top-performing salespersons and optimize underperforming teams.

---

## 📦 Tools Used

* MySQL (querying, cleaning, analysis)
* Excel (optional CSV validation)
* GitHub (project versioning and showcase)

---

## 🧐 Conclusion

This SQL project demonstrates a complete lifecycle of data analysis in a retail environment — including cleaning raw data, joining fact/dimension tables, advanced querying, and strategic reporting. It’s a powerful foundation for BI dashboards or executive summaries.

---
