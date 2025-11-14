-- Drop the database if it exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'finalProject')
BEGIN
    ALTER DATABASE finalProject SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE finalProject;
END
GO

CREATE DATABASE finalProject 
go
USE finalProject 
go
-- Ambulances (formerly vehicles)
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_ambulance_driver_id')
    ALTER TABLE ambulance DROP CONSTRAINT fk_ambulance_driver_id;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_ambulances_driver_id')
    ALTER TABLE ambulances DROP CONSTRAINT fk_ambulances_driver_id;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_ambulances_pickup_location')
    ALTER TABLE ambulances DROP CONSTRAINT fk_ambulances_pickup_location;

-- Visits
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_visits_driver_id')
    ALTER TABLE visits DROP CONSTRAINT fk_visits_driver_id;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_visits_doctor_id')
    ALTER TABLE visits DROP CONSTRAINT fk_visits_doctor_id;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_visits_hospital_id')
    ALTER TABLE visits DROP CONSTRAINT fk_visits_hospital_id;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_visits_pickup_location')
    ALTER TABLE visits DROP CONSTRAINT fk_visits_pickup_location;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_visits_patient_id')
    ALTER TABLE visits DROP CONSTRAINT fk_visits_patient_id;

-- Doctors
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_doctors_hospital_id')
    ALTER TABLE doctors DROP CONSTRAINT fk_doctors_hospital_id;

-- Doctor ER Visit Bridge
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_doctor_er_visit_doctor_id')
    ALTER TABLE doctor_er_visit DROP CONSTRAINT fk_doctor_er_visit_doctor_id;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_doctor_er_visit_visit_id')
    ALTER TABLE doctor_er_visit DROP CONSTRAINT fk_doctor_er_visit_visit_id;

-- Possibly old doctors_patients table (legacy)
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_doctor_patient_doctor_id')
    ALTER TABLE doctors_patients DROP CONSTRAINT fk_doctor_patient_doctor_id;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_doctor_patient_patient_id')
    ALTER TABLE doctors_patients DROP CONSTRAINT fk_doctor_patient_patient_id;

-- EMT Visits
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_emt_visits_emt_visits_emt_id')
    ALTER TABLE emts_visits DROP CONSTRAINT fk_emt_visits_emt_visits_emt_id;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_emt_visits_emt_visits_visit_id')
    ALTER TABLE emts_visits DROP CONSTRAINT fk_emt_visits_emt_visits_visit_id;

-- Drop Bridge Tables First
DROP TABLE IF EXISTS doctor_er_visit;
DROP TABLE IF EXISTS doctors_patients;
DROP TABLE IF EXISTS emts_visits;

-- Drop Core Tables in Dependency-Safe Order
DROP TABLE IF EXISTS ambulances;
DROP TABLE IF EXISTS visits;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS emts;
DROP TABLE IF EXISTS drivers;
DROP TABLE IF EXISTS hospitals;
DROP TABLE IF EXISTS locations;

CREATE TABLE hospitals (
    hospital_id INT IDENTITY NOT NULL,
    hospital_name VARCHAR(50) NOT NULL,
    hospital_street VARCHAR(75) NOT NULL,
    hospital_city VARCHAR(50) NOT NULL,
    hospital_state VARCHAR(2) NOT NULL,
    hospital_zip INT NOT NULL,
    CONSTRAINT pk_hospitals_hospital_id PRIMARY KEY (hospital_id)
);

CREATE TABLE locations (
    location_id INT IDENTITY NOT NULL,
    location_street VARCHAR(100) NOT NULL,
    location_city VARCHAR(50) NOT NULL,
    location_state VARCHAR(2) NOT NULL,
    location_zip INT NOT NULL,
    CONSTRAINT pk_locations_location_id PRIMARY KEY (location_id)
);

CREATE TABLE drivers (
    driver_id INT IDENTITY NOT NULL,
    driver_firstname VARCHAR(50) NOT NULL,
    driver_lastname VARCHAR(50) NOT NULL,
    driver_email VARCHAR(50) NOT NULL,
    driver_hire_date DATE NOT NULL,
    CONSTRAINT pk_drivers_driver_id PRIMARY KEY (driver_id),
    CONSTRAINT u_drivers_driver_email UNIQUE (driver_email)
);

CREATE TABLE ambulances (
    vehicle_vin VARCHAR(8) NOT NULL,
    vehicle_make VARCHAR(30) NOT NULL,
    vehicle_model VARCHAR(30) NOT NULL,
    vehicle_driver_id INT NOT NULL,
    vehicle_pickup_location INT NOT NULL,
    CONSTRAINT pk_ambulances_vehicle_vin PRIMARY KEY (vehicle_vin)
);

CREATE TABLE patients (
    patient_id INT IDENTITY NOT NULL,
    patient_firstname VARCHAR(50) NOT NULL,
    patient_lastname VARCHAR(50) NOT NULL,
    patient_email VARCHAR(50) NOT NULL,
    CONSTRAINT pk_patients_patient_id PRIMARY KEY (patient_id),
    CONSTRAINT u_patients_patient_email UNIQUE (patient_email)
);

CREATE TABLE doctors (
    doctor_id INT IDENTITY NOT NULL,
    doctor_firstname VARCHAR(50) NOT NULL,
    doctor_lastname VARCHAR(50) NOT NULL,
    doctor_email VARCHAR(50) NOT NULL,
    doctor_hire_date DATE NOT NULL,
    doctor_department VARCHAR(50) NOT NULL,
    doctor_hospital_id INT NOT NULL,
    CONSTRAINT pk_doctors_doctor_id PRIMARY KEY (doctor_id),
    CONSTRAINT u_doctors_doctor_email UNIQUE (doctor_email)
);

CREATE TABLE visits (
    visit_id INT IDENTITY NOT NULL,
    visit_date DATETIME NOT NULL,
    visit_reason VARCHAR(100) NOT NULL,
    visit_notes VARCHAR(250) NULL,
    visit_driver_id INT NOT NULL,
    visit_doctor_id INT NOT NULL,
    visit_hospital_id INT NOT NULL,
    visit_pickup_location INT NOT NULL,
    visit_patient_id INT NOT NULL,
    CONSTRAINT pk_visits_visit_id PRIMARY KEY (visit_id)
);

CREATE TABLE doctors_patients (
    doctor_patient_id INT IDENTITY NOT NULL,
    doctor_patient_doctor_id INT NOT NULL,
    doctor_patient_patient_id INT NOT NULL,
    CONSTRAINT pk_doctors_patients_doctor_patient_id PRIMARY KEY (doctor_patient_id)
);

CREATE TABLE emts (
    emt_id INT IDENTITY NOT NULL,
    emt_firstname VARCHAR(50) NOT NULL,
    emt_lastname VARCHAR(50) NOT NULL,
    emt_email VARCHAR(50) NOT NULL,
    emt_hire_date DATE NOT NULL,
    CONSTRAINT pk_emts_emt_id PRIMARY KEY (emt_id),
    CONSTRAINT u_emts_emt_email UNIQUE (emt_email)
);

CREATE TABLE emts_visits (
    emt_visit_id INT IDENTITY NOT NULL,
    emt_visit_emt_id INT NOT NULL,
    emt_visit_visit_id INT NOT NULL,
    CONSTRAINT pk_emts_visits_emt_visit_id PRIMARY KEY (emt_visit_id)
);

-- Ambulances (formerly vehicles)
ALTER TABLE ambulances 
ADD CONSTRAINT fk_ambulance_driver_id FOREIGN KEY (vehicle_driver_id) REFERENCES drivers(driver_id),
    CONSTRAINT fk_ambulance_pickup_location FOREIGN KEY (vehicle_pickup_location) REFERENCES locations(location_id);

-- Visits
ALTER TABLE visits 
ADD CONSTRAINT fk_visits_driver_id FOREIGN KEY (visit_driver_id) REFERENCES drivers(driver_id),
    CONSTRAINT fk_visits_doctor_id FOREIGN KEY (visit_doctor_id) REFERENCES doctors(doctor_id),
    CONSTRAINT fk_visits_hospital_id FOREIGN KEY (visit_hospital_id) REFERENCES hospitals(hospital_id),
    CONSTRAINT fk_visits_pickup_location FOREIGN KEY (visit_pickup_location) REFERENCES locations(location_id),
    CONSTRAINT fk_visits_patient_id FOREIGN KEY (visit_patient_id) REFERENCES patients(patient_id);

-- Doctors
ALTER TABLE doctors 
ADD CONSTRAINT fk_doctors_hospital_id FOREIGN KEY (doctor_hospital_id) REFERENCES hospitals(hospital_id);

-- Doctors_Patients bridge table
ALTER TABLE doctors_patients 
ADD CONSTRAINT fk_doctor_patient_doctor_id FOREIGN KEY (doctor_patient_doctor_id) REFERENCES doctors(doctor_id),
    CONSTRAINT fk_doctor_patient_patient_id FOREIGN KEY (doctor_patient_patient_id) REFERENCES patients(patient_id);

-- EMTs_Visits bridge table
ALTER TABLE emts_visits 
ADD CONSTRAINT fk_emt_visits_emt_visits_emt_id FOREIGN KEY (emt_visit_emt_id) REFERENCES emts(emt_id),
    CONSTRAINT fk_emt_visits_emt_visits_visit_id FOREIGN KEY (emt_visit_visit_id) REFERENCES visits(visit_id);


 