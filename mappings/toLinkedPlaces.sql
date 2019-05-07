SELECT 
  json_build_object(
    'type','FeatureCollection', 
    '@context', 'https://raw.githubusercontent.com/LinkedPasts/linked-places/master/linkedplaces-context-v1.jsonld',
    'features', array_to_json(array_agg(features.feature))
  )
FROM (
  SELECT 
    json_build_object(
      '@id', feature_attributes.uid,
      'type', 'Feature',
      'properties', feature_attributes._properties,
      'when', feature_attributes._when,
      'names', feature_attributes._names,
      'types', feature_attributes._types,
      'geometry', feature_attributes._geometry,
      'descriptions', feature_attributes._descriptions
    ) as feature
  FROM 
  (
    SELECT uid,
    -- BLOCK PROPERTIES
    json_build_object(
      'title', CASE WHEN nom IS NOT NULL THEN nom ELSE typerdf END,
      'ccodes', json_build_array('FR') 
    ) as _properties,
    -- BLOCK WHEN
    json_build_object(
      'timespans', json_build_array(
        json_build_object(
          'start', json_build_object(
            'latest', '1755%' -- D'après la date estimée de début de levé de la planche de Laon
          )
        )
      )
    ) as _when,
    -- BLOCK NAMES
    array_to_json(array_remove(ARRAY[
      CASE WHEN nom IS NOT NULL THEN 
      jsonb_build_object(
        'toponym', nom,
        'lang', 'fr',
        'citations', json_build_array(json_build_object('label', 'Carte Générale et Particulière de la France, dite Carte de Cassini (1756-1815~)')),
        'when', json_build_object('start', json_build_object('latest', '1755%'))
      )
      END,
      CASE WHEN noman3 IS NOT NULL THEN
      jsonb_build_object(
        'toponym', noman3,
        'lang', 'fr',
        'when', json_build_object('start', json_build_object('latest', '1794'))
      )
      END,
      CASE WHEN nom1801 IS NOT NULL THEN
      jsonb_build_object(
        'toponym', nom1801,
        'lang', 'fr',
        'when', json_build_object('start', json_build_object('latest', '1801'))
      )
      END,
      CASE WHEN nom1999 IS NOT NULL THEN
      jsonb_build_object(
        'toponym', nom1999,
        'lang', 'fr',
        'when', json_build_object('start', json_build_object('latest', '1998'))
      )
      END
      ],null)
    ) as _names,
    -- BLOCK TYPES
    array_to_json(array_remove(ARRAY[
        CASE WHEN type_bd IS NULL THEN
        jsonb_build_object(
          'identifier', 'http://data.geohistoricaldata.org/id/cassini/legend/'||cp.typerdf,
          'label', cp.typerdf
        )
        END,
        CASE WHEN type_bd IS NOT NULL THEN
        jsonb_build_object(
          'identifier', 'http://data.geohistoricaldata.org/id/cassini/legend/'||cp.typerdf,
          'label', cp.typerdf,
          'when', json_build_object('end', json_build_object('earliest', '1794'))
        )
        END,
        CASE WHEN type_bd = 'ac' THEN
        jsonb_build_object(
          'identifier', 'http://vocab.getty.edu/aat/300387330',
          'label', 'commune',
          'when', json_build_object('start', json_build_object('earliest', '1794'), 'end', json_build_object('latest', '1999'))
        )
        END,
        CASE WHEN type_bd = 'co' THEN
        jsonb_build_object(
          'identifier', 'http://vocab.getty.edu/aat/300387330',
          'label', 'commune',
          'when', json_build_object('start', json_build_object('earliest', '1794'))
        )
        END        
      ], null)
    ) as _types,
    -- BLOCK GEOMETRY
    jsonb_build_object(
      'type', 'GeometryCollection',
      'geometries', json_build_array(
        json_build_object(
          'type', 'Point',
          'coordinates', json_build_array(substring(geom_wgs84 FROM '.+\s\S+\((\S+)\s\S+\)')::float, substring(geom_wgs84 FROM '.+\s\S+\(\S+\s(\S+)\)')::float),
          'geo_wkt', substring(geom_wgs84 FROM '.+\s(\S+\(\S+\s\S+\))'),
          'when', json_build_object('start', json_build_object('latest', '1755%'))
        )
      )
    ) as _geometry,
    -- BLOCK LINKS
    array_to_json(array_remove(ARRAY[
      CASE WHEN type_bd = 'co'  THEN
        jsonb_build_object(
          'identifier', 'http://id.insee.fr/geo/commune/'||insee_c,
          'label', insee_c
        )
      END
    ], null)
    ) as _links,
    -- BLOCK DESCRIPTIONS
    array_to_json(array_remove(ARRAY[
      CASE WHEN type_bd IS NOT NULL THEN
        jsonb_build_object(
          'lang', 'fr',
          'source', lien_site_cassini
        )
      END
    ], null)
    ) as _descriptions
    FROM travail.cassini_places AS cp
  ) AS feature_attributes
) AS features
