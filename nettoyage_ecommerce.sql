-- =====================================================================
-- PROJET 1 : NETTOYAGE ET NORMALISATION D'UNE BASE E-COMMERCE
-- Script SQL d'assainissement (PostgreSQL)
-- =====================================================================

-- 1. Suppression des doublons physiques via l'analyse des lignes (ctid)
DELETE FROM public.ecommerce_data_dirty
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM public.ecommerce_data_dirty
    GROUP BY id_client, nom_complet, email, telephone, montant_achat, date_inscription
);

-- 2. Normalisation de la casse textuelle et suppression des espaces inutiles
UPDATE public.ecommerce_data_dirty
SET 
    nom_complet = INITCAP(TRIM(nom_complet)),
    email = LOWER(TRIM(email));

-- 3. Désinfection de la colonne financière et conversion en NUMERIC
UPDATE public.ecommerce_data_dirty
SET montant_achat = CASE 
    WHEN TRIM(montant_achat) = '' OR montant_achat IS NULL OR LOWER(TRIM(montant_achat)) IN ('null', 'gratuit') THEN '0'
    ELSE REPLACE(REGEXP_REPLACE(montant_achat, '[^0-9,.]', '', 'g'), ',', '.')
END;

ALTER TABLE public.ecommerce_data_dirty 
ALTER COLUMN montant_achat TYPE numeric(10,2) USING montant_achat::numeric;

-- 4. Réparation structurelle et harmonisation des dates
UPDATE public.ecommerce_data_dirty
SET date_inscription = CASE 
    WHEN TRIM(date_inscription) = '' OR date_inscription IS NULL THEN NULL
    WHEN date_inscription ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN date_inscription
    WHEN date_inscription ~ '^[0-9]{4}/[0-9]{2}/[0-9]{2}$' THEN TO_CHAR(TO_DATE(date_inscription, 'YYYY/MM/DD'), 'YYYY-MM-DD')
    WHEN date_inscription ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN TO_CHAR(TO_DATE(date_inscription, 'DD/MM/YYYY'), 'YYYY-MM-DD')
    WHEN date_inscription ~ '^[0-9]{2}-[0-9]{2}-[0-9]{4}$' THEN TO_CHAR(TO_DATE(date_inscription, 'DD-MM-YYYY'), 'YYYY-MM-DD')
    ELSE NULL 
END;

ALTER TABLE public.ecommerce_data_dirty 
ALTER COLUMN date_inscription TYPE DATE USING date_inscription::DATE;
