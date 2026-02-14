## HospitOS: Tool Suite for Gestion du Dossier Patient Informatisé (DPI)

> **Technical Project** created as part of an application for the **Assistant Applicatif (DPI)** position.
> This project is made for educational purposes to simulates the technical environment of a French University Hospital (**CHU** - *Centre Hospitalier Universitaire*).

---

### RGPD / Privacy Warning
All data used in this project (patient names, **IPP**, **IEP**, medical results) are **100% fictional** and generated using synthetic data tools (Mockaroo). No real health data has been used, in strict compliance with the **RGPD** (General Data Protection Regulation).

---

### Project Architecture

This repository is structured around the three core pillars of an Assistant Applicatif's role within a Hospital Information System (**SIH**):

### 1. Database & Identito-Vigilance (`/database`)
Managing patient flows according to French **SIH** standards.
* **Relational Schema:** Strict modeling separating the **IPP** (*Identifiant Permanent du Patient* / Permanent Patient ID) and the **IEP** (*Identifiant Écoute du Patient* / Visit ID).
* **Test Data:** A simulated dataset of 1,000 patients and hospital stays.
* **Business Queries:** SQL scripts for activity monitoring (e.g., Bed occupancy rate by **UF** - *Unité Fonctionnelle*, potential duplicate detection).

### 2. Interoperability & HL7 Flows (`/interoperability`)
Simulating the reception of laboratory results (HPRIM/HL7) into the **DPI**.
* **Python Script (`hl7_listener.py`):** A parser capable of reading and formatting a raw `ORU^R01` message.
* **Automatic Extraction:** Identifies the patient (PID segment), the specific stay (PV1 segment), and extracts the clinical results (OBX segment).

### 3. MCO (Maintien en Condition Opérationnelle) (`scripts`)
Administration tools to guarantee service availability and assist Application Managers (RA).
* **PowerShell Script (`check_health.ps1`):** Automated monitoring of disk space, critical application services (simulated), and network connectivity.
* **Objective:** Incident prevention and rapid diagnostics for Level 1 & 2 Support.

---
### How to use this project

1. **Database:** Import the `.sql` scripts into any relational database management system (Oracle, SQL Server, SQLite).
2. **Python:** Run `python 02_Interoperability/hl7_listener.py` to test the HL7 parsing logic in the terminal.
3. **PowerShell:** Execute `.\03_Scripts\check_health.ps1` to run an immediate system diagnostic.

---

*Project created by ARSH BEG - 2026*