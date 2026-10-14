# portefeuille-data-freelance
portfolio regroupant mes projet de nettoyage de donnees (SQL) et de business intelligence (Excel)

Bienvenue sur mon portfolio ! Je suis Consultant Data Freelance, spécialisé dans l'assainissement de bases de données massives (SQL) et la conception d'outils d'aide à la décision (Excel / Power BI).

---

## 🪙 Projet 1 : Optimisation, Nettoyage et Normalisation d'une Base E-Commerce (50 000 transactions)

### 📌 1. Le Défi Business (Contexte Client)
Un client opérant dans le secteur du e-commerce disposait d'un export CRM totalement corrompu, rendant le pilotage financier et les campagnes marketing impossibles :
- **Doublons massifs :** Plus de 35% de lignes dupliquées étouffaient la base de données.
- **Données financières inexploitables :** La colonne des montants était stockée au format texte (`VARCHAR`) et polluée par des symboles "€", des espaces, des virgules à la française, ainsi que des mentions textuelles brutes comme `"gratuit"`.
- **Anarchie structurelle :** Les numéros de téléphone et les dates d'inscription présentaient des formats hétérogènes (points, slashs, tirets, textes `"inconnu"`).

### 🛠️ 2. Ma Solution Technique (PostgreSQL)
J'ai conçu et exécuté un script d'assainissement rigoureux en SQL (PostgreSQL) pour restructurer la base :
- **Dédoublonnage physique :** Utilisation des identifiants physiques de lignes (`ctid`) pour purger la table des doublons parfaits.
- **Désinfection financière :** Élimination des caractères parasites par expressions régulières (`REGEXP_REPLACE`), conversion des séparateurs et mutation de la colonne en type numérique strict (`NUMERIC(10,2)`).
- **Standardisation des profils :** Application des fonctions `INITCAP`, `LOWER` et `TRIM` pour harmoniser la casse des identités, et réparation des dates via l'analyse de masques textuels (`TO_DATE`, `TO_CHAR`).

### 📊 3. Impact Business & Livrable BI (Excel)
Grâce à ce traitement, la base de données a été stabilisée à **32 281 enregistrements 100% qualifiés**. 

J'ai ensuite connecté ces données saines à Excel pour concevoir un **Tableau de Bord de Pilotage des Ventes** dynamique et interactif offrant au client une visibilité parfaite sur ses indicateurs de performance (KPIs) :
- **Chiffre d'Affaires Global net :** `7 002 543,30 €`
- **Volume réel de commandes :** `32 281`
- **Panier Moyen par client :** `216,92 €`
- **Interactivité :** Intégration de segments dynamiques et de graphiques analytiques épurés.

---

### 📂 Fichiers inclus dans ce projet :
*   [`nettoyage_ecommerce.sql`](./nettoyage_ecommerce.sql) : Mon script SQL complet contenant l'ensemble des requêtes d'assainissement de la base.
*   [`generateur.py`](./generateur.py) : Le script Python de simulation ayant servi à injecter les anomalies de départ.

---
*Besoin d'un expert pour auditer, nettoyer ou valoriser vos données d'entreprise ? Contactez-moi !*
