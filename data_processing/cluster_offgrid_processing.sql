/*
Import of data from cluster_offgrid views

Basic functions:
1. Create materialized view by union all on all state level views
2. Create geospatial union of the materialized views
3. Spatial join on the data joining the geospatial union with the data
4. Filter duplicate entries and select areas with largest area
5. Insert data from cluster_offgrid and delete temporary materialized views

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/data_import/adm1_import.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/

-- 1. Create materialized view by union all on all state level views
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_temp_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.cluster_offgrid_temp_mv AS
SELECT * FROM se4all.cluster_offgrid_ng018_mv 
UNION ALL 
SELECT * FROM se4all.cluster_offgrid_ng020_mv 
UNION ALL 
SELECT * FROM se4all.cluster_offgrid_ng021_mv 
UNION ALL 
SELECT * FROM se4all.cluster_offgrid_ng026_mv
UNION ALL 
SELECT * FROM se4all.cluster_offgrid_ng034_mv;

-- 2. Create geospatial union of the materialized views
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_temp_union_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.cluster_offgrid_temp_union_mv AS
SELECT
    g.path[1] AS gid,
    g.geom::geometry(Polygon, 3857) AS geom
FROM
    (SELECT 
        (ST_Dump(ST_Union(s_cotm.geom))).*
    FROM se4all.cluster_offgrid_temp_mv AS s_cotm)
AS g;

-- 3. Spatial join on the data joining the geospatial union with the data
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_temp_join_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.cluster_offgrid_temp_join_mv AS
SELECT
    s_cotum.gid, 
    s_cotm.area_km2,
    s_cotm.building_count,
    s_cotm.large_building_count,
    s_cotm.percentage_large_building,
    s_cotm.building_area_km2,
    s_cotm.building_count_density_perkm2,
    s_cotm.percentage_building_area,
    s_cotum .geom
FROM se4all.cluster_offgrid_temp_union_mv AS s_cotum 
LEFT OUTER JOIN se4all.cluster_offgrid_temp_mv AS s_cotm 
ON ST_Intersects(s_cotum.geom, s_cotm.geom);

-- 4. Filter duplicate entries and select areas with largest area 
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_temp_distinct_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.cluster_offgrid_temp_distinct_mv AS
SELECT DISTINCT ON (gid) *
FROM se4all.cluster_offgrid_temp_join_mv
ORDER BY gid, area_km2 DESC;

-- 5. Insert data from cluster_offgrid and delete temporary materialized views
INSERT INTO se4all.cluster_offgrid (area_km2, building_count, large_building_count, percentage_large_building, building_area_km2, building_count_density_perkm2, percentage_building_area, geom)
SELECT     area_km2, building_count, large_building_count, percentage_large_building, building_area_km2, building_count_density_perkm2, percentage_building_area, geom
FROM se4all.cluster_offgrid_temp_distinct_mv
WHERE area_km2 > 0.01;
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_temp_mv CASCADE;
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_temp_union_mv CASCADE;
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_temp_join_mv CASCADE;
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_temp_distinct_mv CASCADE;

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_offgrid','cluster_offgrid_processing.sql','Insert data');