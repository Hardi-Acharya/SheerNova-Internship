Hospital Management Database - README

Project Overview

This project is a Hospital Management Database developed using MySQL. It manages patient records, doctors, appointments, admissions, medicines, billing, payments, inventory, emergency cases, and many other hospital operations. The project also demonstrates normalization, constraints, triggers, procedures, transactions, indexing, security, backup, and recovery.

1. Purpose of Each Table

patients – Stores patient personal information.
patient_addresses – Stores patient address details.
patient_insurance – Stores patient insurance information.
patient_feedback – Stores feedback given by patients.
departments – Stores hospital department details.
specializations – Stores doctor specialization names.
doctor_specializations – Links doctors with their specializations.
doctors – Stores doctor information.
doctor_slots – Stores available appointment time slots for doctors.
employees – Stores hospital employee information.
employee_leaves – Stores employee leave records.
rooms – Stores hospital room information.
room_types – Stores different room categories.
admissions – Stores patient admission records.
appointments – Stores patient appointment bookings.
appointment_status_history – Stores appointment status changes.
medical_records – Stores patient diagnosis and treatment details.
medicines – Stores medicine details.
medicine_inventory – Stores available medicine stock.
prescriptions – Stores prescription details.
prescription_items – Stores medicines included in each prescription.
suppliers – Stores supplier information.
purchase_orders – Stores medicine purchase orders.
bills – Stores patient bill information.
bill_items – Stores individual items included in a bill.
payments – Stores payment details.
blood_bank – Stores blood group and blood stock details.
emergency_cases – Stores emergency patient records.

View

vw_today_appointments – Displays all appointments scheduled for today.

2. Delete Behaviour Used (Task 5)

To protect important hospital data, the following delete rules were used.

ON DELETE RESTRICT

This rule prevents deleting a parent record when related child records already exist.

Reason
Doctors cannot be deleted if appointments exist.
Patients cannot be deleted if related medical records or bills exist.
Departments cannot be deleted while doctors are assigned to them.
This prevents accidental data loss and keeps the database consistent.

ON DELETE SET NULL

This rule keeps the child record but changes the foreign key value to NULL when the parent record is deleted.

Reason
Historical records remain available even if the related parent record no longer exists.

These delete rules help maintain data integrity and avoid invalid relationships.

3. What Surprised Me Most in Task 10

The most surprising part was seeing how two users can work on the database at the same time.

During concurrency testing, two users tried to access the same data simultaneously. Without proper locking, this could lead to problems such as double booking a doctor or updating the same record at the same time.

What I Learned

By using START TRANSACTION and SELECT FOR UPDATE, MySQL locks the required row until the transaction finishes. This prevents data conflicts and ensures that only one user updates the record at a time.

This task helped me understand the importance of transactions, row locking, and concurrency control in real hospital management systems.

Project Files

File: 01_hospital_schema.sql        Description: Creates all tables, keys and constraints
File: 02_sample_data.sql            Description: Inserts sample records
File: 03_database_logic.sql         Description: Triggers, procedures, functions and views
File: 04_concurrency_testing.sql    Description: Transaction and concurrency testing
File: 05_report_queries_and_answers.sql Description: SQL queries and reports
File: 06_performance_test.sql       Description: Index and performance testing
File: 07_security_testing.sql       Description: Users and permissions
File: 08_backup_recovery.sql        Description: Backup and recovery testing
File: 09_README.md                  Description: Project documentation
File: er_diagram_hospital_db.png    Description: Entity Relationship Diagram

Conclusion

This Hospital Management Database project improved my understanding of database design, normalization, relationships, constraints, transactions, concurrency control, indexing, security, backup, and recovery in MySQL. It demonstrates how a real hospital database can safely manage multiple users while maintaining accurate and reliable data.