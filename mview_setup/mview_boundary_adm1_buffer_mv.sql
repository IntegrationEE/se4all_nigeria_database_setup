/*
Create materialized view of boundary_adm1_buffer

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

DROP MATERIALIZED VIEW IF EXISTS se4all.boundary_adm1_buffer_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.boundary_adm1_buffer_mv(
    adm1_pcode,
    adm1_en,
    geom) AS
SELECT 
    adm1_pcode,
    adm1_en, 
    ST_Buffer(geom, 10000) -- The buffer distance around admin areas is defined here
FROM se4all.boundary_adm1;

-- index GIST (geom)
CREATE INDEX boundary_adm1_buffer_mv_geom_idx
    ON se4all.boundary_adm1_buffer_mv USING GIST (geom);

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','boundary_adm1_buffer_mv','mview_boundary_adm1_buffer_mv.sql','Add materialised view');
