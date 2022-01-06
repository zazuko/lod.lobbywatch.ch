CREATE OR REPLACE VIEW `v_interessenbindung_simple` AS
SELECT interessenbindung.*,
(interessenbindung.von IS NULL OR interessenbindung.von <= NOW()) AND (interessenbindung.bis IS NULL OR interessenbindung.bis > NOW()) as aktiv,
IFNULL(freigabe_datum <= NOW(), FALSE) AS published
FROM `interessenbindung`;

CREATE OR REPLACE VIEW `v_organisation_simple` AS
SELECT CONCAT_WS('; ', organisation.name_de, organisation.name_fr, organisation.name_it) AS anzeige_name,
CONCAT_WS('; ', organisation.name_de, organisation.name_fr, organisation.name_it) AS anzeige_mixed,
CONCAT_WS('; ', organisation.name_de, organisation.name_fr) AS anzeige_bimixed,
CONCAT_WS('; ', organisation.name_de, organisation.abkuerzung_de, organisation.name_fr, organisation.abkuerzung_fr, uid, LEFT(organisation.alias_namen_de, 75), LEFT(organisation.alias_namen_fr, 75)) AS searchable_name,
organisation.name_de AS anzeige_name_de,
organisation.name_fr AS anzeige_name_fr,
CONCAT_WS('; ', organisation.name_de , organisation.name_fr, organisation.name_it) AS name,
organisation.*,
IFNULL(freigabe_datum <= NOW(), FALSE) AS published
FROM `organisation`;

CREATE OR REPLACE VIEW `v_interessengruppe_simple` AS
SELECT CONCAT(interessengruppe.name) AS anzeige_name, CONCAT(interessengruppe.name) AS anzeige_name_de, CONCAT(interessengruppe.name_fr) AS anzeige_name_fr,
CONCAT_WS(' / ', interessengruppe.name, interessengruppe.name_fr) AS anzeige_name_mixed,
interessengruppe.*,
`interessengruppe`.name as name_de, `interessengruppe`.beschreibung as beschreibung_de, `interessengruppe`.alias_namen as alias_namen_de,
IFNULL(freigabe_datum <= NOW(), FALSE) AS published
FROM `interessengruppe`;

CREATE OR REPLACE VIEW `v_branche_simple` AS
SELECT CONCAT(branche.name) AS anzeige_name, CONCAT(branche.name) AS anzeige_name_de, CONCAT(branche.name_fr) AS anzeige_name_fr,
CONCAT_WS(' / ', branche.name, branche.name_fr) AS anzeige_name_mixed,
branche.*,
branche.name as name_de, branche.beschreibung as beschreibung_de, branche.angaben as angaben_de,
IFNULL(freigabe_datum <= NOW(), FALSE) AS published
FROM branche;

CREATE OR REPLACE VIEW `v_kommission` AS
SELECT CONCAT(kommission.name, ' (', kommission.abkuerzung, ')') AS anzeige_name, CONCAT(kommission.name, ' (', kommission.abkuerzung, ')') AS anzeige_name_de, CONCAT(kommission.name_fr, ' (', kommission.abkuerzung_fr, ')') AS anzeige_name_fr,
CONCAT_WS(' / ', CONCAT(kommission.name, ' (', kommission.abkuerzung, ')'), CONCAT(kommission.name_fr, ' (', kommission.abkuerzung_fr, ')')) AS anzeige_name_mixed,
kommission.*,
kommission.name as name_de, kommission.abkuerzung as abkuerzung_de, kommission.beschreibung as beschreibung_de, kommission.sachbereiche as sachbereiche_de,
IFNULL(freigabe_datum <= NOW(), FALSE) AS published
FROM kommission;

CREATE OR REPLACE VIEW `v_branche` AS
SELECT
branche.*,
branche.kommission_id as kommission1_id,
kommission.anzeige_name as kommission1,
kommission.anzeige_name_de as kommission1_de,
kommission.anzeige_name_fr as kommission1_fr,
kommission.name as kommission1_name,
kommission.name_de as kommission1_name_de,
kommission.name_fr as kommission1_name_fr,
kommission.abkuerzung as kommission1_abkuerzung,
kommission.abkuerzung_de as kommission1_abkuerzung_de,
kommission.abkuerzung_fr as kommission1_abkuerzung_fr,
kommission2.anzeige_name as kommission2,
kommission2.anzeige_name_de as kommission2_de,
kommission2.anzeige_name_fr as kommission2_fr,
kommission2.name as kommission2_name,
kommission2.name_de as kommission2_name_de,
kommission2.name_fr as kommission2_name_fr,
kommission2.abkuerzung as kommission2_abkuerzung,
kommission2.abkuerzung_de as kommission2_abkuerzung_de,
kommission2.abkuerzung_fr as kommission2_abkuerzung_fr
FROM `v_branche_simple` branche
LEFT JOIN `v_kommission` kommission
ON kommission.id = branche.kommission_id
LEFT JOIN `v_kommission` kommission2
ON kommission2.id = branche.kommission2_id
;

CREATE OR REPLACE VIEW `v_interessengruppe` AS
SELECT
interessengruppe.*,
branche.anzeige_name as branche,
branche.anzeige_name_de as branche_de,
branche.anzeige_name_fr as branche_fr,
branche.kommission_id as kommission_id,
branche.kommission_id as kommission1_id,
branche.kommission2_id as kommission2_id,
branche.kommission1 as kommission1,
branche.kommission1_de as kommission1_de,
branche.kommission1_fr as kommission1_fr,
branche.kommission1_name as kommission1_name,
branche.kommission1_name_de as kommission1_name_de,
branche.kommission1_name_fr as kommission1_name_fr,
branche.kommission1_abkuerzung as kommission1_abkuerzung,
branche.kommission1_abkuerzung_de as kommission1_abkuerzung_de,
branche.kommission1_abkuerzung_fr as kommission1_abkuerzung_fr,
branche.kommission2 as kommission2,
branche.kommission2_de as kommission2_de,
branche.kommission2_fr as kommission2_fr,
branche.kommission2_name as kommission2_name,
branche.kommission2_name_de as kommission2_name_de,
branche.kommission2_name_fr as kommission2_name_fr,
branche.kommission2_abkuerzung as kommission2_abkuerzung,
branche.kommission2_abkuerzung_de as kommission2_abkuerzung_de,
branche.kommission2_abkuerzung_fr as kommission2_abkuerzung_fr
FROM `v_interessengruppe_simple` interessengruppe
LEFT JOIN `v_branche` branche
ON branche.id = interessengruppe.branche_id
;

CREATE OR REPLACE VIEW `v_parlamentarier_simple` AS
SELECT
CONCAT(parlamentarier.nachname, ', ', parlamentarier.vorname) AS anzeige_name,
CONCAT(parlamentarier.nachname, ', ', parlamentarier.vorname) AS anzeige_name_de,
CONCAT(parlamentarier.nachname, ', ', parlamentarier.vorname) AS anzeige_name_fr,
CONCAT_WS(' ', parlamentarier.vorname, parlamentarier.zweiter_vorname, parlamentarier.nachname) AS name,
CONCAT_WS(' ', parlamentarier.vorname, parlamentarier.zweiter_vorname, parlamentarier.nachname) AS name_de,
CONCAT_WS(' ', parlamentarier.vorname, parlamentarier.zweiter_vorname, parlamentarier.nachname) AS name_fr,
parlamentarier.*,
parlamentarier.beruf as beruf_de,
parlamentarier.im_rat_seit as von, parlamentarier.im_rat_bis as bis,
(parlamentarier.im_rat_seit IS NULL OR parlamentarier.im_rat_seit <= NOW()) AND (parlamentarier.im_rat_bis IS NULL OR parlamentarier.im_rat_bis > NOW()) as aktiv,
IFNULL(freigabe_datum <= NOW(), FALSE) AS published
FROM `parlamentarier` parlamentarier;

CREATE OR REPLACE VIEW `v_organisation_medium_raw` AS
SELECT
organisation.*,
interessengruppe1.anzeige_name as interessengruppe,
interessengruppe1.anzeige_name_de as interessengruppe_de,
interessengruppe1.anzeige_name_fr as interessengruppe_fr,
interessengruppe1.branche as interessengruppe_branche,
interessengruppe1.branche_de as interessengruppe_branche_de,
interessengruppe1.branche_fr as interessengruppe_branche_fr,
interessengruppe1.branche_id as interessengruppe_branche_id,
interessengruppe1.kommission1_id as interessengruppe_branche_kommission1_id,
interessengruppe1.kommission1_abkuerzung as interessengruppe_branche_kommission1_abkuerzung,
interessengruppe1.kommission1_abkuerzung_de as interessengruppe_branche_kommission1_abkuerzung_de,
interessengruppe1.kommission1_abkuerzung_fr as interessengruppe_branche_kommission1_abkuerzung_fr,
interessengruppe1.kommission1_name as interessengruppe_branche_kommission1_name,
interessengruppe1.kommission1_name_de as interessengruppe_branche_kommission1_name_de,
interessengruppe1.kommission1_name_fr as interessengruppe_branche_kommission1_name_fr,
interessengruppe1.kommission2_id as interessengruppe_branche_kommission2_id,
interessengruppe1.kommission2_abkuerzung as interessengruppe_branche_kommission2_abkuerzung,
interessengruppe1.kommission2_abkuerzung_de as interessengruppe_branche_kommission2_abkuerzung_de,
interessengruppe1.kommission2_abkuerzung_fr as interessengruppe_branche_kommission2_abkuerzung_fr,
interessengruppe1.kommission2_name as interessengruppe_branche_kommission2_name,
interessengruppe1.kommission2_name_de as interessengruppe_branche_kommission2_name_de,
interessengruppe1.kommission2_name_fr as interessengruppe_branche_kommission2_name_fr,
interessengruppe1.anzeige_name as interessengruppe1,
interessengruppe1.id as interessengruppe1_id,
interessengruppe1.anzeige_name_de as interessengruppe1_de,
interessengruppe1.anzeige_name_fr as interessengruppe1_fr,
interessengruppe1.branche as interessengruppe1_branche,
interessengruppe1.branche_de as interessengruppe1_branche_de,
interessengruppe1.branche_fr as interessengruppe1_branche_fr,
interessengruppe1.branche_id as interessengruppe1_branche_id,
REPLACE(REPLACE(IFNULL(interessengruppe1.kommission1_abkuerzung, interessengruppe1.kommission2_abkuerzung), '-NR', ''), '-SR', '') as interessengruppe1_branche_kommission_abkuerzung,
REPLACE(REPLACE(IFNULL(interessengruppe1.kommission1_abkuerzung_de, interessengruppe1.kommission2_abkuerzung_de), '-NR', ''), '-SR', '') as interessengruppe1_branche_kommission_abkuerzung_de,
REPLACE(REPLACE(IFNULL(interessengruppe1.kommission1_abkuerzung_fr, interessengruppe1.kommission2_abkuerzung_fr), '-CN', ''), '-CE', '') as interessengruppe1_branche_kommission_abkuerzung_fr,
CONCAT_WS(' / ', interessengruppe1.kommission1_abkuerzung, interessengruppe1.kommission2_abkuerzung) as interessengruppe1_branche_kommissionen_abkuerzung,
CONCAT_WS(' / ', interessengruppe1.kommission1_abkuerzung_de, interessengruppe1.kommission2_abkuerzung_de) as interessengruppe1_branche_kommissionen_abkuerzung_de,
CONCAT_WS(' / ', interessengruppe1.kommission1_abkuerzung_fr, interessengruppe1.kommission2_abkuerzung_fr) as interessengruppe1_branche_kommissionen_abkuerzung_fr,
interessengruppe1.kommission1_id as interessengruppe1_branche_kommission1_id,
interessengruppe1.kommission1_abkuerzung as interessengruppe1_branche_kommission1_abkuerzung,
interessengruppe1.kommission1_abkuerzung_de as interessengruppe1_branche_kommission1_abkuerzung_de,
interessengruppe1.kommission1_abkuerzung_fr as interessengruppe1_branche_kommission1_abkuerzung_fr,
interessengruppe1.kommission1_name as interessengruppe1_branche_kommission1_name,
interessengruppe1.kommission1_name_de as interessengruppe1_branche_kommission1_name_de,
interessengruppe1.kommission1_name_fr as interessengruppe1_branche_kommission1_name_fr,
interessengruppe1.kommission2_id as interessengruppe1_branche_kommission2_id,
interessengruppe1.kommission2_abkuerzung as interessengruppe1_branche_kommission2_abkuerzung,
interessengruppe1.kommission2_abkuerzung_de as interessengruppe1_branche_kommission2_abkuerzung_de,
interessengruppe1.kommission2_abkuerzung_fr as interessengruppe1_branche_kommission2_abkuerzung_fr,
interessengruppe1.kommission2_name as interessengruppe1_branche_kommission2_name,
interessengruppe1.kommission2_name_de as interessengruppe1_branche_kommission2_name_de,
interessengruppe1.kommission2_name_fr as interessengruppe1_branche_kommission2_name_fr,
interessengruppe2.anzeige_name as interessengruppe2,
interessengruppe2.anzeige_name_de as interessengruppe2_de,
interessengruppe2.anzeige_name_fr as interessengruppe2_fr,
interessengruppe2.branche as interessengruppe2_branche,
interessengruppe2.branche_de as interessengruppe2_branche_de,
interessengruppe2.branche_fr as interessengruppe2_branche_fr,
interessengruppe2.branche_id as interessengruppe2_branche_id,
REPLACE(REPLACE(IFNULL(interessengruppe2.kommission1_abkuerzung, interessengruppe2.kommission2_abkuerzung), '-NR', ''), '-SR', '') as interessengruppe2_branche_kommission_abkuerzung,
REPLACE(REPLACE(IFNULL(interessengruppe2.kommission1_abkuerzung_de, interessengruppe2.kommission2_abkuerzung_de), '-NR', ''), '-SR', '') as interessengruppe2_branche_kommission_abkuerzung_de,
REPLACE(REPLACE(IFNULL(interessengruppe2.kommission1_abkuerzung_fr, interessengruppe2.kommission2_abkuerzung_fr), '-CN', ''), '-CE', '') as interessengruppe2_branche_kommission_abkuerzung_fr,
CONCAT_WS(' / ', interessengruppe2.kommission1_abkuerzung, interessengruppe2.kommission2_abkuerzung) as interessengruppe2_branche_kommissionen_abkuerzung,
CONCAT_WS(' / ', interessengruppe2.kommission1_abkuerzung_de, interessengruppe2.kommission2_abkuerzung_de) as interessengruppe2_branche_kommissionen_abkuerzung_de,
CONCAT_WS(' / ', interessengruppe2.kommission1_abkuerzung_fr, interessengruppe2.kommission2_abkuerzung_fr) as interessengruppe2_branche_kommissionen_abkuerzung_fr,
interessengruppe2.kommission1_id as interessengruppe2_branche_kommission1_id,
interessengruppe2.kommission1_abkuerzung as interessengruppe2_branche_kommission1_abkuerzung,
interessengruppe2.kommission1_abkuerzung_de as interessengruppe2_branche_kommission1_abkuerzung_de,
interessengruppe2.kommission1_abkuerzung_fr as interessengruppe2_branche_kommission1_abkuerzung_fr,
interessengruppe2.kommission1_name as interessengruppe2_branche_kommission1_name,
interessengruppe2.kommission1_name_de as interessengruppe2_branche_kommission1_name_de,
interessengruppe2.kommission1_name_fr as interessengruppe2_branche_kommission1_name_fr,
interessengruppe2.kommission2_id as interessengruppe2_branche_kommission2_id,
interessengruppe2.kommission2_abkuerzung as interessengruppe2_branche_kommission2_abkuerzung,
interessengruppe2.kommission2_abkuerzung_de as interessengruppe2_branche_kommission2_abkuerzung_de,
interessengruppe2.kommission2_abkuerzung_fr as interessengruppe2_branche_kommission2_abkuerzung_fr,
interessengruppe2.kommission2_name as interessengruppe2_branche_kommission2_name,
interessengruppe2.kommission2_name_de as interessengruppe2_branche_kommission2_name_de,
interessengruppe2.kommission2_name_fr as interessengruppe2_branche_kommission2_name_fr,
interessengruppe3.anzeige_name as interessengruppe3,
interessengruppe3.anzeige_name_de as interessengruppe3_de,
interessengruppe3.anzeige_name_fr as interessengruppe3_fr,
interessengruppe3.branche as interessengruppe3_branche,
interessengruppe3.branche_de as interessengruppe3_branche_de,
interessengruppe3.branche_fr as interessengruppe3_branche_fr,
interessengruppe3.branche_id as interessengruppe3_branche_id,
REPLACE(REPLACE(IFNULL(interessengruppe3.kommission1_abkuerzung, interessengruppe3.kommission2_abkuerzung), '-NR', ''), '-SR', '') as interessengruppe3_branche_kommission_abkuerzung,
REPLACE(REPLACE(IFNULL(interessengruppe3.kommission1_abkuerzung_de, interessengruppe3.kommission2_abkuerzung_de), '-NR', ''), '-SR', '') as interessengruppe3_branche_kommission_abkuerzung_de,
REPLACE(REPLACE(IFNULL(interessengruppe3.kommission1_abkuerzung_fr, interessengruppe3.kommission2_abkuerzung_fr), '-CN', ''), '-CE', '') as interessengruppe3_branche_kommission_abkuerzung_fr,
CONCAT_WS(' / ', interessengruppe3.kommission1_abkuerzung, interessengruppe3.kommission2_abkuerzung) as interessengruppe3_branche_kommissionen_abkuerzung,
CONCAT_WS(' / ', interessengruppe3.kommission1_abkuerzung_de, interessengruppe3.kommission2_abkuerzung_de) as interessengruppe3_branche_kommissionen_abkuerzung_de,
CONCAT_WS(' / ', interessengruppe3.kommission1_abkuerzung_fr, interessengruppe3.kommission2_abkuerzung_fr) as interessengruppe3_branche_kommissionen_abkuerzung_fr,
interessengruppe3.kommission1_id as interessengruppe3_branche_kommission1_id,
interessengruppe3.kommission1_abkuerzung as interessengruppe3_branche_kommission1_abkuerzung,
interessengruppe3.kommission1_abkuerzung_de as interessengruppe3_branche_kommission1_abkuerzung_de,
interessengruppe3.kommission1_abkuerzung_fr as interessengruppe3_branche_kommission1_abkuerzung_fr,
interessengruppe3.kommission1_name as interessengruppe3_branche_kommission1_name,
interessengruppe3.kommission1_name_de as interessengruppe3_branche_kommission1_name_de,
interessengruppe3.kommission1_name_fr as interessengruppe3_branche_kommission1_name_fr,
interessengruppe3.kommission2_id as interessengruppe3_branche_kommission2_id,
interessengruppe3.kommission2_abkuerzung as interessengruppe3_branche_kommission2_abkuerzung,
interessengruppe3.kommission2_abkuerzung_de as interessengruppe3_branche_kommission2_abkuerzung_de,
interessengruppe3.kommission2_abkuerzung_fr as interessengruppe3_branche_kommission2_abkuerzung_fr,
interessengruppe3.kommission2_name as interessengruppe3_branche_kommission2_name,
interessengruppe3.kommission2_name_de as interessengruppe3_branche_kommission2_name_de,
interessengruppe3.kommission2_name_fr as interessengruppe3_branche_kommission2_name_fr,
NOW() as refreshed_date
FROM `v_organisation_simple` organisation
LEFT JOIN `v_interessengruppe` interessengruppe1
ON interessengruppe1.id = organisation.interessengruppe_id
LEFT JOIN `v_interessengruppe` interessengruppe2
ON interessengruppe2.id = organisation.interessengruppe2_id
LEFT JOIN `v_interessengruppe` interessengruppe3
ON interessengruppe3.id = organisation.interessengruppe3_id
;

CREATE OR REPLACE VIEW `v_interessenbindung_medium_raw` AS
SELECT CONCAT(interessenbindung.id, ', ', parlamentarier.anzeige_name, ', ', organisation.anzeige_name, ', ', interessenbindung.art) anzeige_name,
interessenbindung.*,
IF(organisation.vernehmlassung IN ('immer', 'punktuell')
  AND interessenbindung.art IN ('geschaeftsfuehrend','vorstand')
  AND EXISTS (
    SELECT in_kommission.kommission_id
    FROM in_kommission in_kommission
    LEFT JOIN branche branche
    ON (in_kommission.kommission_id = branche.kommission_id OR in_kommission.kommission_id = branche.kommission2_id)
    WHERE (in_kommission.bis >= NOW() OR in_kommission.bis IS NULL)
    AND in_kommission.parlamentarier_id = parlamentarier.id
    AND branche.id IN (organisation.interessengruppe_branche_id, organisation.interessengruppe2_branche_id, organisation.interessengruppe3_branche_id)), 'hoch',
  IF(organisation.vernehmlassung IN ('immer', 'punktuell')
    AND interessenbindung.art IN ('geschaeftsfuehrend','vorstand','taetig','beirat','finanziell'), 'mittel', 'tief')
) wirksamkeit,
parlamentarier.im_rat_seit as parlamentarier_im_rat_seit
FROM `v_interessenbindung_simple` interessenbindung
INNER JOIN `v_organisation_medium_raw` organisation
ON interessenbindung.organisation_id = organisation.id
INNER JOIN `v_parlamentarier_simple` parlamentarier
ON interessenbindung.parlamentarier_id = parlamentarier.id;
