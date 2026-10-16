projet 4 : ASSAINISSEMENT ET CONVERSION D'UN DUMP APPLICATIF
script sql de nettoyage (syntaxe MySQL)


CREATE TABLE IF NOT EXISTS crm_dump_dirty (
    id_lead VARCHAR(255),
    date_contrat VARCHAR(255),
    metadata_brutes VARCHAR(255),
    score_interet VARCHAR(255)
);


select * from crm_dump_dirty;

SET SQL_SAFE_updates = 0;
delete from crm_dump_dirty 
WHERE id_lead is null or trim(id_lead) = '';

select * from crm_dump_dirty;

update crm_dump_dirty
set date_contrat = case
when trim(date_contrat) = '' or date_contrat is null then null
when date_contrat regexp '^[0-9]+$' then date(from_unixtime(date_contrat))
when date_contrat like '%/%' then str_to_date(date_contrat, '%d/%m/%y')
when date_contrat regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' then date_contrat
else null 
end;

alter table crm_dump_dirty 
rename column date_contrat to date_contact ;

UPDATE crm_dump_dirty
SET date_contact = CASE 
    -- 1. Si la case est vide ou NULL
    WHEN TRIM(date_contact) = '' OR date_contact IS NULL THEN NULL
    
    -- 2. Si c'est un Timestamp Unix (uniquement des chiffres)
    WHEN date_contact REGEXP '^[0-9]+$' THEN DATE(FROM_UNIXTIME(date_contact))
    
    -- 3. Si la date utilise des slashs (ex: 11/10/2026)
    WHEN date_contact LIKE '%/%' THEN STR_TO_DATE(date_contact, '%d/%m/%Y')
    
    -- 4. Si la date est déjà propre (ex: 2026-10-11)
    WHEN date_contact REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN date_contact
    
    ELSE NULL
END;

select * from crm_dump_dirty;

UPDATE crm_dump_dirty
SET score_interet = CASE
    -- 1. Si le score contient des lettres ou s'il est négatif, on le force à '0'
    WHEN score_interet REGEXP '[^0-9]' OR CAST(score_interet AS SIGNED) < 0 THEN '0'
    
    -- 2. Sinon, on garde la valeur numérique propre
    ELSE TRIM(score_interet)
END;

alter table crm_dump_dirty
modify column date_contact date,
modify column score_interet int;

select * from crm_dump_dirty;
