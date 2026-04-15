# ETL Decisions

Under this section, I describe 3 specific transformation decisions made while cleaning the raw transactional data before loading it into the data warehouse.

## ETL Decisions

### Decision 1 – Temporal Standardization (Date Parsing)
**Problem:** The raw source `retail_transactions.csv` contained dates in multiple inconsistent formats, including `DD/MM/YYYY` (line 2), `DD-MM-YYYY` (line 3), and ISO `YYYY-MM-DD` (line 4).
**Resolution:** Implemented a regex-based parser during the ETL stage to identify the format and convert all dates into a unified `YYYY-MM-DD` format. This ensures that the `dim_date` table maintains a consistent primary key structure and allows for accurate time-series analysis across the entire dataset.

### Decision 2 – Categorical Normalization (Casing and Pluralization)
**Problem:** The `category` field displayed significant inconsistencies, such as `electronics` vs. `Electronics` (lines 2 and 3) and `Grocery` vs. `Groceries` (lines 7 and 10).
**Resolution:** Normalized all strings to **Proper Case** and standardized pluralization (e.g., all grocery items maps to 'Groceries'). This transformation is critical for the Data Warehouse because unstandardized categories would lead to split reporting where the same business unit appears as two separate entities in analytical dashboards.

### Decision 3 – Imputation of Missing Dimensional Attributes
**Problem:** Several rows in the raw data had missing values for critical dimensional fields. For example, in line 35 (`TXN5033`), the `store_city` was NULL even though the `store_name` ('Mumbai Central') was present.
**Resolution:** Instead of dropping these rows (which would lose revenue data) or leaving them NULL (which would break city-level reporting), I implemented a **Lookup Transformation**. The ETL process first builds a map of `store_name` to `store_city` from valid rows and uses it to impute the missing city values during the load phase.
