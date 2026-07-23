Hospital Management Database - README

Project Overview

This project is a Hospital Management Database developed using MySQL. It manages patient information, doctor details, appointments, medicines, billing, payments, and other hospital records. The database also uses constraints, triggers, transactions, indexing, security, backup, and recovery features to maintain data accuracy and reliability.

1. Purpose of Each Table

patients – Stores patient personal information.
patient_addresses – Stores patient address details.
departments – Stores hospital department information.
doctors – Stores doctor details and department information.
employees – Stores hospital staff information.
rooms – Stores room details for patient admission.
appointments – Stores appointment records between patients and doctors.
medical_records – Stores diagnosis, treatment, and medical history.
medicines – Stores medicine information.
prescriptions – Stores medicines prescribed to patients.
inventory – Stores available medicine stock.
suppliers – Stores medicine supplier details.
purchases – Stores medicine purchase records.
billing – Stores patient billing information.
payments – Stores payment details.
appointment_status_history – Stores appointment status change history.

2. Delete Behaviour Used (Task 5)

To protect important hospital data, the following delete rules were used:

ON DELETE RESTRICT
This rule prevents deleting a parent record if related child records exist.

Reason:
A doctor should not be deleted if appointments exist.
A patient should not be deleted if medical records or bills exist.
A department should not be deleted if doctors are assigned to it.
This helps prevent accidental data loss.

ON DELETE SET NULL
This rule keeps the child record but sets the foreign key to NULL when the parent record is deleted.

Reason:
If a related record is removed, the existing record is still useful for history and reporting.

These delete rules help maintain data integrity and prevent invalid relationships.

3. What Surprised Me Most in Task 10

The most surprising part was seeing how two users can work on the database at the same time.

During concurrency testing, two users tried to access the same data simultaneously. Without proper locking, this could cause problems such as double booking or incorrect stock updates.

What I Learned
By using transactions START TRANSACTION and row locking SELECT FOR UPDATE, MySQL allows only one user to update the data at a time. The second user must wait until the first transaction is completed.

This taught me the importance of transactions, locking, and concurrency control in real hospital management systems.

Project Files

File: 01_hospital_schema.sql        Description: Creates all database tables and relationships
File: 02_sample_data.sql            Description: Inserts sample data
File: 03_database_logic.sql         Description: Procedures, functions and triggers
File: 04_concurrency_testing.sql    Description: Transaction and concurrency testing
File: 05_report_queries_and_answers.sql Description: Required SQL queries and reports
File: 06_performance_test.sql       Description: Index and performance testing
File: 07_security_testing.sql       Description: Users, roles and permissions
File: 08_backup_recovery.sql        Description: Database backup and recovery
File: 09_README.md                  Description: Project documentation

Conclusion

This project helped me understand database design, normalization, relationships, transactions, concurrency control, indexing, security, backup, and recovery in MySQL. It also showed how a real hospital database can safely manage multiple users and maintain accurate data.