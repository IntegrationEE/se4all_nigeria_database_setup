/*
Preprocess OpenStreetMap tables after import in public schema with osm2pgsql
Basic operations: 
0. grant
1. remove index
2. add column 'gid' serial
3. add primary keys
4. rename geo-column 'way' to 'geom'
6. add index
7. move tables to import schema

for information on import, see "osm_import.md" in the same folder

__copyright__   = "© Reiner Lemoine Institut © Integration Environment & Energy"
__license__     = "Creative Commons Zero v1.0 Universal (CC0-1.0)"
__url__         = "https://creativecommons.org/publicdomain/zero/1.0/"
__author__      = "Ludwig Hülk"
*/


-- se4all database log (version,io,schema_name,table_name,script_name,comment)
SELECT database_log('NESP2','v0','input','public','osm_nga_line','osm_import.md','verification');
SELECT database_log('NESP2','v0','input','public','osm_nga_nodes','osm_import.md','verification');
SELECT database_log('NESP2','v0','input','public','osm_nga_point','osm_import.md','verification');
SELECT database_log('NESP2','v0','input','public','osm_nga_polygon','osm_import.md','verification');
SELECT database_log('NESP2','v0','input','public','osm_nga_rels','osm_import.md','verification');
SELECT database_log('NESP2','v0','input','public','osm_nga_roads','osm_import.md','verification');
SELECT database_log('NESP2','v0','input','public','osm_nga_ways','osm_import.md','verification');

/*
-- Tests for the loops
-- Select all tables with OSM in public
SELECT     *
FROM     information_schema.tables
WHERE     table_schema = 'public'
    AND table_name LIKE 'osm_nga_%';

-- Select all tables with OSM in public
SELECT     * 
FROM     pg_tables
WHERE     schemaname='public'
    AND tablename LIKE 'osm_nga_%';

-- Select all indexes with OSM in public
SELECT     * 
FROM     pg_indexes
WHERE     schemaname='public'
    AND tablename LIKE 'osm_nga_%'
    AND indexname LIKE '%_pkey';
*/ 

-- 0. grant oeuser
DO
$$
DECLARE
    row record;
BEGIN
    FOR row IN SELECT tablename FROM pg_tables WHERE schemaname = 'public' AND tablename LIKE 'osm_nga_%'
    LOOP
        EXECUTE 'ALTER TABLE public.' || quote_ident(row.tablename) || ' OWNER TO grp_user;';
    END LOOP;
END;
$$;


-- 1. remove wrong index
-- 1.1 remove all wrong 'pkey' (_line, _point, _polygon, _roads)
DO
$$
DECLARE
    row record;
BEGIN
    FOR row IN SELECT indexname FROM pg_indexes 
    WHERE (schemaname='public' 
    AND indexname LIKE '%_pkey')
    AND (tablename LIKE '%_line'
    OR tablename LIKE '%_point'
    OR tablename LIKE '%_polygon'
    OR tablename LIKE '%_roads')
    LOOP
        EXECUTE 'DROP INDEX public.' || quote_ident(row.indexname) || ';';
    END LOOP;
END;
$$;

-- 1.2 remove all wrong other indexes (_line, _point, _polygon, _roads)
DO
$$
DECLARE
    row record;
BEGIN
    FOR row IN SELECT indexname FROM pg_indexes 
    WHERE (schemaname='public' 
    AND indexname LIKE '%_index')
    LOOP
        EXECUTE 'DROP INDEX public.' || quote_ident(row.indexname) || ';';
    END LOOP;
END;
$$;

-- 2. add column 'gid' serial
-- 3. add primary keys
-- 4. rename geo-column 'way' to 'geom'
DO
$$
DECLARE
    row record;
BEGIN
    FOR row IN SELECT tablename FROM pg_tables 
    WHERE schemaname='public' 
    AND (tablename LIKE '%_line'
    OR tablename LIKE '%_point'
    OR tablename LIKE '%_polygon'
    OR tablename LIKE '%_roads')
    LOOP
        EXECUTE 'ALTER TABLE public.' || quote_ident(row.tablename) || ' ADD gid SERIAL;';
        EXECUTE 'ALTER TABLE public.' || quote_ident(row.tablename) || ' ADD PRIMARY KEY (gid);';
        EXECUTE 'ALTER TABLE public.' || quote_ident(row.tablename) || ' RENAME COLUMN way TO geom;';
    END LOOP;
END;
$$;


-- 5. Set geometry and SRID (original!)

-- ALTER TABLE public.osm_nga_line
--     ALTER COLUMN geom TYPE geometry(LineString,3857) 
--         USING ST_SetSRID(geom,3857);
-- 
-- ALTER TABLE public.osm_nga_point
--     ALTER COLUMN geom TYPE geometry(Point,3857) 
--         USING ST_SetSRID(geom,3857);
-- 
-- ALTER TABLE public.osm_nga_polygon
--     ALTER COLUMN geom TYPE geometry(MultiPolygon, 3857) 
--         USING ST_SetSRID(ST_MULTI(geom),3857);
-- 
-- ALTER TABLE public.osm_nga_roads
--     ALTER COLUMN geom TYPE geometry(LineString,3857) 
--         USING ST_SetSRID(geom,3857);


-- 6. add index
-- 6.1 add indexes GIST (geom)
DO
$$
DECLARE
    row record;
BEGIN
    FOR row IN SELECT tablename FROM pg_tables 
    WHERE schemaname='public' 
    AND (tablename LIKE '%_line'
    OR tablename LIKE '%_point'
    OR tablename LIKE '%_polygon'
    OR tablename LIKE '%_roads')
    LOOP
        EXECUTE 'CREATE INDEX ' || quote_ident(row.tablename) || '_geom_idx ON public.' || quote_ident(row.tablename) || ' USING gist (geom);';
    END LOOP;
END;
$$;

-- 6.2 Add indexes GIN (tags)
DO
$$
DECLARE
    row record;
BEGIN
    FOR row IN SELECT tablename FROM pg_tables 
    WHERE schemaname='public' 
    AND (tablename LIKE '%_line'
    OR tablename LIKE '%_point'
    OR tablename LIKE '%_polygon'
    OR tablename LIKE '%_roads')
    LOOP
        EXECUTE 'CREATE INDEX ' || quote_ident(row.tablename) || '_tags_idx ON public.' || quote_ident(row.tablename) || ' USING GIN (tags);';
    END LOOP;
END;
$$;



-- 7. move tables to osm schema
DO
$$
DECLARE
    row record;
BEGIN
    FOR row IN SELECT tablename FROM pg_tables WHERE schemaname = 'public' AND tablename LIKE 'osm_nga_%'
    LOOP
        EXECUTE 'ALTER TABLE public.' || quote_ident(row.tablename) || ' SET SCHEMA import;';
    END LOOP;
END;
$$;

-- ego database log (version,io,schema_name,table_name,script_name,comment)
SELECT database_log('NESP2','v0','preprocessing','import','osm_nga_line','osm_import_postprocessing.sql','setup osm tables');
SELECT database_log('NESP2','v0','preprocessing','import','osm_nga_nodes','osm_import_postprocessing.sql','setup osm tables');
SELECT database_log('NESP2','v0','preprocessing','import','osm_nga_point','osm_import_postprocessing.sql','setup osm tables');
SELECT database_log('NESP2','v0','preprocessing','import','osm_nga_polygon','osm_import_postprocessing.sql','setup osm tables');
SELECT database_log('NESP2','v0','preprocessing','import','osm_nga_rels','osm_import_postprocessing.sql','setup osm tables');
SELECT database_log('NESP2','v0','preprocessing','import','osm_nga_roads','osm_import_postprocessing.sql','setup osm tables');
SELECT database_log('NESP2','v0','preprocessing','import','osm_nga_ways','osm_import_postprocessing.sql','setup osm tables');
