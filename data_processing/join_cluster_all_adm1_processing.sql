/*
Processing data join table for cluster all dataset and boundary adm1.
Basic operations:
1. Buffer adm1 boundaries table by a set value and create new temporary table
2. Join clusters by location and insert values into the join table
3. Delete temporary cluster table

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/data_import/adm1_import.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/

-- 1. Buffer adm1 boundaries table by a set value and create a new temporary table

CREATE TABLE public.boundary_adm1_buffer(
    adm1_pcode,
    geom) AS
SELECT 
    adm1_pcode, 
    ST_Buffer(geom, 10000) -- The buffer distance around admin areas is defined here
FROM se4all.boundary_adm1;

-- 2. Join clusters by location and insert values into the join table

--DELETE FROM se4all.join_cluster_all_adm1;
INSERT INTO se4all.join_cluster_all_adm1 (
    cluster_all_id, 
    adm1_pcode)
SELECT  
    s_ca.cluster_all_id,
    p_bab.adm1_pcode
FROM se4all.cluster_all AS s_ca
LEFT JOIN public.boundary_adm1_buffer AS p_bab
    ON ST_Intersects(s_ca.geom, p_bab.geom);

-- 3. Delete temporary cluster table

DROP TABLE IF EXISTS public.boundary_adm1_buffer CASCADE;

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','join_cluster_all_adm1','join_cluster_all_adm1_processing.sql','Process data');
