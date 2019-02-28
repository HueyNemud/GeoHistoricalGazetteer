GeoHistoricalData2RDF
===
Journal de travail de la publication LOD des données GeoHistoricalData

# Mardi 7 août 2018

**Schemas**
- Première version faite par les étudiants de l'ENSG: https://github.com/geoTirroirs/geoSnippets/blob/master/ghs/geotir.ttl 
- Une deuxième proposition de schéma par Nathalie Abadie.
- [Linked Places Format](https://github.com/LinkedPasts/linked-places)

**Thesaurus et typologie d'entités**
On décrit notre propre thesaurus comme des concepts Skos et on peut lier chaque concept à des concepts Getty, http://pactols.frantiq.fr/, Wikidata

Ci-dessous la liste extraite des tables chefs_lieux et toponymes:
Abbaye
Cabane
Calvaire ou Oratoire
Clocher
Autre
Autre lieu religieux
Chapelle
Château
Cimetière
Clocher succursale
Commanderie
Corps de Garde
Fort
Gentilhommière
Hameau
Justice
Maison
Moulin à eau
Moulin à vent
Port
Prieuré
Redoute

ville
bourg
chapelle
autre
hameau
clocher
abbaye

**Outils pour transformer les données**
Outil R2RML : [R2RML-Parser](https://github.com/nkons/r2rml-parser)
Règles créées par B. Dumenieu pour l'historique des communes de France.

**URIs**
reuse of primary keys of the database tables, something like http://data.geohistoricaldata.org/id/place/111.

**Sources et auteurs**
Predicats à implementer (par chaque entrée lieu du gazetier ?) :
dcterms:contributor, 
dcterms:bibliographicCitation, 
dc:creator

**Liens d'équivalence**
Getty TGN ou Wikidata ou Geonames ou Pleaides-places ?
Prévoir utilisation des scripts de Karl Grossner (cf. mail de 7/8)

**Indexation par WHG**
Voir https://github.com/LinkedPasts/linked-places/blob/master/n-quads_annotated.rdf 

**Ordre de priorité des données à transformer**
Cassini : 
1. Lieux ponctuels
2. Chefs lieux de paroisse (à fusionner avec les lieux ponctuels) **Complet**
3. Taches urbaines **Complet**
4. Réseau routier **Complet**
5. Réseau hydrographique
6. Oronymes
7. Couverture forestiere (INRA/WWF) : vérifier les droits **Complet**
8. Limites administratives
9. Occupation du sol


# Pré-traitements à faire : travail de reconciliation de données

On veut arriver à une seule table Lieux ponctuels avec une typologie homogène et cartographique (conforme à la legende de Cassini) resultant de la fusion des tables _toponymes, _taches_urbaines et _chefs_lieux. 

Les attributs à conserver de chacune des trois tables sont listés ci-dessous et ceux-ci définissent la structure de la table resultante:

 ### _toponymes: 
 | Champs | Commentaire |
 |---|---|
| id  | -> id_toponymes |
| incertain  | -> à conserver |
| valide  | -> ne pas conserver|
| commentaire  | -> à conserver|
| nom  | -> réconcilier avec chefs_lieux.nomcart |
| geom  | -> réconcilier avec chefs_lieux.geom  |
| oldtype  | -> ne pas conserver |
| ruine  | -> à conserver|
| type_id  | -> remplacer par la chaîne correspondante|
| sym_taille  | -> ne pas conserver|

 ### _taches_urbaines 

| Champs | Commentaire |
 |---|---|
| id  | |
| geom  | |
| nom  | |
| type  | |
| commentaire  | |
| fortifiee  | |
  
### _chefs_lieux:
 | Champs | Commentaire |
|---|---|
| gid  | -> id_chefs_lieux |
| id  | -> ne pas conserver|
| npc  | -> ne pas conserver |
| noacass  | -> ne pas conserver |
| typecart | ->  réconcilier avec la chaîne associée au toponyms.type_id |
| xy_valid | -> Information de généalogie de la donnée. -> ne pas conserver (à intégrer dans une prochaine MAJ) |
| nomcart | -> à conserver |
| type_bd | *co*: commune existante en 1999. *ca*: ancienne commune. *new*: chefs lieux de paroisses présents dans cassini mais qui ne sont pas devenus des communes. **-> à transformer en attestation du statut de commune en 1999 pour co et ac.** |
| xlamb | Coordonnées de la commune en Lambert II étendu (vide ou 0 pour *new*). -> ne pas conserver |
| ylamb | Coordonnées de la commune en Lambert II étendu (vide ou 0 pour *new*)-> ne pas conserver |
| dep99 | Département de la commune en 1999. -> ne pas conserver|
| insee_l | -> à conserver |
| insee_c | -> à conserver |
| label | Dernier nom connu de la commune. -> ne pas conserver|
| noman3 | Nom de la commune lors du recensement de l'AN 3. -> à conserver|
| nom1801 | Nom de la commune en 1801. -> à conserver|
| nb  | -> ne pas conserver |
| xlambo | -> ne pas conserver |
| ylambo | -> ne pas conserver |
| lon | -> ne pas conserver |
| lat | -> ne pas conserver |
| codgeon | -> ne pas conserver |
| nom1999 | -> à conserver |
| no | -> ne pas conserver |
| type1794 | Existance de la commune en 1794. *NE*: non-existante, *adm.*: Commune administrée par une autre. *E*: existance, *abs.*: document ou page disparue. *lac.*: oubliée sur la publication du recensement. *etr.*: communes absentes car sur territoire étranger en 1794. *NULL*: ???.**-> à transformer.** |
| han3 | -> à conserver |
| han8  | -> à conserver |
| h1806  | -> à conserver |
| h1820  | -> à conserver |
| h1831  | -> à conserver |
| h1836  | -> à conserver |
| h1841  | -> à conserver |
| h1846  | -> à conserver |
| h1851  | -> à conserver |
| h1856  | -> à conserver |
| h1861  | -> à conserver |
| h1866  | -> à conserver |
| h1872  | -> à conserver |
| h1876  | -> à conserver |
| h1881  | -> à conserver |
| h1886  | -> à conserver |
| h1891  | -> à conserver |
| h1896  | -> à conserver |
| h1901  | -> à conserver |
| h1906  | -> à conserver |
| h1911  | -> à conserver |
| h1921  | -> à conserver |
| h1926  | -> à conserver |
| h1931  | -> à conserver |
| h1936  | -> à conserver |
| h1946  | -> à conserver |
| h1954  | -> à conserver |
| h1962  | -> à conserver |
| h1968  | -> à conserver |
| h1975  | -> à conserver |
| h1982  | -> à conserver |
| h1990  | -> à conserver |
| h1999  | -> à conserver |
| superf_ha  | -> ne pas conserver |
| alt_min  | -> ne pas conserver |
| alt_max  | -> ne pas conserver |
| commentair | -> à conserver |
| geom  | -> à conserver (géométrie calée sur la carte de Cassini)|
| b_incert | -> ne pas conserver (tout est à 0) |
| b_nonpresent | ??? |
| lien_site_cassini | -> à conserver (seeAlso)|
| b_italique | -> ne pas conserver (à intégrer dans une prochaine MAJ) |
| b_fortifiee | -> à conserver |
| b_typononconforme | -> ne pas conserver (à intégrer dans une prochaine MAJ) |
| b_typononconform |  -> ne pas conserver (à intégrer dans une prochaine MAJ) |
| archi_nom | -> ne pas conserver (à intégrer dans une prochaine MAJ) |
| archi_collateur | -> ne pas conserver (à intégrer dans une prochaine MAJ) |
| archi_annexede | -> ne pas conserver (à intégrer dans une prochaine MAJ) |
| "X_etiquette" | -> ne pas conserver |
| "Y_etiquette" | -> ne pas conserver |
| "Etiquette_1" | -> ne pas conserver |
| "Etiquette_2" | -> ne pas conserver |
| "Espacement_lettre" | -> ne pas conserver|
| "Espacement_mot" | -> ne pas conserver |
| "Taille_Police" | -> ne pas conserver |
| "Ligne2Droite" |-> ne pas conserver  |
| "Ligne2AlaSuite" | -> ne pas conserver  |
| nom_dioc |  -> ne pas conserver  |
| dx_ligne2  |-> ne pas conserver  |
| dy_ligne2  | -> ne pas conserver  |
 
 
 ## Réconciliation
 
 A completer.
 

Le processus de reconciliation est fondée sur la géometrie de l'objet et peut être fait automatiquement à partir de la requete spatiale (qui comprend une mesure de similarité entre chaînes de caractères) en SQL via PostgreSQL/PostGIS ci-dessous :
```sql
SELECT a.id as "id_cheflieu",
       b.id AS "id_toponyme",
       a.nomcart,
       b.nom,
       coalesce(similarity(a.nomcart,b.nom), 0.),
       ST_DISTANCE(a.geom, b.geom),
       a.geom as "geom_cheflieu",
       b.geom as "geom_toponyme"
FROM france_cassini_chefs_lieux a 
JOIN france_cassini_toponyms b
ON ST_DWithin(a.geom, b.geom, 100)
ORDER BY coalesce(similarity(a.nomcart,b.nom),0.), st_distance;
```
Résultat : 5055 lignes dont 1039 avec une similarité inférieure à 1. Il faut vérifier manuellement les 1039 entrées. On peut également supposer que les entrées dans toponymes qui sont clocher, on les ignorer pour le processus manuelle de correction car on peut être certain que celles-ci sont des doublons.

Pour le restant 500 entrées (environ) potentiellement doublons de la table toponymes, il faut via QGIS suivre cette procédure :

Comment effacer un doublon ?
- chercher deux symboles superposés (la categorisation par distance est utile, commencer par ceux dont le symbole est de taille 80-100 (très proches, donc très probablement un doublon) 
- regarder le nom du lieu sur la carte et les informations sur la carte
- noter dans un document l'identifiant (champ 'id') de l'entrée de la table toponymes qui sera effacée plus tard

# Jeudi 9 août 2018

- GeoHistoricalSchema : https://codeshare.io/5Myzny 

- Test du vocab sur une donnée - Frasne (clocher): https://codeshare.io/G7D3Eb

- Intégration avec WHG : voir mail de Karl Grossner du 8 aout.

# Jeudi 30 août 2018



 ## Préparation des données relationelles pour l'export RDF
 
```sql

CREATE OR REPLACE VIEW travail.cassini_places AS 
 SELECT
 CASE WHEN x.id_toponym IS NULL THEN 'cl_'::text || x.id_cheflieu::text
            ELSE 't_'::text || x.id_toponym::text
        END AS uid,
    x.id_toponym,
    x.id_cheflieu,
    x.incertain,
    x.commentaire,
    x.nom,
    x.geom,
    x.geom_wgs84,
    x.ruine,
    x.type,
    x.typerdf,
    x.type_bd,
    x.insee_l,
    x.insee_c,
    x.noman3,
    x.nom1801,
    x.nom1999,
    x.type1794,
    x.lien_site_cassini,
    x.b_fortifiee,
    x.creator
   FROM ( SELECT a.id AS id_toponym,
            NULL::integer AS id_cheflieu,
            a.incertain,
            a.commentaire,
            a.nom,
            '<http://data.ign.fr/id/ignf/crs/RGF93LAMB93> '||st_astext(a.geom) AS geom,
            '<http://www.opengis.net/def/crs/OGC/1.3/CRS84> '||st_astext(st_transform(a.geom, 4326)) AS geom_wgs84,
            a.ruine,
            b.type,
                CASE
                    WHEN b.type::text = 'Calvaire ou Oratoire'::text THEN 'croix'::text
                    WHEN lower(b.type::text) = 'abbaye'::text THEN 'abbaye'::text
                    WHEN lower(b.type::text) = 'autre'::text THEN 'lieu'::text
                    WHEN lower(b.type::text) = 'autre lieu religieux'::text THEN 'lieu'::text
                    WHEN lower(b.type::text) = 'bourg'::text THEN 'bourg'::text
                    WHEN lower(b.type::text) = 'cabane'::text THEN 'cabane'::text
                    WHEN lower(b.type::text) = 'chapelle'::text THEN 'chapelle'::text
                    WHEN lower(b.type::text) = 'château'::text THEN 'château'::text
                    WHEN lower(b.type::text) = 'cimetière'::text THEN 'cimetière'::text
                    WHEN lower(b.type::text) = 'clocher'::text THEN 'clocher'::text
                    WHEN lower(b.type::text) = 'clocher succursale'::text THEN 'clocher'::text
                    WHEN lower(b.type::text) = 'commanderie'::text THEN 'commanderie'::text
                    WHEN lower(b.type::text) = 'corps de garde'::text THEN 'corps_de_garde'::text
                    WHEN lower(b.type::text) = 'croix'::text THEN 'croix'::text
                    WHEN lower(b.type::text) = 'fort'::text THEN 'fort'::text
                    WHEN lower(b.type::text) = 'gentilhommière'::text THEN 'gentilhommière'::text
                    WHEN lower(b.type::text) = 'hameau'::text THEN 'hameau'::text
                    WHEN lower(b.type::text) = 'maison'::text THEN 'maison'::text
                    WHEN lower(b.type::text) = 'moulin à vent'::text THEN 'moulin_à_vent'::text
                    WHEN lower(b.type::text) = 'moulin à eau'::text THEN 'moulin_à_eau'::text
                    WHEN lower(b.type::text) = 'port'::text THEN 'port'::text
                    WHEN lower(b.type::text) = 'justice'::text THEN 'poteau_de_justice'::text
                    WHEN lower(b.type::text) = 'prieuré'::text THEN 'prieuré'::text
                    WHEN lower(b.type::text) = 'redoute'::text THEN 'redoute'::text
                    WHEN lower(b.type::text) = 'ville'::text THEN 'ville'::text
                    ELSE NULL::text
                END AS typerdf,
            NULL::character varying AS type_bd,
            NULL::character varying AS insee_l,
            NULL::character varying AS insee_c,
            NULL::character varying AS noman3,
            NULL::character varying AS nom1801,
            NULL::character varying AS nom1999,
            NULL::character varying AS type1794,
            NULL::character varying AS lien_site_cassini,
            NULL::boolean AS b_fortifiee,
            'The GeoHistoricalData group. http://geohistoricaldata.org' as creator
           FROM france_cassini_toponyms a
             JOIN types_ponctuels b ON a.type_id = b.id
        UNION ALL
         SELECT NULL::integer AS int4,
            france_cassini_chefs_lieux.gid AS id_cheflieu,
            NULL::boolean AS incertain,
            france_cassini_chefs_lieux.commentair AS commentaire,
            france_cassini_chefs_lieux.nomcart AS nom,
            '<http://data.ign.fr/id/ignf/crs/RGF93LAMB93> '||st_astext(france_cassini_chefs_lieux.geom) AS geom,
            '<http://www.opengis.net/def/crs/OGC/1.3/CRS84> '||st_astext(st_transform(france_cassini_chefs_lieux.geom, 4326)) AS geom_wgs84,
            NULL::boolean AS ruine,
            france_cassini_chefs_lieux.typecart AS type,
                CASE
                    WHEN lower(france_cassini_chefs_lieux.typecart::text) = 'autre'::text THEN 'lieu'::text
                    ELSE lower(france_cassini_chefs_lieux.typecart::text)
                END AS typerdf,
            france_cassini_chefs_lieux.type_bd,
            france_cassini_chefs_lieux.insee_l,
            regexp_replace(france_cassini_chefs_lieux.insee_c::text, '\s+'::text, ''::text) AS insee_c,
            france_cassini_chefs_lieux.noman3,
            france_cassini_chefs_lieux.nom1801,
            france_cassini_chefs_lieux.nom1999,
            france_cassini_chefs_lieux.type1794,
            france_cassini_chefs_lieux.lien_site_cassini,
            france_cassini_chefs_lieux.b_fortifiee,
	   'Claude Motte (LaDéHiS-CRH(UMR 8558)-EHESS), Marie-Christine Vouloir (LaDéHiS-CRH(UMR 8558)-EHESS) and the GeoHistoricalData group. http://geohistoricaldata.org' as creator
           FROM france_cassini_chefs_lieux) as x;
	
CREATE OR REPLACE VIEW travail.cassini_places_statuses AS 
 SELECT cassini_places.uid,
    'Commune1794'::text AS type,
    'Chef lieu communal'::text AS status,
    'Commune principal town'::text AS status_en,
    'http://data.geohistoricaldata.org/id/source/RecensementAnIII'::text AS source
   FROM travail.cassini_places
  WHERE type1794::text ~~* 'E'::text
UNION ALL
 SELECT uid,
    'Paroisse'::text AS type,
    'Chef lieu paroissial d''Ancien Régime'::text AS status,
    'Ancien Régime parish'::text AS status_en,
    'http://data.geohistoricaldata.org/id/source/GeoreferencedCassiniBnF'::text AS source
   FROM travail.cassini_places
  WHERE id_cheflieu IS NOT NULL AND cassini_places.type::text ~~* 'clocher'::text
UNION ALL
 SELECT uid,
    'Commune1999'::text AS type,
    'Chef lieu communal'::text AS status,
    'Commune principal town'::text AS status_en,
    'http://data.geohistoricaldata.org/id/source/BDCarto1999'::text AS source
   FROM travail.cassini_places
  WHERE type_bd::text = 'co'::text
UNION ALL
 SELECT uid,
    'Succursale'::text AS type,
    'Succursale paroissiale d''Ancien Régime'::text AS status,
    'Ancien Régime parish subsidiary'::text AS status_en,
    'http://data.geohistoricaldata.org/id/source/RecensementAnIII'::text AS source
   FROM travail.cassini_places
  WHERE type::text ~~* 'clocher succursale'::text;

--DROP VIEW  travail.cassini_places_placenames;
CREATE OR REPLACE VIEW travail.cassini_places_placenames AS
    SELECT x.nom,
    x.place_id,
    x.source,
    x.numero
   FROM ( SELECT nom,
            uid AS place_id,
            'http://data.geohistoricaldata.org/id/source/GeoreferencedCassiniBnF'::text AS source,
            1 AS numero
           FROM travail.cassini_places
        UNION ALL
         SELECT noman3,
            uid,
            'http://data.geohistoricaldata.org/id/source/RecensementAnIII'::text AS source,
            2
           FROM travail.cassini_places
        UNION ALL
         SELECT nom1801,
                uid,
            'http://data.geohistoricaldata.org/id/source/Recensement1801'::text AS source,
            3
           FROM travail.cassini_places
        UNION ALL
         SELECT nom1999,
            uid,
            'http://data.geohistoricaldata.org/id/source/BDCarto1999'::text AS source,
            4
           FROM travail.cassini_places) x
  WHERE x.nom IS NOT NULL AND x.nom::text ~* '[a-zA-Z]+'::text;

  SELECT * FROM travail.cassini_places

```

# Mercredi 12 septembre 2018

- la liste de typologies d'entités a été raffinée
- Définition des règles de mapping en R2RML entre la base de données SQL et l'ontologie : https://codeshare.io/5Q7D4W

# Mercredi 10 octobre 2018

- Amélioration des règles de mapping afin d'integrer le statut de communes
- la question sur l'attribution de droits d'auteurs a été reglée : au niveau du jeu de données, on pointe au projet GeohistoricalData et pour certaines données (place), le droit est attribué à Claude Motte 
- envoie d'un jeu de données en RDF à Karl Grossner pour avoir des retours sur le modèle.. 


# Post-traitements
Rechercher/remplacer sur : 
- Supprimer `        ghs:hasStatus            []  ;`
- Remplacer `http://data.geohistoricaldata.org/def/places/http://data.geohistoricaldata.org` par `http://data.geohistoricaldata.org`
- Supprimer les matches du regex `\[[^\.]+\] \.` : ce sont les blanknodes temporels qui 'traînent'.