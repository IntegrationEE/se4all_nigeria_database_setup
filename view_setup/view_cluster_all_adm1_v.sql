/*

Create view

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/database_setup/se4all_setup_schema.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/

-- views
--ng001
CREATE OR REPLACE VIEW se4all.cluster_all_ng001_v  AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG001' AND s_ca.area_km2>0.01;

--ng002
CREATE OR REPLACE VIEW se4all.cluster_all_ng002_v  AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG002' AND s_ca.area_km2>0.01;

--ng003
CREATE OR REPLACE VIEW se4all.cluster_all_ng003_v  AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG003' AND s_ca.area_km2>0.01;

--ng004
CREATE OR REPLACE VIEW se4all.cluster_all_ng004_v  AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG004' AND s_ca.area_km2>0.01;

--ng005
CREATE OR REPLACE VIEW se4all.cluster_all_ng005_v  AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG005' AND s_ca.area_km2>0.01;

--ng006
CREATE OR REPLACE VIEW se4all.cluster_all_ng006_v  AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG006' AND s_ca.area_km2>0.01;

--ng007
CREATE OR REPLACE VIEW se4all.cluster_all_ng007_v  AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG007' AND s_ca.area_km2>0.01;

--ng008
CREATE OR REPLACE VIEW se4all.cluster_all_ng008_v  AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG008' AND s_ca.area_km2>0.01;

--ng009
CREATE OR REPLACE VIEW se4all.cluster_all_ng009_v  AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG009' AND s_ca.area_km2>0.01;

--ng010
CREATE OR REPLACE VIEW se4all.cluster_all_ng010_v  AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG010' AND s_ca.area_km2>0.01;

--ng011
CREATE OR REPLACE VIEW se4all.cluster_all_ng011_v  AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG011' AND s_ca.area_km2>0.01;

--ng012
CREATE OR REPLACE VIEW se4all.cluster_all_ng012_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG012' AND s_ca.area_km2>0.01;

--ng013
CREATE OR REPLACE VIEW se4all.cluster_all_ng013_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG013' AND s_ca.area_km2>0.01;

--ng014
CREATE OR REPLACE VIEW se4all.cluster_all_ng014_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG014' AND s_ca.area_km2>0.01;

--ng015
CREATE OR REPLACE VIEW se4all.cluster_all_ng015_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG015' AND s_ca.area_km2>0.01;

--ng016
CREATE OR REPLACE VIEW se4all.cluster_all_ng016_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG016' AND s_ca.area_km2>0.01;

--ng017
CREATE OR REPLACE VIEW se4all.cluster_all_ng017_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG017' AND s_ca.area_km2>0.01;

--ng018
CREATE OR REPLACE VIEW se4all.cluster_all_ng018_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG018' AND s_ca.area_km2>0.01;

--ng019
CREATE OR REPLACE VIEW se4all.cluster_all_ng019_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG019' AND s_ca.area_km2>0.01;

--ng020
CREATE OR REPLACE VIEW se4all.cluster_all_ng020_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG020' AND s_ca.area_km2>0.01;

--ng021
CREATE OR REPLACE VIEW se4all.cluster_all_ng021_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG021' AND s_ca.area_km2>0.01;

--ng022
CREATE OR REPLACE VIEW se4all.cluster_all_ng022_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG022' AND s_ca.area_km2>0.01;

--ng023
CREATE OR REPLACE VIEW se4all.cluster_all_ng023_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG023' AND s_ca.area_km2>0.01;

--ng024
CREATE OR REPLACE VIEW se4all.cluster_all_ng024_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG024' AND s_ca.area_km2>0.01;

--ng025
CREATE OR REPLACE VIEW se4all.cluster_all_ng025_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG025' AND s_ca.area_km2>0.01;

--ng026
CREATE OR REPLACE VIEW se4all.cluster_all_ng026_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG026' AND s_ca.area_km2>0.01;

--ng027
CREATE OR REPLACE VIEW se4all.cluster_all_ng027_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG027' AND s_ca.area_km2>0.01;

--ng028
CREATE OR REPLACE VIEW se4all.cluster_all_ng028_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG028' AND s_ca.area_km2>0.01;

--ng029
CREATE OR REPLACE VIEW se4all.cluster_all_ng029_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG029' AND s_ca.area_km2>0.01;

--ng030
CREATE OR REPLACE VIEW se4all.cluster_all_ng030_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG030' AND s_ca.area_km2>0.01;

--ng031
CREATE OR REPLACE VIEW se4all.cluster_all_ng031_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG031' AND s_ca.area_km2>0.01;

--ng032
CREATE OR REPLACE VIEW se4all.cluster_all_ng032_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG032' AND s_ca.area_km2>0.01;

--ng033
CREATE OR REPLACE VIEW se4all.cluster_all_ng033_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG033' AND s_ca.area_km2>0.01;

--ng034
CREATE OR REPLACE VIEW se4all.cluster_all_ng034_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG034' AND s_ca.area_km2>0.01;

--ng035
CREATE OR REPLACE VIEW se4all.cluster_all_ng035_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG035' AND s_ca.area_km2>0.01;

--ng036
CREATE OR REPLACE VIEW se4all.cluster_all_ng036_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG036' AND s_ca.area_km2>0.01;

--ng037
CREATE OR REPLACE VIEW se4all.cluster_all_ng037_v AS
SELECT 
        s_ba.adm1_pcode,
        s_ba.adm1_en,
        s_ca.*
FROM se4all.join_cluster_all_adm1_mv AS s_jcaba
    LEFT JOIN se4all.cluster_all AS s_ca
    ON s_jcaba.cluster_all_id = s_ca.cluster_all_id
    LEFT JOIN se4all.boundary_adm1 AS s_ba
    ON s_jcaba.adm1_pcode = s_ba.adm1_pcode
WHERE s_ba.adm1_pcode='NG037' AND s_ca.area_km2>0.01;


-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_all','view_cluster_all_adm1.sql','Add views');
