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
INSERT INTO se4all.distribution_line_kedco (name, description, geom)
SELECT name, other_tags, ST_Transform(geom,3857)
FROM import.kedco_grid_data_simplified_06172015_with_overlaps_removed;

-- update area
UPDATE se4all.distribution_line_kedco * 
SET length_km = (ST_Length(ST_Transform(geom,3857))/(1000));

-- update source
UPDATE se4all.distribution_line_kedco *
SET source = 'kedco';

-- update source and distribution line id
UPDATE se4all.distribution_line_kedco *
SET source_distribution_line_kedco_id = source || '_' || distribution_line_kedco_id;

-- update voltage only if 11 kV or 33 kV
UPDATE se4all.distribution_line_kedco 
SET voltage_kv = (description::hstore -> 'voltage')::INTEGER
WHERE ((description::hstore -> 'voltage') = '11')
OR ((description::hstore -> 'voltage') = '33');

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','distribution_line_kedco','distribution_line_kedco_processing.sql','Insert data');