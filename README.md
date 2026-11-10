# E-commerce Sales Analysis

Analysis of sales, profit, products, and regions of a retail store using **Excel, MySQL, and Power BI**.

## Objective
Find out which regions, cities, and product categories drive sales and profit, and which ones cause losses, so the business can make better decisions on pricing and discounts.

## Tools Used
| Tool | Purpose |
|------|---------|
| Excel | Data cleaning, validation, summary dashboard |
| MySQL Workbench | Analysis queries (aggregation, grouping, filtering, CASE logic) |
| Power BI | Interactive dashboard |

## Dataset
Public **Sample Superstore** dataset (not original company data).

- 4,999 records, United States
- Columns: Order Date, Country, City, State, Postal Code, Region, Category, Sub-Category, Sales, Quantity, Discount, Profit

## Key Metrics
| Metric | Value |
|--------|-------|
| Total Sales | $1,140,329.72 |
| Total Profit | $128,343.45 |
| Total Quantity Sold | 18,970 |
| Profit Margin | 11.25% |

## Key Insights

**Regions**
- **West** leads in both sales ($359,640) and profit ($48,024).
- **Central** is the weakest: $244,408 in sales but only $11,703 profit.

**Categories**
- **Technology** earns the most profit ($62,998).
- **Furniture** has high sales ($353,608) but very low profit ($9,281).

**Loss-making sub-categories**
- Tables (-$9,431), Machines (-$2,085), Bookcases (-$2,049), Supplies (-$920).

**Discounts hurt profit**
- With **no discount**, profit is $150,537.
- At **30% discount and above**, every level makes a loss. The 70% and 80% discounts lose about $19,469 and $15,496.

**Top cities by sales**
- New York City ($120,263), Los Angeles ($83,917), San Francisco ($66,927).

## Recommendations
- Limit discounts above 20-30%, since they turn sales into losses.
- Review pricing and costs for Tables, Machines, and Bookcases.
- Investigate why the Central region has a low margin.
- Focus on Technology and the West region, which perform best.

## SQL Concepts Used
`SELECT`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`, `LIMIT`, `DISTINCT`, `LIKE`, `BETWEEN`, `CASE WHEN`, aggregate functions (`SUM`, `AVG`, `MAX`, `MIN`, `COUNT`), `ROUND`

## Project Structure
```
ecommerce-sales-analysis/
├── README.md
├── data/
│   ├── SampleSuperstore.csv
│   └──
