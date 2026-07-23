-- ============================================
-- DATABASE: hospital_db - 27 TABLES FIXED ORDER
-- ============================================
CREATE DATABASE hospital_db;
USE hospital_db;

-- 1. patients
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_code VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    date_of_birth DATE NOT NULL,
    blood_group ENUM('A+','A-','B+','B-','AB+','AB-','O+','O-'),
    phone VARCHAR(10) NOT NULL UNIQUE CHECK (phone REGEXP '^[0-9]{10}$'),
    email VARCHAR(100) UNIQUE,
    marital_status ENUM('Single','Married','Divorced','Widowed'),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. patient_addresses
CREATE TABLE patient_addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    address_type ENUM('Home','Office','Temporary') NOT NULL,
    address_line1 VARCHAR(150) NOT NULL,
    address_line2 VARCHAR(150),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) DEFAULT 'India',
    pincode CHAR(6) NOT NULL,
    is_primary BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- 3. departments
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    department_code VARCHAR(20) UNIQUE,
    location VARCHAR(100) NOT NULL,
    phone_extension VARCHAR(10) UNIQUE,
    head_doctor_id INT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 4. employees
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_code VARCHAR(20) UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    dob DATE NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    department_id INT NOT NULL,
    role ENUM('Doctor','Nurse','Receptionist','Cashier','HR','Lab Technician','Pharmacist','Cleaner','Admin') NOT NULL,
    manager_id INT NULL,
    salary DECIMAL(10,2),
    hire_date DATE NOT NULL,
    status ENUM('Active','Inactive','Resigned') DEFAULT 'Active',
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);

-- 5. doctors
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_code VARCHAR(20) UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    dob DATE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    consultation_fee DECIMAL(10,2),
    consultation_duration INT DEFAULT 15,
    experience_years INT,
    qualification VARCHAR(100) NOT NULL,
    license_number VARCHAR(50) NOT NULL UNIQUE,
    department_id INT NOT NULL,
    is_department_head BOOLEAN DEFAULT FALSE,
    joining_date DATE NOT NULL,
    status ENUM('Active','Inactive') DEFAULT 'Active',
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

ALTER TABLE departments 
ADD CONSTRAINT fk_dept_head 
FOREIGN KEY (head_doctor_id) REFERENCES doctors(doctor_id) ON DELETE SET NULL;

-- 6. specializations
CREATE TABLE specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    specialization_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);

-- 7. doctor_specializations
CREATE TABLE doctor_specializations (
    doctor_specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    specialization_id INT NOT NULL,
    UNIQUE KEY uniq_doc_spec (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id)
);

-- 8. doctor_slots
CREATE TABLE doctor_slots (
    slot_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    day_of_week ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    max_patients INT,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- 9. appointments
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    slot_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    token_number INT NOT NULL,
    visit_type ENUM('New','Follow-up','Emergency') DEFAULT 'New',
    reason VARCHAR(255) NOT NULL,
    status ENUM('Scheduled','Checked-In','Completed','Cancelled','No Show') DEFAULT 'Scheduled',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (slot_id) REFERENCES doctor_slots(slot_id),
    UNIQUE KEY uniq_token (doctor_id, appointment_date, token_number)
);

-- 10. appointment_status_history
CREATE TABLE appointment_status_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    old_status ENUM('Scheduled','Checked-In','Completed','Cancelled','No Show') NOT NULL,
    new_status ENUM('Scheduled','Checked-In','Completed','Cancelled','No Show') NOT NULL,
    changed_by_employee_id INT NOT NULL,
    remarks VARCHAR(255),
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (changed_by_employee_id) REFERENCES employees(employee_id)
);

-- 11. room_types
CREATE TABLE room_types (
    room_type_id INT AUTO_INCREMENT PRIMARY KEY,
    room_type_name VARCHAR(50) NOT NULL UNIQUE,
    daily_charge DECIMAL(10,2) NOT NULL,
    description VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 12. rooms
CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(20) NOT NULL UNIQUE,
    room_type_id INT NOT NULL,
    floor_no INT NOT NULL,
    bed_count INT NOT NULL,
    status ENUM('Available','Occupied','Cleaning','Maintenance') DEFAULT 'Available',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_type_id) REFERENCES room_types(room_type_id)
);

-- 13. admissions
CREATE TABLE admissions (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    room_id INT NOT NULL,
    admission_date DATETIME NOT NULL,
    discharge_date DATETIME,
    diagnosis VARCHAR(255) NOT NULL,
    admission_status ENUM('Admitted','Discharged','Transferred') DEFAULT 'Admitted',
    remarks VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- 14. medicines
CREATE TABLE medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_name VARCHAR(100) NOT NULL,
    generic_name VARCHAR(100),
    manufacturer VARCHAR(100) NOT NULL,
    medicine_type ENUM('Tablet','Capsule','Injection','Syrup','Cream','Drops','Inhaler','Other') NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    expiry_required BOOLEAN DEFAULT TRUE,
    prescription_required BOOLEAN DEFAULT TRUE,
    status ENUM('Available','Discontinued') DEFAULT 'Available'
);

-- 15. suppliers
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    gst_number VARCHAR(20) UNIQUE,
    status ENUM('Active','Inactive') DEFAULT 'Active'
);

-- 16. medicine_inventory
CREATE TABLE medicine_inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT NOT NULL,
    supplier_id INT NOT NULL,
    batch_number VARCHAR(50) NOT NULL,
    manufacture_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    stock_quantity INT NOT NULL,
    reorder_level INT DEFAULT 20,
    purchase_price DECIMAL(10,2) NOT NULL,
    selling_price DECIMAL(10,2) NOT NULL,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- 17. purchase_orders
CREATE TABLE purchase_orders (
    purchase_order_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    medicine_id INT NOT NULL,
    order_date DATE NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    expected_delivery DATE,
    order_status ENUM('Pending','Ordered','Delivered','Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- 18. prescriptions
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    diagnosis VARCHAR(255) NOT NULL,
    notes TEXT,
    prescription_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- 19. prescription_items
CREATE TABLE prescription_items (
    prescription_item_id INT AUTO_INCREMENT PRIMARY KEY,
    prescription_id INT NOT NULL,
    medicine_id INT NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    frequency VARCHAR(50) NOT NULL,
    duration_days INT NOT NULL,
    instructions VARCHAR(255),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- 20. emergency_cases
CREATE TABLE emergency_cases (
    emergency_case_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    arrival_time DATETIME NOT NULL,
    brought_by ENUM('Self','Relative','Police','Ambulance','Other') DEFAULT 'Self',
    emergency_type ENUM('Accident','Heart Attack','Stroke','Burn','Poisoning','Pregnancy','Fever','Allergy','Other') NOT NULL,
    severity_level ENUM('Low','Medium','High','Critical') NOT NULL,
    treatment_status ENUM('Under Treatment','Stable','Discharged','Referred','Deceased') DEFAULT 'Under Treatment',
    remarks VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- 21. bills
CREATE TABLE bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    bill_type ENUM('OPD','IPD','Emergency') NOT NULL,
    appointment_id INT NULL,
    admission_id INT NULL,
    emergency_case_id INT NULL,
    bill_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(12,2),
    bill_status ENUM('Pending','Paid','Partially Paid') DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id) ON DELETE SET NULL,
    FOREIGN KEY (emergency_case_id) REFERENCES emergency_cases(emergency_case_id) ON DELETE SET NULL
);

-- 22. bill_items
CREATE TABLE bill_items (
    bill_item_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    item_type ENUM('Consultation','Room','Medicine','Lab Test','Surgery','Nursing','Emergency','Other') NOT NULL,
    item_name VARCHAR(150) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id)
);

-- 23. payments
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('Cash','Card','UPI','Net Banking','Cheque','Insurance') NOT NULL,
    amount_paid DECIMAL(12,2) NOT NULL,
    transaction_reference VARCHAR(100) UNIQUE,
    payment_status ENUM('Success','Pending','Failed','Refunded') DEFAULT 'Success',
    received_by_employee_id INT NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id),
    FOREIGN KEY (received_by_employee_id) REFERENCES employees(employee_id)
);

-- 24. patient_insurance
CREATE TABLE patient_insurance (
    insurance_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    insurance_company VARCHAR(100) NOT NULL,
    policy_number VARCHAR(50) NOT NULL UNIQUE,
    coverage_amount DECIMAL(12,2) NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL,
    insurance_status ENUM('Active','Expired','Cancelled') DEFAULT 'Active',
    claim_status ENUM('Pending','Approved','Rejected') DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- 25. blood_bank
CREATE TABLE blood_bank (
    blood_unit_id INT AUTO_INCREMENT PRIMARY KEY,
    blood_group ENUM('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
    donor_name VARCHAR(100) NOT NULL,
    donor_phone VARCHAR(15) NOT NULL,
    collection_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    quantity_ml INT NOT NULL,
    status ENUM('Available','Reserved','Used','Expired') DEFAULT 'Available'
);

-- 26. patient_feedback
CREATE TABLE patient_feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    feedback_type ENUM('Doctor','Hospital','Staff','Room') NOT NULL,
    doctor_id INT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    feedback_text TEXT,
    feedback_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- 27. employee_leaves
CREATE TABLE employee_leaves (
    leave_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    leave_type ENUM('Casual','Sick','Earned','Maternity','Paternity','Emergency','Without Pay') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_days INT NOT NULL,
    leave_status ENUM('Pending','Approved','Rejected','Cancelled') DEFAULT 'Pending',
    approved_by INT,
    reason VARCHAR(255),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (approved_by) REFERENCES employees(employee_id)
);