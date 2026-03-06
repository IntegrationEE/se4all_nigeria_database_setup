/*
Import of data from import schema

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/data_import/adm1_import.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/

-- insert data from import
INSERT INTO se4all.cluster_all (fid, geom)
SELECT fid, ST_Transform(geom,3857)
FROM import.cluster_all_import
WHERE (ST_Area(ST_Transform(geom,3857))/(1000*1000)) > 0.01;

-- update area
UPDATE se4all.cluster_all * 
SET area_km2 = (ST_Area(ST_Transform(geom,3857))/(1000*1000));

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_all','cluster_all_processing.sql','Insert data');