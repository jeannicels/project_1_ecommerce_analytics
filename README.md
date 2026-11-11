# Brazilian E-Commerce Sales & Customer Analytics

An end-to-end data analytics portfolio project using the Brazilian
E-Commerce Public Dataset by Olist. This project explores sales
performance, customer purchasing behaviour, product categories, payment
methods, and delivery performance using Python, PostgreSQL, SQL, and
Power BI.

## Project Overview

The goal of this project is to transform raw e-commerce transaction data
into actionable business insights through data exploration, data
preparation, SQL analysis, and dashboard development.

### Business Questions

-   How does product revenue change over time?
-   Which product categories generate the most revenue?
-   How frequently do customers make repeat purchases?
-   Which payment methods are most commonly used?
-   How long does delivery take, and how often are orders delivered
    late?
-   What is the distribution of orders across order statuses?

## Dashboard

The Power BI dashboard includes:

-   Total Orders
-   Total Product Revenue
-   Average Order Value (AOV)
-   Monthly Product Revenue Trend
-   Revenue by Product Category
-   Orders by Status
-   Monthly Sales Overview

**Power BI file:**
[`dashboard/Brazilian_Ecommerce_Analytics.pbix`](dashboard/Brazilian_Ecommerce_Analytics.pbix)\
**PDF preview:**
[`dashboard/Brazilian_Ecommerce_Analytics.pdf`](dashboard/Brazilian_Ecommerce_Analytics.pdf)

Open the `.pbix` file with Power BI Desktop. The PDF provides a static
view of the dashboard.

## Tools & Technologies

  Tool               Purpose
  ------------------ -----------------------------------------------
  Python             Data exploration and preparation
  Pandas             Data manipulation and cleaning
  Jupyter Notebook   Exploratory analysis and preparation workflow
  PostgreSQL         Relational database
  SQL                Business analysis and data validation
  Power BI           Dashboard and data visualization

## Dataset

**Source:** [Brazilian E-Commerce Public Dataset by Olist --
Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The dataset contains approximately 100,000 orders from 2016 to 2018 and
multiple related tables, including customers, orders, order items,
payments, reviews, products, sellers, geolocation, and product category
translations.

The raw dataset is not included in this repository. Download it from
Kaggle and place the CSV files in the expected local `data/` directory
before reproducing the analysis.

## Project Workflow

### 1. Exploratory Data Analysis

Notebook:
[`notebook/01_data_exploration.ipynb`](notebook/01_data_exploration.ipynb)

Explored the dataset to understand its structure, identify data quality
issues, and investigate:

-   Sales and monthly revenue trends
-   Customer purchase frequency and repeat purchases
-   Geographic distribution of customers
-   Product category performance
-   Payment method distribution and installment behaviour
-   Delivery duration and late delivery patterns

### 2. Data Preparation & Cleaning

Notebook:
[`notebook/02_data_preparation.ipynb`](notebook/02_data_preparation.ipynb)

Prepared analysis-ready datasets for PostgreSQL and Power BI.

Key steps included: - Inspecting missing values and duplicate records -
Converting timestamp columns to datetime format - Preserving missing
timestamps and optional review comments - Standardising missing product
categories as `unknown` - Removing exact duplicate geolocation records -
Validating key relationships between datasets - Exporting cleaned
datasets to `data/processed/`

### 3. PostgreSQL & SQL Analysis

The prepared datasets were loaded into PostgreSQL for business-focused
analysis.

  ------------------------------------------------------------------------------------------------
  SQL File                                                     Analysis
  ------------------------------------------------------------ -----------------------------------
  [`01_revenue_analysis.sql`](sql/01_revenue_analysis.sql)     Revenue, monthly trends, and
                                                               revenue breakdown

  [`02_customer_analysis.sql`](sql/02_customer_analysis.sql)   Customer purchase frequency and
                                                               repeat purchase rate

  [`03_product_analysis.sql`](sql/03_product_analysis.sql)     Product category performance

  [`04_payment_analysis.sql`](sql/04_payment_analysis.sql)     Payment methods, installments, and
                                                               payment reconciliation

  [`05_delivery_analysis.sql`](sql/05_delivery_analysis.sql)   Delivery duration and late delivery
                                                               performance
  ------------------------------------------------------------------------------------------------

SQL techniques include JOINs, GROUP BY, aggregate functions, CTEs,
subqueries, conditional aggregation, and window functions.

## Key Findings

### Sales Performance

-   Dashboard total product revenue: approximately **R\$13.59 million**.
-   Total orders: **99,441**.
-   Dashboard Average Order Value: **R\$136.68**.

### Customer Behaviour

-   Repeat purchase rate was approximately **3%**.
-   The customer base was dominated by one-time purchasers, indicating
    an opportunity to improve customer retention.

### Product Category Performance

-   Health & Beauty generated the highest product revenue.
-   Watches & Gifts ranked second.
-   Bed, Bath & Table ranked third.

### Payment Behaviour

-   Credit card accounted for approximately **73.92% of payment
    records**.
-   Boleto was the second most frequently used payment method at
    approximately **19.04%**.

### Delivery Performance

-   Average delivery time was approximately **12.56 days**.
-   Late delivery rate was approximately **8.11%**.
-   Delivery performance varied across Brazilian states.

## Metric Definitions

-   **Product Revenue:** Sum of product item prices (`price`); freight
    is excluded.
-   **Dashboard Total Product Revenue:** Sum of `price` across all order
    items in the dataset.
-   **Dashboard Average Order Value:** Dashboard total product revenue
    divided by distinct orders across the dataset.
-   **Delivered Revenue (SQL):** Product revenue from delivered orders
    with a non-null customer delivery timestamp.
-   **Late Delivery:** An order where the actual customer delivery
    timestamp is later than the estimated delivery timestamp.

**Important:** The dashboard includes all order items, while some SQL
revenue analyses focus only on delivered orders. Their revenue and AOV
figures use different scopes and should not be compared directly.

## Repository Structure

``` text
project_1_ecommerce_analytics/
├── dashboard/
│   ├── Brazilian_Ecommerce_Analytics.pbix
│   └── Brazilian_Ecommerce_Analytics.pdf
├── notebook/
│   ├── 01_data_exploration.ipynb
│   └── 02_data_preparation.ipynb
├── sql/
│   ├── 01_revenue_analysis.sql
│   ├── 02_customer_analysis.sql
│   ├── 03_product_analysis.sql
│   ├── 04_payment_analysis.sql
│   └── 05_delivery_analysis.sql
├── .gitignore
└── README.md
```

## How to Run

### Prerequisites

-   Python 3.x
-   Jupyter Notebook
-   PostgreSQL
-   Power BI Desktop

### 1. Clone the repository

``` bash
git clone https://github.com/jeannicels/project_1_ecommerce_analytics.git
cd project_1_ecommerce_analytics
```

### 2. Install Python dependencies

``` bash
pip install pandas numpy matplotlib seaborn jupyter
```

### 3. Download the dataset

Download the [Olist Brazilian E-Commerce dataset from
Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
Place the source CSV files in the local `data/` directory using the
filenames expected by the notebooks.

### 4. Run the notebooks

Run these notebooks in order:

1.  `notebook/01_data_exploration.ipynb`
2.  `notebook/02_data_preparation.ipynb`

### 5. Set up PostgreSQL

Create the database:

``` sql
CREATE DATABASE olist_commerce;
```

Import the prepared CSV files into PostgreSQL, configure the required
table relationships, and run the SQL scripts in the `sql/` directory.

### 6. Open the Power BI dashboard

Open `dashboard/Brazilian_Ecommerce_Analytics.pbix` in Power BI Desktop.
Update the PostgreSQL connection settings if your local database
configuration differs.

## Business Recommendations

1.  **Improve customer retention:** Explore loyalty programmes,
    personalised promotions, and post-purchase engagement to encourage
    repeat purchases.
2.  **Prioritise high-performing categories:** Monitor inventory and
    marketing support for categories generating the highest revenue.
3.  **Maintain payment flexibility:** Continue supporting widely used
    payment methods while evaluating opportunities to improve
    alternative payment adoption.
4.  **Improve delivery operations:** Investigate late delivery patterns
    across states and identify opportunities to improve logistics
    performance.

## Limitations

-   The dataset contains historical transactions from 2016--2018 and may
    not reflect current market conditions.
-   Some records contain missing timestamps or optional attributes.
-   The final months of the dataset contain incomplete periods.
-   Payment reconciliation identified discrepancies that require further
    investigation.
-   Observed relationships do not necessarily establish causation.

## Author

**Jeannice Laurensia Santoso**\
Computer Science Student \| University of Wollongong

[GitHub Profile](https://github.com/jeannicels)

------------------------------------------------------------------------

*This project was developed as an end-to-end data analytics portfolio
project, covering data exploration, data preparation, SQL analysis, and
business intelligence visualization.*
