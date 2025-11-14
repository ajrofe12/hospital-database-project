# Hospital Database Management System

- **Course:** IST 659 – Data Administrations Concepts & Database Management 
- **Semester:** Spring 2025 
- **Tools/Technologies:** SQL, ER Modeling, Relational Database Design  

---

## Project Overview

This project involved designing a Hospital Management System to digitize hospital administration records and improve accessibility for doctors, patients, and administrators. The system supports managing doctors, patients, departments, clinics, and medicines in a relational database structure.

Key goals:
- Replace paper-based records with a centralized SQL database
- Improve data access, security, and integrity
- Enable doctors and patients to query data efficiently
- Support hospital operations and medical inventory tracking

--

## Problem Statement

Hospitals often store data on paper, which makes it difficult to maintain, access, and share. This leads to inefficiency, data loss, and poor communication between departments and patients.

---

## Solution Design

A relational database was developed to manage entities including:
- **Doctor** — IDs, specialization, contact info, department  
- **Patient** — demographics, medical history, admission/discharge  
- **Clinic** — region, capacity, services  
- **Department** — heads, contact info  
- **Medicines** — stock, type, associated department  

This design enables administrators to track key hospital operations while allowing doctors and patients to access relevant information online.

---

## Schema Overview

The system contains the following core entities and relationships:
- **DOCTOR**
  - DoctorID, Doctor License Number, Name, Experience, Designation, Email ID, Phone Number
- **PATIENT**
  - PatientID, Name, Age, Address, City, Zip Code, Email, Phone Number, Patient Issue, Existing Medical Condition, Admission Date, Discharge Date
- **CLINIC**
  - ClinicID, Name, Region, City, Zip Code, Patient Capacity, URL
- **DEPARTMENT**
  - DepartmentID, Name, Department Head, Email, Phone Number 
- **MEDICINES**
  - MedicineID, Name, Quantity, Medicine Type, Medicine Department

Foreign keys connect doctors to departments, patients to doctors, and medicines to departments.

---

## Learning Outcomes Demonstrated
This project demonstrated: 
- **Outcome 2:** Creation of actionable insights through database design  
- **Outcome 4:** Use of SQL to design, query, and manage structured data  

---

## Files Included
- `Hospital_Management_System_Writeup.docx` – Full proposal and documentation  
- `hospital_up_down.sql` – SQL DDL statements for tables and relationships  
