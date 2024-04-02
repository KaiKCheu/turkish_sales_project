# turkish_sales_project

## Purpose

Generate a sales dashboard for 10 malls in Istanbul, Turkiye. 

## Overall Project Breakdown

Collected data from kaggle link: https://www.kaggle.com/datasets/mehmettahiraslan/customer-shopping-dataset

Imported data into MySQL database.

Utilized MySQL to query sales statistics including:

    1. Sales by Quarter

    2. % Change by Quarter

    3. Age Histogram 

    4. Payment Method Distribution

    5. Sales per category per mall 

Utilized Tableau to visualize statistics listed above

## MySQL File Breakdown

1. category_rankings_quantity: Query to find the top 5 products sold for each mall by quantity.  Store these values to a new table to store the rankings and categories for use in Tableau.

2. category_rankings_sales: Query to find the top 5 products sold for each mall by price.  Store these values to a new table to store the rankings and categories for use in Tableau.

3. updating_locations: Adds the addresses and coordinates to the original database.

4. age_histogram: Query the distribution of ages across each mall.  Store these distributions in a table for Tableau.

5. year_over_year: Query to find the total amounnt in change of sales year over year. Store these values in a table for use in Tableau

6. sales_per_quarter: Query to find the percent change in sales quarter to quarter.  Store these values in a table for use in Tableau

7. types_of_transactions: Query to find the distribution of payment types (i.e. Cash, Credit, Debit) for each mall. Store values into table for use in Tableau

## Tableau Sheet Breakdown

1. Sales By Category: Bar graph depicting distribution of sales by category.

2. Mall Sales By Quarter: Line graph depicting change in sales by quarter in dollar amount.

3. Percent Change by Quarter: Bar graph depicting percent change in sales by quarter

4. Mall Demographics: Mall's demographic breakdown






