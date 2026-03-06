/*
Processing data for cluster all dataset and distance relation between the distribution line dataset.
Basic operations:

1. Create temporary materialized view for the buffered adm1 area joined with the cluster
2. Create temporary materialized view for the buffered adm1 area joined with the distribution line
3. Create temporary materialized view calculating the minimum distance to the distribution line for each cluster
4. Insert calculated values into the table
5. Delete temporary materialized views

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/data_import/adm1_import.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/

-- 1. Create temporary materialized view for the buffered adm1 area joined with the cluster
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_adm1_buffer_temp_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.cluster_offgrid_adm1_buffer_temp_mv AS
SELECT 
    s_co.*,
    s_babm.adm1_pcode
FROM se4all.cluster_offgrid AS s_co
LEFT JOIN se4all.boundary_adm1_buffer_mv AS s_babm
    ON ST_Intersects(s_co.geom, s_babm.geom)
	WHERE s_co.geom && s_babm.geom;

-- 2. Create temporary materialized view for the buffered adm1 area joined with the distribution line
DROP MATERIALIZED VIEW IF EXISTS se4all.distribution_line_all_adm1_buffer_temp_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.distribution_line_all_adm1_buffer_temp_mv AS
SELECT 
    s_dlam.*,
    s_babm.adm1_pcode
FROM se4all.distribution_line_all_mv AS s_dlam
LEFT JOIN se4all.boundary_adm1_buffer_mv AS s_babm
    ON ST_Intersects(s_dlam.geom, s_babm.geom)
	WHERE s_dlam.geom && s_babm.geom;

-- 3. Create temporary materialized view calculating the minimum distance to the distribution line for each cluster
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_distribution_line_temp_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.cluster_offgrid_distribution_line_temp_mv AS
SELECT DISTINCT ON (s_coabtm.cluster_offgrid_id) s_coabtm.cluster_offgrid_id, ST_Distance(s_coabtm.geom,s_dlaabtm.geom)
FROM    se4all.cluster_offgrid_adm1_buffer_temp_mv AS s_coabtm,
		se4all.distribution_line_all_adm1_buffer_temp_mv AS s_dlaabtm
	WHERE ST_DWithin(s_coabtm.geom,s_dlaabtm.geom, 50000) -- Are within 50km
        AND s_coabtm.adm1_pcode = s_dlaabtm.adm1_pcode -- Are within the same adm boundary
	ORDER BY 	s_coabtm.cluster_offgrid_id,
		ST_Distance(s_coabtm.geom,s_dlaabtm.geom);

-- 4. Insert calculated values into the table
UPDATE se4all.cluster_offgrid AS s_co
SET grid_dist_km = s_adltm.st_distance/1000
FROM se4all.cluster_offgrid_distribution_line_temp_mv AS s_adltm
WHERE s_co.cluster_offgrid_id = s_adltm.cluster_offgrid_id;

-- 6. Delete temporary materialized views
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_adm1_buffer_temp_mv CASCADE;
DROP MATERIALIZED VIEW IF EXISTS se4all.distribution_line_all_adm1_buffer_temp_mv CASCADE;
DROP MATERIALIZED VIEW IF EXISTS se4all.cluster_offgrid_distribution_line_temp_mv CASCADE;

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_offgrid','cluster_offgrid_distribution_line_all_mv_processing.sql','Process data');