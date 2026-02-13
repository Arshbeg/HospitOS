<#
.SYNOPSIS
    Script de maintenance préventive pour le serveur DPI (Dossier Patient).
.DESCRIPTION
    Vérifie l'espace disque, le statut des services critiques et la connectivité réseau.
    Simule une alerte si un problème est détecté.
#>

Clear-Host
Write-Host "--- DIAGNOSTIC SERVEUR DPI (HospitOS) ---" -ForegroundColor Cyan
Write-Host "Date du rapport : $(Get-Date)"
Write-Host "----------------------------------------`n"

# 1. VÉRIFICATION ESPACE DISQUE (Alerte si < 10 Go libre)
$disk = Get-Volume -DriveLetter C
$freeSpaceGB = [math]::Round($disk.SizeRemaining / 1GB, 2)

if ($freeSpaceGB -lt 10) {
    Write-Host "[ALERTE] Espace Disque Critique : Seulement $freeSpaceGB Go libres !" -ForegroundColor Red
} else {
    Write-Host "[OK] Espace Disque : $freeSpaceGB Go libres (Suffisant)" -ForegroundColor Green
}

# 2. VÉRIFICATION DU SERVICE (Simulation : On vérifie le 'Spouleur d'impression')
# Dans la réalité, on vérifierait 'OracleService' ou 'Tomcat'.
$serviceName = "Spooler" 
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

if ($service.Status -eq 'Running') {
    Write-Host "[OK] Service Applicatif ($serviceName) : EN LIGNE" -ForegroundColor Green
} else {
    Write-Host "[ERREUR] Le service $serviceName est ARRÊTÉ !" -ForegroundColor Red
    # Tentative de redémarrage automatique (Self-Healing)
    Write-Host "   > Tentative de redémarrage..." -ForegroundColor Yellow
    # Start-Service -Name $serviceName  <-- Commenté pour sécurité
}

# 3. VÉRIFICATION RÉSEAU (Ping de la passerelle / Internet)
$ping = Test-Connection -ComputerName "google.com" -Count 1 -Quiet

if ($ping) {
    Write-Host "[OK] Connectivité Réseau : FONCTIONNELLE" -ForegroundColor Green
} else {
    Write-Host "[ERREUR] Pas de connexion réseau !" -ForegroundColor Red
}

Write-Host "`n----------------------------------------"
Write-Host "Fin du diagnostic."