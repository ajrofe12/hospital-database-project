# Emergency Hospital Transportation Database System

- **Course:** IST 659 – Data Administration Concepts & Database Management  
- **Semester:** Spring 2025  
- **Tools/Technologies:** SQL, ER Modeling, Relational Database Design  

---

## Project Overview

This project involved designing a relational database to support an efficient Emergency Transportation System for hospitals. The goal is to streamline how hospitals track emergency calls, assign ambulances, dispatch EMTs and drivers, record patient pickup/drop-off locations, and ensure patients are directed to the nearest appropriate hospital and doctor.

The system replaces unorganized and error-prone paper-based workflows with a structured SQL database that improves coordination, reduces delay, and increases patient care accuracy during emergency events.

---

## Problem Statement

Emergency rooms operate in a chaotic and time-pressured environment. Paper-based processes make it difficult to:

- Assign ambulances, drivers, and EMTs quickly  
- Route patients to the correct hospital  
- Track pickup/drop-off times and locations  
- Assign an appropriate doctor immediately  
- Maintain clear records across many moving parts  

Because errors in emergency response can have life-threatening consequences, a centralized and reliable database is critical for accuracy, organization, and optimized resource allocation.

---

## Proposed Solution

The Emergency Transportation System database:

- Centralizes all information about drivers, EMTs, hospitals, vehicles, patients, and locations  
- Supports the assignment of a driver, EMT, ambulance, and hospital when a 911 call is logged  
- Tracks patient pickup and delivery times  
- Links each patient to the doctor assigned to their case  
- Helps hospital administrators monitor efficiency and resource usage  
- Facilitates quick access to medical records and status  

This design enhances emergency care coordination and streamlines communication between all users in the system.

---

## Users

The primary end users are hospital staff and administrators, who rely on the system to:

- Track patient movement from pickup to delivery  
- View assigned drivers, EMTs, vehicles, hospitals, and doctors  
- Monitor response times and identify inefficiencies  
- Justify staffing changes or resource demands  

---

## Schema Overview

The database includes the following entities:

### **Entities**
The database is organized into the following core entities:

- **Drivers** – Stores driver information (ID, name, contact details, hire date)
- **EMTs** – Emergency medical technicians with similar identifying attributes
- **Doctors** – Includes department and contact information
- **Patients** – Patient demographics and injury details
- **Vehicles** – Ambulance details (VIN, make, model)
- **Locations** – Pickup and drop-off site information
- **Hospitals** – Hospital address and identifying information

### **Key Relationships**
- Each **patient** is assigned a **driver** and an **EMT**
- Each patient is transported to a specific **hospital**
- Each patient has a **pickup** and **drop-off location**
- Each patient is linked to an assigned **doctor**
- **Vehicles** are associated with drivers and used during patient transport


---

## Learning Outcomes Demonstrated

- **Outcome 2:** Designed a normalized relational schema based on real operational requirements  
- **Outcome 4:** Implemented SQL for table creation, constraints, and relationship mapping  

---

## Files Included

- [Project Writeup](documents/Final Project Writeup.docx) – Full problem description & solution proposal  
- hospital_up_down.sql – SQL script for creating and dropping all tables  
- conceptual_model.png – Conceptual ER diagram  
- logical_model.png – Logical ER model  
- ER_Data_Requirements.xlsx – Full data dictionary / attribute list  
- presentation.pdf – Final project presentation slides  

