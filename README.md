# Brazilian E-Commerce Sales & Customer Analytics

An end-to-end data analytics portfolio project using the Brazilian
E-Commerce Public Dataset by Olist. The project explores sales
performance, customer purchasing behaviour, product categories, payment
methods, and delivery performance using Python, PostgreSQL, SQL, and
Power BI.

## Project Overview

This project transforms raw e-commerce transaction data into
analysis-ready datasets, performs exploratory and SQL-based analysis,
and presents business insights through a Power BI dashboard.

### Objectives

-   Analyse sales and revenue performance.
-   Understand customer purchasing behaviour and repeat purchases.
-   Identify high-performing product categories.
-   Examine payment methods and installment behaviour.
-   Evaluate delivery duration and late delivery patterns.
-   Communicate findings through a business intelligence dashboard.

## Dashboard Preview

The Power BI dashboard includes:

-   Total Orders
-   Total Product Revenue
-   Average Order Value (AOV)
-   Monthly Product Revenue Trend
-   Revenue by Product Category
-   Orders by Status
-   Monthly Sales Overview

**Power BI dashboard:**
[`dashboard/Brazilian_Ecommerce_Analytics.pbix`](dashboard/Brazilian_Ecommerce_Analytics.pbix)\
**Dashboard PDF:**
[`dashboard/Brazilian_Ecommerce_Analytics.pdf`](dashboard/Brazilian_Ecommerce_Analytics.pdf)

The `.pbix` file can be opened with Power BI Desktop. The PDF provides a
static preview of the dashboard.

## Tools & Technologies

  Tool               Purpose
  ------------------ -----------------------------------------
  Python             Data exploration and preparation
  Pandas             Data cleaning and transformation
  Jupyter Notebook   Exploratory data analysis
  PostgreSQL         Relational database management
  SQL                Business analysis and validation
  Power BI           Dashboard development and visualization

## Dataset

**Source:** [Brazilian E-Commerce Public Dataset by Olist --
Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The dataset contains approximately 100,000 orders from 2016 to 2018 and
several related datasets.

  -----------------------------------------------------------------------
  Dataset                             Description
  ----------------------------------- -----------------------------------
  Customers                           Customer identifiers and location
                                      information

  Orders                              Order status and timestamps

  Order Items                         Products, prices, and freight
                                      values

  Payments                            Payment types, values, and
                                      installments

  Reviews                             Customer review scores and comments

  Products                            Product information and categories

  Sellers                             Seller information

  Geolocation                         Brazilian zip code coordinates

  Category Translation                Portuguese-to-English product
                                      category mapping
  -----------------------------------------------------------------------

## Project Workflow

### 1. Exploratory Data Analysis

Notebook: `notebook/01_data_exploration.ipynb`

Explored the dataset to identify patterns and understand the business
context.

Analysis areas: - Sales and monthly revenue trends - Customer purchase
frequency and repeat purchases - Geographic distribution of customers -
Product category performance - Payment method distribution - Credit card
installment behaviour - Delivery performance

### 2. Data Preparation & Cleaning

Notebook: `notebook/02_data_preparation.ipynb`

Prepared analysis-ready datasets for PostgreSQL and Power BI.

Key preparation steps: - Inspected missing values and duplicate
records. - Converted timestamp columns to datetime format. - Preserved
missing timestamps and optional review comments. - Standardised missing
product categories as `unknown`. - Removed exact duplicate geolocation
records. - Validated key relationships between datasets. - Exported
cleaned datasets to `data/processed/`.

Raw source CSV files are kept separately in `data/`.

### 3. PostgreSQL & SQL Analysis

Loaded the prepared datasets into PostgreSQL and performed
business-focused analysis.

  -----------------------------------------------------------------------
  SQL File                            Analysis
  ----------------------------------- -----------------------------------
  `sql/01_revenue_analysis.sql`       Revenue, monthly trends, and
                                      revenue breakdown

  `sql/02_customer_analysis.sql`      Customer purchase frequency and
                                      repeat purchase rate

  `sql/03_product_analysis.sql`       Product category performance

  `sql/04_payment_analysis.sql`       Payment methods, installments, and
                                      payment reconciliation

  `sql/05_delivery_analysis.sql`      Delivery duration and late delivery
                                      performance
  -----------------------------------------------------------------------

SQL techniques include: - JOINs - GROUP BY and aggregate functions -
Common Table Expressions (CTEs) - Subqueries - Conditional aggregation -
Window functions

## Key Findings

### Sales Performance

-   Dashboard total product revenue: approximately **R\$13.59 million**.
-   Total orders: **99,441**.
-   Dashboard Average Order Value: **R\$136.68**.
-   Monthly product revenue increased substantially during 2017 and
    remained at a higher level through much of 2018.

### Customer Behaviour

-   Repeat purchase rate was approximately **3%**.
-   The customer base was heavily dominated by one-time purchasers.
-   This suggests an opportunity to improve retention through loyalty
    initiatives and targeted promotions.

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

**Important:** The Power BI dashboard includes all order items, while
some SQL revenue analyses focus only on delivered orders. Their revenue
and AOV figures therefore use different scopes and should not be
compared directly.

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
├── project brief/
├── data/
│   └── processed/
├── README.md
└── .gitignore
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
Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) and
place the original CSV files inside the `data/` directory, following the
filenames expected by the notebooks.

### 4. Run the notebooks

Run the notebooks in order:

1.  `notebook/01_data_exploration.ipynb`
2.  `notebook/02_data_preparation.ipynb`

### 5. Set up PostgreSQL

Create a database:

``` sql
CREATE DATABASE olist_commerce;
```

Import the processed CSV files into PostgreSQL, configure the required
table relationships, and then run the SQL scripts in the `sql/`
directory.

### 6. Open the Power BI dashboard

Open `dashboard/Brazilian_Ecommerce_Analytics.pbix` in Power BI Desktop.
Update the PostgreSQL connection settings if your local database
configuration is different.

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
5.  **Strengthen regional strategy:** Use customer concentration and
    delivery performance findings to inform regional planning.

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
