import datetime
# SIMULATEUR D'INTERFACE LABORATOIRE (HPRIM/HL7)
def parse_hl7_message(raw_message):
    """
    Lit un message HL7 brut et l'affiche proprement pour le dossier patient.
    """
    print(f"\n[{datetime.datetime.now()}] MESSAGE REÇU DU LABORATOIRE...")
    print("-" * 50)
    
    # Séparer le message en segments (lignes)
    segments = raw_message.strip().split('\n')
    
    patient_data = {}
    visit_data = {}
    observation_data = {}

    for segment in segments:
        fields = segment.split('|')
        
        # SPatient Identification
        if segment.startswith("PID"):
            #IPP
            patient_data['IPP'] = fields[3].split('^')[0]
            
            #nom^prenom
            raw_name = fields[5]
            family_name, first_name = raw_name.split('^')[:2]
            patient_data['Nom'] = family_name
            patient_data['Prenom'] = first_name
            
        # pateint visit
        if segment.startswith("PV1"):
            #IEP
            visit_data['IEP'] = fields[19]
            #Service 
            visit_data['Service'] = fields[3]

        # Observation/Resultat
        if segment.startswith("OBX"):
            # exam type
            observation_data['Type'] = fields[3].split('^')[1]
            #result value
            observation_data['Valeur'] = fields[5]
            #result unit
            observation_data['Unité'] = fields[6]

    # for user to see
    print(f"PATIENT: {patient_data.get('Nom')} {patient_data.get('Prenom')}")
    print(f"IPP: {patient_data.get('IPP')} | IEP: {visit_data.get('IEP')}")
    print(f"SERVICE: {visit_data.get('Service')}")
    print(f"RÉSULTAT LABO ({observation_data.get('Type')}):")
    print(f" {observation_data.get('Valeur')} {observation_data.get('Unité')}")
    print("-" * 50)
    print("Intégration dans le Dossier Patient : SUCCÈS")

# DONNÉES DE TEST (Message HL7 fictif) 
# Contexte : Jean DUPONT (IPP 8000001) aux Urgences fait une prise de sang. 
#HARDCODED SAMPLE
hl7_sample = """
MSH|^~\&|LABO|CHULILLE|DPI|CHULILLE|202310271030||ORU^R01|MSG0001|P|2.5
PID|1||8000001^^^CHULILLE||DUPONT^JEAN||19800101|M
PV1|1|U|URGENCES^^^CHULILLE||||||||||||||||8000001
OBX|1|NM|15000^GLYCEMIE_JEUN||1.26|g/L|0.70-1.10|H|||F
"""
if __name__ == "__main__":
    parse_hl7_message(hl7_sample)