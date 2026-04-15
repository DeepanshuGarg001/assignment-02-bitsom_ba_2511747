# Normalization Analysis

## Anomaly Analysis

### 1. Insert Anomaly
**Example:** To add a product like `P010` ("Bluetooth Speaker"), we must create an entire order row with customer and sales rep details, even if no sale exists. The flat file prevents storing product data independently.

### 2. Update Anomaly
**Example:** "Deepak Joshi" (`SR01`) appears in 83 rows (e.g., `ORD1114`, `ORD1091`, `ORD1012`). If his office address changes, every row must be updated. Missing one row leads to data inconsistency.

### 3. Delete Anomaly
**Example:** Product `P008` ("Webcam") appears only in `ORD1185` (Line 13). Deleting this order removes our only record of `P008`'s existence (name, category, price).

---

## Normalization Justification

Keeping everything in one table like `orders_flat.csv` causes data redundancy and integrity risks. In a normalized 3NF schema, entities like Customers and Products exist independently. This eliminates anomalies: updates are made in one place, and deleting an order doesn't result in the accidental loss of customer or product data.

Normalization guarantees consistency and eliminates data loss risks. While it adds query complexity via joins, the protection against corrupted data is a fundamental requirement for production business systems. Furthermore, a normalized schema is more adaptable to change; for instance, adding a new marketing attribute to a customer record only requires modifying one row in the Customers table, rather than updating thousands of redundant entries in a flat file. This reduces the cognitive load on developers and prevents the accumulation of technical debt associated with managing inconsistent datasets.
