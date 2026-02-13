-- Table 1 IDENTITÉ VIGILANCE (patient details)
CREATE TABLE Patient_IPP (
    IPP INT PRIMARY KEY,        -- unique Hospital ID (e.g., 8000123)
    Nom_Naissance VARCHAR(50),     -- birthname 
    Nom_Usage VARCHAR(50),         -- usedname
    Prenom VARCHAR(50),            -- firstname
    Date_Naissance DATE,           -- DOB
    Sexe CHAR(1),                  -- gen
    INS_Nir VARCHAR(15) UNIQUE     -- ssn(15 digits)
);

-- Table 2 MOUVEMENTS & SÉJOURS (visit details)
CREATE TABLE Sejour_IEP (
    IEP INT PRIMARY KEY,        -- visit ID
    IPP INT,                    -- Link back to the patient
    Date_Entree DATETIME,          -- admission
    Date_Sortie DATETIME,          -- discharge (NULL if still in hospital)
    UF_Actuelle VARCHAR(50),       -- current Ward (e.g., 'URGENCES')
    Mode_Entree VARCHAR(20),       -- 'DOMICILE', 'SAMU', 'TRANSFERT'
    FOREIGN KEY (IPP) REFERENCES Patient_IPP(IPP)
);

-- table 3 ACTES & EXAMENS (what happened?)
CREATE TABLE Examens (
    Examen_ID INT PRIMARY KEY,
    IEP INT,
    Type_Examen VARCHAR(50),       -- 'SANG', 'RADIO', 'SCANNER'
    Date_Realisation DATETIME,
    Resultat TEXT,                 -- 'Normal', 'Fracture', etc.
    FOREIGN KEY (IEP) REFERENCES Sejour_IEP(IEP)
);