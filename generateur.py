import csv # pour la gereration de notre fichier csv
import random # pour la generation au hasard les donnees de notre fichier csv

# Génération de 50 000 lignes de données clients e-commerce sales
with open('ecommerce_data_dirty.csv', mode='w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['id_client', 'nom_complet', 'email', 'telephone', 'montant_achat', 'date_inscription'])
    
    emails_generes = []
    
    for i in range(1, 50001):
        # 1. Génération de données de base sales
        nom = random.choice(['  jean dupont  ', 'MARIE CURIE', 'pierre-yves LE GALL', 'lucas martin', '  Sophie  Dubois '])
        email = random.choice(['jean.dupont@gmail.com', 'MARIE.C@OUTLOOK.FR', 'pierre#legall@yahoo', 'lucas.martin@', 'sophie.d@gmail.com', '  spa ces@test.com '])
        tel = random.choice(['06.12.34.56.78', '+33 6 12 34 56 78', '0033612345678', '0612345678', 'inconnu', ''])
        montant = random.choice(['150.50 €', '45,99', 'NULL', '1200', '  89.90', 'gratuit'])
        date = random.choice(['2026-05-12', '12/05/2026', '12-05-2026', '2026/05/12', ''])
        
        # Injection de doublons volontaires (environ 15% de la base)
        if i % 7 == 0 and len(emails_generes) > 0:
            dup_email = random.choice(emails_generes)
            writer.writerow([random.choice([i, '']), ' DOUBLON CLIENT ', dup_email, '0600000000', '0.00', '2026-01-01'])
        else:
            emails_generes.append(email)
            writer.writerow([i, nom, email, tel, montant, date])

print("Fichier 1 'ecommerce_data_dirty.csv' généré avec succès !")