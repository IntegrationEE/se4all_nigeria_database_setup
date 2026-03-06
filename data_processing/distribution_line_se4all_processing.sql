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
INSERT INTO se4all.distribution_line_se4all (name, description, condition, geom)
SELECT name, '"voltage_kv"=>"' || tl || '","layer"=>"' || layer || '"', tl_conditi, ST_Transform(geom,3857)
FROM import."wo4-eng-1-11kv";
INSERT INTO se4all.distribution_line_se4all (name, description, condition, geom)
SELECT name, '"voltage_kv"=>"' || tl || '","layer"=>"' || layer  || '"', tl_conditi, ST_Transform(geom,3857)
FROM import."wo4-eng-1-33kv";
INSERT INTO se4all.distribution_line_se4all (name, description, condition, geom)
SELECT name, '"voltage_kv"=>"' || tl_type || '","layer"=>"' || layer || '"', tl_conditi, ST_Transform(geom,3857)
FROM import."wo5-osn-1-11kv";
INSERT INTO se4all.distribution_line_se4all (name, description, condition, geom)
SELECT name, '"voltage_kv"=>"' || tl_type || '","layer"=>"' || layer || '"', tl_conditi, ST_Transform(geom,3857) 
FROM import."wo5-osn-1-33kv";
INSERT INTO se4all.distribution_line_se4all (name, description, condition, geom)
SELECT name, '"voltage_kv"=>"' || tl_type || '","layer"=>"' || layer || '"', tl_conditi, ST_Transform(geom,3857) 
FROM import."wo6-nsr-1-11kv";
INSERT INTO se4all.distribution_line_se4all (name, description, condition, geom)
SELECT name, '"voltage_kv"=>"' || tl_type || '","layer"=>"' || layer || '"', tl_conditi, ST_Transform(geom,3857) 
FROM import."wo6-nsr-1-33kv";
INSERT INTO se4all.distribution_line_se4all (name, description, condition, geom)
SELECT name, '"voltage_kv"=>"' || tl_type || '","layer"=>"' || layer || '"', tl_conditi, ST_Transform(geom,3857) 
FROM import."wo11-ed-1-11kv";
INSERT INTO se4all.distribution_line_se4all (name, description, condition, geom)
SELECT name, '"voltage_kv"=>"' || tl_type || '","layer"=>"' || layer || '"', tl_conditi, ST_Transform(geom,3857) 
FROM import."wo11-ed-1-33kv";
INSERT INTO se4all.distribution_line_se4all (name, description, condition, geom)
SELECT name, '"voltage_kv"=>"' || tl_type || '","layer"=>"' || layer || '"', tl_conditi, ST_Transform(geom,3857) 
FROM import."wo12-kg-1-11kv";
INSERT INTO se4all.distribution_line_se4all (name, description, condition, geom)
SELECT name, '"voltage_kv"=>"' || tl_type || '","layer"=>"' || layer || '"', tl_conditi, ST_Transform(geom,3857) 
FROM import."wo12-kg-1-33kv";
INSERT INTO se4all.distribution_line_se4all (name, description, condition, geom)
SELECT name, '"voltage_kv"=>"' || tl_type || '","layer"=>"' || layer || '"', tl_conditi, ST_Transform(geom,3857) 
FROM import."wo13-kwr-1-11kv";
INSERT INTO se4all.distribution_line_se4all (name, description, condition, geom)
SELECT name, '"voltage_kv"=>"' || tl_type || '","layer"=>"' || layer || '"', tl_conditi, ST_Transform(geom,3857) 
FROM import."wo13-kwr-1-33kv";

-- update the kv level for numerical values
-- still need to resolve "both" values and copy the data
UPDATE se4all.distribution_line_se4all
SET voltage_kv = TRIM(BOTH 'kv' FROM (description::hstore -> 'voltage_kv'))::INTEGER
WHERE (description::hstore -> 'voltage_kv') = '11kv' OR (description::hstore -> 'voltage_kv') = '33kv';

-- update length
UPDATE se4all.distribution_line_se4all * 
SET length_km = (ST_Length(ST_Transform(geom,3857))/(1000));

-- update source
UPDATE se4all.distribution_line_se4all *
SET source = 'se4all';

-- update source and distribution line id
UPDATE se4all.distribution_line_se4all *
SET source_distribution_line_se4all_id = source || '_' || distribution_line_se4all_id;

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','distribution_line_se4all','distribution_line_se4all_processing.sql','Insert data');