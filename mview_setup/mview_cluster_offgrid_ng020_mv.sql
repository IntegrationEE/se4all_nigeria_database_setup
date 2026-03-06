/*
Create materialized view of cluster_offgrid for ng020

1. Create temporary materialized view for the buffer with selected state and removing very small buildings
2. Create temporary materialized view for the negative buffer
3. Count number of buildings within the cluster
4. Fill holes and remove clusters with a count of 6 buildings or less
5. Create final materialized view

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/data_import/adm1_import.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/

-- 1. Create temporary materialized view for the buffer with selected state and removing very small buildings
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_ng020_buffer_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.cluster_offgrid_ng020_buffer_mv AS
SELECT
    g.path[1] AS gid,
    g.geom::geometry(Polygon, 3857) AS geom
FROM
    (SELECT 
        (ST_Dump(ST_Union(ST_Buffer(s_jobdlabm.geom, 50)))).*
    FROM se4all.join_osm_building_distribution_line_all_buffer_mv AS s_jobdlabm
    WHERE s_jobdlabm.adm1_pcode = 'NG020' AND s_jobdlabm.area_m2 > 4)
AS g;

-- 2. Create temporary materialized view for the negative buffer
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_ng020_negative_buffer_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.cluster_offgrid_ng020_negative_buffer_mv AS
SELECT
    g.path[1] AS gid,
    g.geom::geometry(Polygon, 3857) AS geom
FROM
    (SELECT 
        (ST_Dump(ST_Union(ST_Buffer(s_cobm.geom, -40)))).*
    FROM se4all.cluster_offgrid_ng020_buffer_mv AS s_cobm)
AS g;

-- 3. Count number of buildings within the cluster
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_ng020_count_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.cluster_offgrid_ng020_count_mv AS
SELECT
    s_conbm.gid, 
    COUNT(s_jobdlabm.geom) AS building_count,
    SUM(s_jobdlabm.area_m2)/(1000*1000) AS building_area_km2,
    s_conbm.geom AS geom
FROM se4all.cluster_offgrid_ng020_negative_buffer_mv AS s_conbm 
LEFT JOIN se4all.join_osm_building_distribution_line_all_buffer_mv AS s_jobdlabm 
ON ST_Contains(s_conbm.geom,s_jobdlabm.geom)
GROUP BY s_conbm.gid, s_conbm.geom;

-- 4. Fill holes and remove clusters with a count of 6 buildings or less
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_ng020_filter_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.cluster_offgrid_ng020_filter_mv AS
SELECT
    s_concm.gid, 
    s_concm.building_count,
    s_concm.building_area_km2,
    ST_MakePolygon(ST_ExteriorRing(s_concm.geom)) AS geom
FROM se4all.cluster_offgrid_ng020_count_mv AS s_concm 
WHERE s_concm.building_count > 6;

-- 5. Create final materialized view
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_ng020_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.cluster_offgrid_ng020_mv AS
SELECT
    s_confm.gid, 
    ST_Area(s_confm.geom)/(1000*1000) AS area_km2,
    s_confm.building_count,
    COUNT(s_jobdlabm.geom) AS large_building_count,
    COUNT(s_jobdlabm.geom)/s_confm.building_count::real AS percentage_large_building,
    s_confm.building_area_km2,
    s_confm.building_count/(ST_Area(s_confm.geom)/(1000*1000)) AS building_count_density_perkm2,
    s_confm.building_area_km2/(ST_Area(s_confm.geom)/(1000*1000)) AS percentage_building_area,
    s_confm.geom
FROM se4all.cluster_offgrid_ng020_filter_mv AS s_confm 
LEFT OUTER JOIN (SELECT * FROM se4all.join_osm_building_distribution_line_all_buffer_mv WHERE area_m2 > 49) AS s_jobdlabm 
ON ST_Contains(s_confm.geom,s_jobdlabm.geom)
GROUP BY s_confm.gid, s_confm.geom, s_confm.building_count, s_confm.building_area_km2;

-- index GIST (geom)
CREATE INDEX cluster_offgrid_ng020_mv_geom_idx
    ON se4all.cluster_offgrid_ng020_mv USING GIST(geom);

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_offgrid_ng020_mv','mview_cluster_offgrid_ng020_mv.sql','Add materialised view');