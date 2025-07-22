# 📦 Supply Chain Dataset (MySQL-Ready)

This project is based on a supply chain dataset stored in an Excel file (`Supply_Chain_Dataset.xlsx`) and is prepared for importing into a MySQL database for SQL-based querying, reporting, and analysis.

## 🗂️ Dataset Description

The Excel file typically contains one or more sheets with information such as:

- `Order ID`
- `Customer Name`
- `Order Date`
- `Ship Date`
- `Region`
- `Product Category`
- `Product Name`
- `Sales`
- `Quantity`
- `Discount`
- `Profit`
- `Shipping Cost`
- `Order Priority`

> Exact columns may vary depending on the source. You can inspect and clean the data in Excel or Python before import.

## 🛠️ MySQL Setup

### 1. Create the Database

```sql
CREATE DATABASE supply_chain;
USE supply_chain;
