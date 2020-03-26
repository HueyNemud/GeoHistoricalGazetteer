DROP VIEW IF EXISTS travail.france_cassini_chefs_lieux CASCADE;

CREATE OR REPLACE VIEW travail.france_cassini_chefs_lieux AS
SELECT * FROM france_cassini_chefs_lieux
-- To export a specific area
-- WHERE ST_Within(geom, ST_GeomFromText('Polygon ((944397.19628220167942345 7020001.0846266895532608, 1147842.01935799233615398 7016846.78101391717791557, 1094397.19628220167942345 6870001.0846266895532608, 944397.19628220167942345 6870001.0846266895532608, 944397.19628220167942345 7020001.0846266895532608))',2154));

DROP VIEW IF EXISTS travail.france_cassini_toponyms CASCADE;

CREATE OR REPLACE VIEW travail.france_cassini_toponyms AS
SELECT * FROM france_cassini_toponyms
-- To export a specific area
-- WHERE ST_Within(geom, ST_GeomFromText('Polygon ((944397.19628220167942345 7020001.0846266895532608, 1147842.01935799233615398 7016846.78101391717791557, 1094397.19628220167942345 6870001.0846266895532608, 944397.19628220167942345 6870001.0846266895532608, 944397.19628220167942345 7020001.0846266895532608))',2154));

-- ghp:Place
DROP VIEW IF EXISTS travail.r2rml_place CASCADE;

CREATE OR REPLACE VIEW travail.r2rml_place AS
(
SELECT 't_' || id AS key,
    'The GeoHistoricalData group. http://geohistoricaldata.org'::text AS creator,
    NULL AS code_commune,
    NULL AS lien_site_cassini
FROM travail.france_cassini_toponyms
LIMIT 1000000
OFFSET 0)
UNION
(
SELECT 'cl_' || gid AS key,
    'Claude Motte (LaDéHiS-CRH(UMR 8558)-EHESS), Marie-Christine Vouloir (LaDéHiS-CRH(UMR 8558)-EHESS) and the GeoHistoricalData group. http://geohistoricaldata.org'::text AS creator,
    -- On conserve le code commune seulement si la commune est de type 'co' (encore existante). En raison de la méthode de Claude qui consite à attriber aux anciennes
    -- communes le code de la commune les ayant absorbées, on peut se retrouver pour ces communes aves des code ne leur correspondant pas.
    CASE
        WHEN type_bd = 'co' THEN REPLACE(insee_c,' ','')::text
        ELSE NULL
    END
    AS code_commune,
    lien_site_cassini
FROM travail.france_cassini_chefs_lieux
LIMIT 1000000
OFFSET 0);

-- ghp:Place
DROP VIEW IF EXISTS travail.r2rml_place CASCADE;

CREATE OR REPLACE VIEW travail.r2rml_place AS 
(
SELECT 't_' || id AS key,
    'The GeoHistoricalData group. http://geohistoricaldata.org'::text AS creator,
    NULL AS code_commune,
    NULL AS lien_site_cassini
FROM travail.france_cassini_toponyms
LIMIT 1000000
OFFSET 0)
UNION
(
SELECT 'cl_' || gid AS key,
    'Claude Motte (LaDéHiS-CRH(UMR 8558)-EHESS), Marie-Christine Vouloir (LaDéHiS-CRH(UMR 8558)-EHESS) and the GeoHistoricalData group. http://geohistoricaldata.org'::text AS creator,
    -- On conserve le code commune seulement si la commune est de type 'co' (encore existante). En raison de la méthode de Claude qui consite à attriber aux anciennes
    -- communes le code de la commune les ayant absorbées, on peut se retrouver pour ces communes aves des code ne leur correspondant pas.
    CASE
        WHEN type_bd = 'co' THEN REPLACE(insee_c,' ','')::text
        ELSE NULL
    END
    AS code_commune,
    lien_site_cassini
FROM travail.france_cassini_chefs_lieux
LIMIT 1000000
OFFSET 0);

-- ghp:Location
DROP VIEW IF EXISTS travail.r2rml_location CASCADE;


-- ghp:Location
DROP VIEW IF EXISTS travail.r2rml_location CASCADE;

CREATE OR REPLACE VIEW travail.r2rml_location AS
(
SELECT 't_' || id AS key,
    'data.geohistoricaldata.org/id/source/cartedecassini'::text AS attestedby,
    1755::integer AS obstime_start,
    1815::integer AS obstime_end 
FROM travail.france_cassini_toponyms
LIMIT 1000000
OFFSET 0)
UNION
(
SELECT 'cl_' || gid AS key,
    CASE
    WHEN xy_valid != 'ok|non present' THEN 'data.geohistoricaldata.org/id/source/cartedecassini'::text
    ELSE 'cassini.ehess.fr'::text
    END
    AS attestedby,
    CASE
    WHEN xy_valid != 'ok|non present' THEN 1755::integer 
    ELSE 1999::integer
    END
    AS obstime_start,
    CASE
    WHEN xy_valid != 'ok|non present' THEN 1815::integer 
    ELSE 2010::integer
    END
    AS obstime_end
FROM travail.france_cassini_chefs_lieux
LIMIT 1000000
OFFSET 0);

DROP VIEW IF EXISTS travail.r2rml_geometry CASCADE;

CREATE OR REPLACE VIEW travail.r2rml_geometry AS
-- Uncomment the following if you also want the geometries in Lambert 93
-- Do not forget to enable the generation of Lambert 93 nodes in the R2RML file
--(
--SELECT 't_' || id AS key,
--    2154 AS srid,
--    '<http://data.ign.fr/id/ignf/crs/RGF93LAMB93> '::text || st_astext(geom) AS geom
--FROM travail.france_cassini_toponyms
--LIMIT 10
--OFFSET 0)
--UNION
(
SELECT 't_' || id AS key,
    4326 AS srid,
    '<http://www.opengis.net/def/crs/OGC/1.3/CRS84> '::text || st_astext(st_transform(geom, 4326)) AS geom
FROM travail.france_cassini_toponyms  
LIMIT 1000000
OFFSET 0)
-- Uncomment the following if you also want the geometries in Lambert 93
-- Do not forget to enable the generation of Lambert 93 nodes in the R2RML file
--UNION
-- Uncomment the following if you also want the geometries in Lambert 93
-- Do not forget to enable the generation of Lambert 93 nodes in the R2RML file
--(
--SELECT 'cl_' || gid AS key,
--    2154 AS srid,
--    '<http://data.ign.fr/id/ignf/crs/RGF93LAMB93> '::text || st_astext(geom) AS geom
--FROM travail.france_cassini_chefs_lieux
--LIMIT 10
--OFFSET 0)
UNION
(
SELECT 'cl_' || gid AS key,
    4326 AS srid,
    '<http://www.opengis.net/def/crs/OGC/1.3/CRS84> '::text || st_astext(st_transform(geom, 4326)) AS geom
FROM travail.france_cassini_chefs_lieux
LIMIT 1000000
OFFSET 0);

DROP VIEW IF EXISTS travail.r2rml_name CASCADE;

CREATE OR REPLACE VIEW travail.r2rml_name AS
(
SELECT 'cl_' || gid AS key,
    1 AS subkey,
    nomcart AS name,
    1755 AS obstime_start,
    1815 AS obstime_end,
    'data.geohistoricaldata.org/id/source/cartedecassini'::text AS attestedby
FROM travail.france_cassini_chefs_lieux
WHERE nomcart IS NOT NULL AND nomcart NOT LIKE  '%-%'  
LIMIT 1000000
OFFSET 0)
UNION
(
SELECT 'cl_' || gid AS key,
    2 AS subkey,
    noman3 AS name,
    1794 AS obstime_start,
    1795 AS obstime_end,
    'cassini.ehess.fr'::text AS attestedby
FROM travail.france_cassini_chefs_lieux
WHERE noman3 IS NOT NULL
LIMIT 1000000
OFFSET 0)
UNION
(
SELECT 'cl_' || gid AS key,
    3 AS subkey,
    nom1999 AS name,
    1999 AS obstime_start,
    1999 AS obstime_end,
    'cassini.ehess.fr'::text AS attestedby  
FROM travail.france_cassini_chefs_lieux 
WHERE nom1999 IS NOT NULL
LIMIT 1000000
OFFSET 0)
UNION
(
SELECT 't_' || id AS key,
    1 AS subkey,
    nom AS name,
    1755 AS obstime_start,
    1815 AS obstime_end,
    'data.geohistoricaldata.org/id/source/cartedecassini'::text AS attestedby
FROM travail.france_cassini_toponyms
WHERE nom IS NOT NULL AND nom NOT LIKE  '%-%'  
LIMIT 1000000
OFFSET 0);

DROP VIEW IF EXISTS travail.r2rml_status CASCADE;

CREATE OR REPLACE VIEW travail.r2rml_status AS 
(
SELECT 'cl_' || gid AS key,
    1 AS subkey,
    'ChefLieuParoissialAncienRegime' AS value,
    1755 AS obstime_start,
    1815 AS obstime_end,    
    'data.geohistoricaldata.org/id/source/cartedecassini'::text AS attestedby
FROM travail.france_cassini_chefs_lieux
WHERE typecart = 'clocher' AND xy_valid != 'ok|non present'
AND xy_valid != ''
LIMIT 1000000
OFFSET 0)
UNION
(
SELECT 'cl_' || gid AS key,
    2 AS subkey,
    'ChefLieuCommunal' AS value,
    1999 AS obstime_start,
    1999 AS obstime_end,    
    'cassini.ehess.fr'::text AS attestedby
FROM travail.france_cassini_chefs_lieux 
WHERE nom1999 IS NOT NULL
LIMIT 1000000
OFFSET 0);

DROP VIEW IF EXISTS travail.r2rml_nature CASCADE;

CREATE OR REPLACE VIEW travail.r2rml_nature AS 
(
SELECT 't_' || travail.france_cassini_toponyms.id AS key,
   1 AS subkey,
   CASE
        WHEN type::text = 'Calvaire ou Oratoire'::text THEN 'croix'::text
        WHEN lower(type::text) = 'abbaye'::text THEN 'Abbaye'::text
        WHEN lower(type::text) = 'autre'::text THEN 'anyplace'::text
        WHEN lower(type::text) = 'autre lieu religieux'::text THEN 'anyplace'::text
        WHEN lower(type::text) = 'bourg'::text THEN 'Bourg'::text
        WHEN lower(type::text) = 'cabane'::text THEN 'Cabane'::text
        WHEN lower(type::text) = 'chapelle'::text THEN 'Chapelle'::text
        WHEN lower(type::text) = 'château'::text THEN 'Château'::text
        WHEN lower(type::text) = 'cimetière'::text THEN 'cimetière'::text
        WHEN lower(type::text) = 'clocher'::text THEN 'Clocher'::text
        WHEN lower(type::text) = 'clocher succursale'::text THEN 'Clocher'::text
        WHEN lower(type::text) = 'commanderie'::text THEN 'Commanderie'::text
        WHEN lower(type::text) = 'corps de garde'::text THEN 'CorpsDeGarde'::text
        WHEN lower(type::text) = 'croix'::text THEN 'Croix'::text
        WHEN lower(type::text) = 'fort'::text THEN 'Fort'::text
        WHEN lower(type::text) = 'gentilhommière'::text THEN 'Gentilhommière'::text
        WHEN lower(type::text) = 'hameau'::text THEN 'Hameau'::text
        WHEN lower(type::text) = 'maison'::text THEN 'Maison'::text
        WHEN lower(type::text) = 'moulin à vent'::text THEN 'MoulinÀVent'::text
        WHEN lower(type::text) = 'moulin à eau'::text THEN 'MoulinÀEau'::text
        WHEN lower(type::text) = 'port'::text THEN 'Port'::text
        WHEN lower(type::text) = 'justice'::text THEN 'Justice'::text
        WHEN lower(type::text) = 'prieuré'::text THEN 'Prieuré'::text
        WHEN lower(type::text) = 'redoute'::text THEN 'Redoute'::text
        WHEN lower(type::text) = 'ville'::text THEN 'Ville'::text
    ELSE 'anyplace'::text
    END AS value,
    1755 AS obstime_start,
    1815 AS obstime_end,    
    'data.geohistoricaldata.org/id/source/cartedecassini'::text AS attestedby
FROM travail.france_cassini_toponyms
JOIN types_ponctuels ON travail.france_cassini_toponyms.type_id = types_ponctuels.id
LIMIT 1000000
OFFSET 0)        
UNION
(
SELECT 'cl_' || gid AS key,
   1 AS subkey,
   CASE
        WHEN lower(typecart::text) = 'abbaye'::text THEN 'Abbaye'::text
        WHEN lower(typecart::text) = 'autre'::text THEN 'Lieu'::text
        WHEN lower(typecart::text) = 'autre lieu religieux'::text THEN 'Lieu'::text
        WHEN lower(typecart::text) = 'bourg'::text THEN 'Bourg'::text
        WHEN lower(typecart::text) = 'chapelle'::text THEN 'Chapelle'::text
        WHEN lower(typecart::text) = 'château'::text THEN 'Château'::text
        WHEN lower(typecart::text) = 'clocher'::text THEN 'Clocher'::text
        WHEN lower(typecart::text) = 'succursale'::text THEN 'Succursale'::text
        WHEN lower(typecart::text) = 'hameau'::text THEN 'Hameau'::text
        WHEN lower(typecart::text) = 'prieuré'::text THEN 'Prieuré'::text
        WHEN lower(typecart::text) = 'ville'::text THEN 'Ville'::text
    ELSE 'anyplace'::text
    END AS value,
    1755 AS obstime_start,
    1815 AS obstime_end,    
    'data.geohistoricaldata.org/id/source/cartedecassini'::text AS attestedby
FROM travail.france_cassini_chefs_lieux
LIMIT 1000000
OFFSET 0);


-- Export succinct des données au format SIG pour la visu
-- SELECT 't_' || france_cassini_toponyms.id AS id,
--    nom as name,
--    CASE
--    WHEN type::text = 'Calvaire ou Oratoire'::text THEN 'croix'::text
--        WHEN lower(type::text) = 'abbaye'::text THEN 'Abbaye'::text
--        WHEN lower(type::text) = 'autre'::text THEN 'anyplace'::text
--        WHEN lower(type::text) = 'autre lieu religieux'::text THEN 'anyplace'::text
--        WHEN lower(type::text) = 'bourg'::text THEN 'Bourg'::text
--        WHEN lower(type::text) = 'cabane'::text THEN 'Cabane'::text
--        WHEN lower(type::text) = 'chapelle'::text THEN 'Chapelle'::text
--        WHEN lower(type::text) = 'château'::text THEN 'Château'::text
--        WHEN lower(type::text) = 'cimetière'::text THEN 'cimetière'::text
--        WHEN lower(type::text) = 'clocher'::text THEN 'Clocher'::text
--        WHEN lower(type::text) = 'clocher succursale'::text THEN 'Clocher'::text
--        WHEN lower(type::text) = 'commanderie'::text THEN 'Commanderie'::text
--        WHEN lower(type::text) = 'corps de garde'::text THEN 'CorpsDeGarde'::text
--        WHEN lower(type::text) = 'croix'::text THEN 'Croix'::text
--        WHEN lower(type::text) = 'fort'::text THEN 'Fort'::text
--        WHEN lower(type::text) = 'gentilhommière'::text THEN 'Gentilhommière'::text
--        WHEN lower(type::text) = 'hameau'::text THEN 'Hameau'::text
--        WHEN lower(type::text) = 'maison'::text THEN 'Maison'::text
--        WHEN lower(type::text) = 'moulin à vent'::text THEN 'MoulinÀVent'::text
--        WHEN lower(type::text) = 'moulin à eau'::text THEN 'MoulinÀEau'::text
--        WHEN lower(type::text) = 'port'::text THEN 'Port'::text
--        WHEN lower(type::text) = 'justice'::text THEN 'Justice'::text
--        WHEN lower(type::text) = 'prieuré'::text THEN 'Prieuré'::text
--        WHEN lower(type::text) = 'redoute'::text THEN 'Redoute'::text
--        WHEN lower(type::text) = 'ville'::text THEN 'Ville'::text
--    ELSE 'anyplace'::text
--    END AS nature,
--    NULL as status,
--    geom AS geom
--FROM france_cassini_toponyms
--JOIN types_ponctuels 
--ON france_cassini_toponyms.type_id = types_ponctuels.id
--UNION
--SELECT 'cl_' || gid as id,
--    nomcart as name,
--    CASE
--    WHEN lower(typecart::text) = 'abbaye'::text THEN 'Abbaye'::text
--    WHEN lower(typecart::text) = 'autre'::text THEN 'Lieu'::text
--    WHEN lower(typecart::text) = 'autre lieu religieux'::text THEN 'Lieu'::text
--    WHEN lower(typecart::text) = 'bourg'::text THEN 'Bourg'::text
--    WHEN lower(typecart::text) = 'chapelle'::text THEN 'Chapelle'::text
--    WHEN lower(typecart::text) = 'château'::text THEN 'Château'::text
--    WHEN lower(typecart::text) = 'clocher'::text THEN 'Clocher'::text
--    WHEN lower(typecart::text) = 'succursale'::text THEN 'Succursale'::text
--    WHEN lower(typecart::text) = 'hameau'::text THEN 'Hameau'::text
--    WHEN lower(typecart::text) = 'prieuré'::text THEN 'Prieuré'::text
--    WHEN lower(typecart::text) = 'ville'::text THEN 'Ville'::text
--    ELSE 'anyplace'::text
--    END AS nature,
--    CASE 
--    WHEN lower(typecart::text) = 'clocher' THEN 'ChefLieuParoissialAncienRegime'::text
--    ELSE NULL
--    END as status,
--    geom
--FROM france_cassini_chefs_lieux;
