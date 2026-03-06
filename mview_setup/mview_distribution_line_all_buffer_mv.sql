/*
Create materialized view of distribution_line_all_buffer

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/data_import/adm1_import.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/

-- Buffer adm1 boundaries table by a set value and create a new materialized view

DROP MATERIALIZED VIEW IF EXISTS se4all.distribution_line_all_buffer_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.distribution_line_all_buffer_mv(
    source,
    geom) AS
SELECT 
    source,
    ST_Union(ST_Buffer(geom, 1000)) -- The buffer distance around admin areas is defined here
FROM se4all.distribution_line_all_mv
GROUP BY source;

-- index GIST (geom)
CREATE INDEX distribution_line_all_buffer_mv_geom_idx
    ON se4all.distribution_line_all_buffer_mv USING GIST (geom);

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','distribution_line_all_buffer_mv','mview_distribution_line_all_buffer_mv.sql','Add materialised view');
