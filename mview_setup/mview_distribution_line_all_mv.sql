/*
Create materialized view of distribution_line_all

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/data_import/adm1_import.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/

DROP MATERIALIZED VIEW IF EXISTS se4all.distribution_line_all_mv;
CREATE MATERIALIZED VIEW se4all.distribution_line_all_mv (
    source,
    distribution_line_id,
    source_distribution_line_id,
    name                ,
    description         ,
    condition           ,
    voltage_kv          ,
    length_km           ,
    geom               ) AS
SELECT * FROM se4all.distribution_line_kaduna_electric 
UNION ALL 
SELECT * FROM se4all.distribution_line_kedco
UNION ALL
SELECT * FROM se4all.distribution_line_se4all;

CREATE UNIQUE INDEX distribution_line_all_mv_idx
    ON se4all.distribution_line_all_mv (source_distribution_line_id);

-- index GIST (geom)
CREATE INDEX distribution_line_all_mv_geom_idx
    ON se4all.distribution_line_all_mv USING GIST (geom);

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','distribution_line_all_mv','mview_distribution_line_all_mv.sql','Add materialised view');