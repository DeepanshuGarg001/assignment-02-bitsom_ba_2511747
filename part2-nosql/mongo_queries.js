// Part 2: NoSQL Databases
// Task 2.2: MongoDB Operations

// OP1: insertMany() – insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    "product_id": "MNG_E101",
    "name": "Noise Cancelling Headphones X5",
    "category": "Electronics",
    "price": 25000.0,
    "stock": 150,
    "specs": { "warranty": "2 years" }
  },
  {
    "product_id": "MNG_C205",
    "name": "Premium Cotton T-Shirt",
    "category": "Clothing",
    "price": 1200.0,
    "stock": 500
  },
  {
    "product_id": "MNG_G309",
    "name": "Extra Virgin Olive Oil",
    "category": "Groceries",
    "expiry_date": "2024-12-15",
    "price": 3200.0,
    "stock": 75
  }
]);

// OP2: find() – retrieve all Electronics products with price > 20000
db.products.find({
  "category": "Electronics",
  "price": { "$gt": 20000 }
});

// OP3: find() – retrieve all Groceries expiring before 2025-01-01
db.products.find({
  "category": "Groceries",
  "expiry_date": { "$lt": "2025-01-01" }
});

// OP4: updateOne() – add a "discount_percent" field to a specific product (e.g., MNG_E101)
db.products.updateOne(
  { "product_id": "MNG_E101" },
  { "$set": { "discount_percent": 10 } }
);

// OP5: createIndex() – create an index on the category field and explain why
db.products.createIndex({ "category": 1 });
/* 
Explanation: Creating an index on the "category" field significantly improves query performance 
for filtering and sorting products by their category. Without an index, MongoDB would have to 
perform a full collection scan (scanning every document) to find matching items. 
Given that categories are a primary way users browse the catalog, this index is essential 
for scalability.
*/
