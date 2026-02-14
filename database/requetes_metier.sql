-- 1. PILOTAGE CAPACITAIRE
SELECT 
    UF_Actuelle AS Service, 
    COUNT(IEP) AS Nombre_Sejours
FROM Sejour_IEP
GROUP BY UF_Actuelle
ORDER BY Nombre_Sejours DESC;

-- 2. IDENTITO-VIGILANCE 
SELECT 
    IPP, 
    Nom_Usage, 
    Prenom, 
    Date_Naissance
FROM Patient_IPP
WHERE INS_Nir IS NULL OR INS_Nir = ''
ORDER BY Date_Naissance ASC;

-- 3. ANALYSE DES URGENCES 
SELECT 
    p.IPP, 
    p.Nom_Usage, 
    p.Prenom, 
    s.Date_Entree, 
    s.UF_Actuelle
FROM Patient_IPP p
JOIN Sejour_IEP s ON p.IPP = s.IPP
WHERE s.Mode_Entree = 'SAMU'
ORDER BY s.Date_Entree DESC
LIMIT 15;

-- 4. SUIVI PATIENT
SELECT 
    p.IPP, 
    p.Nom_Usage, 
    p.Prenom, 
    COUNT(s.IEP) AS Nombre_De_Sejours
FROM Patient_IPP p
JOIN Sejour_IEP s ON p.IPP = s.IPP
GROUP BY p.IPP, p.Nom_Usage, p.Prenom
HAVING COUNT(s.IEP) > 1
ORDER BY Nombre_De_Sejours DESC;

-- 5. FACTURATION (GAM/PIM)
SELECT 
    IEP, 
    IPP, 
    UF_Actuelle, 
    Date_Entree, 
    Date_Sortie
FROM Sejour_IEP
WHERE Date_Sortie IS NOT NULL
ORDER BY Date_Sortie DESC
LIMIT 20;