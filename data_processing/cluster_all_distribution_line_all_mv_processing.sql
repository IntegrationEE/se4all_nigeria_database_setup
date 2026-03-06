/*
Processing data for cluster all dataset and distance relation between the distribution line dataset.
Basic operations:

1. Calculate clusters intersecting with the grid and set the distance as 0
2. Create temporary materialized view for the buffered adm1 area joined with the cluster
3. Create temporary materialized view for the buffered adm1 area joined with the distribution line
4. Create temporary materialized view calculating the minimum distance to the distribution line for each cluster
5. Insert calculated values into the table
6. Delete temporary materialized views

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/data_import/adm1_import.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/

-- 1. Calculate clusters intersecting with the grid and set the distance as 0
UPDATE se4all.cluster_all AS s_ca
SET grid_dist_km = 0 
FROM se4all.distribution_line_all_mv AS s_dlam
WHERE ST_Intersects(s_ca.geom, s_dlam.geom);

-- 2. Create temporary materialized view for the buffered adm1 area joined with the cluster
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_all_adm1_buffer_temp_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.cluster_all_adm1_buffer_temp_mv AS
SELECT 
    s_ca.*,
    s_babm.adm1_pcode
FROM se4all.cluster_all AS s_ca
LEFT JOIN se4all.boundary_adm1_buffer_mv AS s_babm
    ON ST_Intersects(s_ca.geom, s_babm.geom)
	WHERE s_ca.geom && s_babm.geom;

-- 3. Create temporary materialized view for the buffered adm1 area joined with the distribution line
DROP MATERIALIZED VIEW IF EXISTS se4all.distribution_line_all_adm1_buffer_temp_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.distribution_line_all_adm1_buffer_temp_mv AS
SELECT 
    s_dlam.*,
    s_babm.adm1_pcode
FROM se4all.distribution_line_all_mv AS s_dlam
LEFT JOIN se4all.boundary_adm1_buffer_mv AS s_babm
    ON ST_Intersects(s_dlam.geom, s_babm.geom)
	WHERE s_dlam.geom && s_babm.geom;

-- 4. Create temporary materialized view calculating the minimum distance to the distribution line for each cluster
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_all_distribution_line_temp_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.cluster_all_distribution_line_temp_mv AS
SELECT DISTINCT ON (s_caabtm.cluster_all_id) s_caabtm.cluster_all_id, ST_Distance(s_caabtm.geom,s_dlaabtm.geom)
FROM    se4all.cluster_all_adm1_buffer_temp_mv AS s_caabtm,
		se4all.distribution_line_all_adm1_buffer_temp_mv AS s_dlaabtm
	WHERE ST_DWithin(s_caabtm.geom,s_dlaabtm.geom, 50000) -- Are within 50km
        AND s_caabtm.adm1_pcode = s_dlaabtm.adm1_pcode -- Are within the same adm boundary
        AND (grid_dist_km != 0 OR grid_dist_km IS NULL) -- Must be a number greater than zero OR must be NULL
	ORDER BY 	s_caabtm.cluster_all_id,
		ST_Distance(s_caabtm.geom,s_dlaabtm.geom);

-- 5. Insert calculated values into the table
UPDATE se4all.cluster_all AS s_ca
SET grid_dist_km = s_adltm.st_distance/1000
FROM se4all.cluster_all_distribution_line_temp_mv AS s_adltm
WHERE s_ca.cluster_all_id = s_adltm.cluster_all_id;

-- 6. Delete temporary materialized views
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_all_adm1_buffer_temp_mv CASCADE;
DROP MATERIALIZED VIEW IF EXISTS se4all.distribution_line_all_adm1_buffer_temp_mv CASCADE;
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_all_distribution_line_temp_mv CASCADE;

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_all','cluster_all_distribution_line_all_mv_processing.sql','Process data');