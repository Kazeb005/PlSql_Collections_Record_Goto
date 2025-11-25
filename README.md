

# 📦 Pharmacy Expiry Alert System — PL/SQL Script

This repository contains a PL/SQL implementation of a **Pharmacy Expiry Alert System** that analyzes medicine batches, checks expiry dates, and outputs critical alerts or warnings.
It is ideal for practicing **PL/SQL collections, records, associative arrays, loops, and control flow** using `GOTO` and labels.



## ✨ Features

* Uses **custom RECORD types** to represent medicines.
* Supports multiple **batches, expiry dates, and quantities** per medicine.
* Uses **VARRAYs** and **nested tables** for multi-value storage.
* Implements a dynamic inventory using an **associative array (INDEX BY)**.
* Detects:

  * **Expired batches** (immediate critical alert)
  * **Near-expiry batches** (≤ 30 days)
* Uses **GOTO** to skip unnecessary checks for expired batches.
* Prints a clean summary of critical items.



## 📁 Project Structure


/PlSql_collections_record_goto
└──/screeshot
│
├── query.sql   # Main PL/SQL script
└── README.md
                    




## 🧠 How the Script Works

1. **Custom collection types** are created to store batch numbers, expiry dates, and quantities.
2. A **record type** (`MedicineRec`) organizes all data for a medicine.
3. An **associative array** (`PharmacyInventory`) holds multiple medicines.
4. The script populates sample data for three medicines and their batches.
5. It loops through each medicine and each batch:

   * Calculates `days_left` before expiry
   * If expired → prints a **CRITICAL alert** and jumps to the next batch
   * If near expiry (≤30 days) → prints a **WARNING**
6. Finally, it prints a summary of expired batches.



## 🚀 Running the Script

### Requirements

* Oracle Database (any version with PL/SQL support)
* SQL*Plus, SQL Developer, or any Oracle-compatible IDE

### To run:

1. Open your SQL environment
2. Ensure server output is enabled:

   ```sql
   SET SERVEROUTPUT ON;
   ```
3. Execute the `.sql` file:

   ```sql
   @pharmacy_expiry_checker.sql
   ```



## 📌 Output Example


PHARMACY EXPIRY ALERT SYSTEM
Generated on: 25-NOV-2025
-------------------------------------------------------------
CRITICAL: Aspirin 75mg | Batch: ASP01 | EXPIRED 13 days ago!
WARNING: Amoxicillin 250mg | Batch B104 | Expires in 20 days
-------------------------------------------------------------
SUMMARY: 1 batch(es) are already expired.
ACTION: Remove from shelf immediately and log for disposal.
```



## 🧩 Concepts Demonstrated

| Concept                     | Purpose                                   |
| --------------------------- | ----------------------------------------- |
| **RECORD types**            | Group related fields into one structure   |
| **Nested tables & VARRAYs** | Store multiple values per record          |
| **Associative arrays**      | Flexible in-memory indexing               |
| **Date arithmetic**         | Calculate expiry days                     |
| **GOTO & labels**           | Skip remaining checks for expired batches |
| **Exception handling**      | Capture unexpected runtime errors         |





