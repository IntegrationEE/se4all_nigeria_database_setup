/*

Create materialized view

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/database_setup/se4all_setup_schema.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later


A definition of metadata can be found in the openmod glossary http://wiki.openmod-initiative.org/wiki/Metadata
A further description can be found on http://wiki.openmod-initiative.org/wiki/DatabaseRules
Feedback for an update is collected in this issue: https://github.com/OpenEnergyPlatform/organisation/issues/10

__url__         = "https://github.com/OpenEnergyPlatform/examples/tree/master/metadata"
__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "Creative Commons Zero v1.0 Universal (CC0-1.0)"
__license_url__ = "https://creativecommons.org/publicdomain/zero/1.0/"
__author__      = "Ludee"
__contains__    = "http://stackoverflow.com/questions/383692/what-is-json-and-why-would-i-use-it", "https://specs.frictionlessdata.io/data-package/"

-- metadata description
-- metadata template

Additional information:
- Dates and time must follow the ISO8601 (JJJJ-MM-TT; 1 a; 1 h)
- Use a space between Numbers and units (100 m)
- Languages must follow the IETF (BCP47) format (en-US; de-DE)
- If not applicable use null
*/

DROP MATERIALIZED VIEW IF EXISTS se4all.join_cluster_all_adm1_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.join_cluster_all_adm1_mv(
    cluster_all_id                  ,
    adm1_pcode                      ) AS
SELECT 
    s_ca.cluster_all_id,
    s_bab.adm1_pcode
FROM se4all.cluster_all AS s_ca
LEFT JOIN se4all.boundary_adm1_buffer_mv AS s_bab
    ON ST_Intersects(s_ca.geom, s_bab.geom)
	WHERE s_ca.geom && s_bab.geom;

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','join_cluster_all_adm1_mv','mview_join_cluster_all_adm1_mv.sql','Add materialised view');
