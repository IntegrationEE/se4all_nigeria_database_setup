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

DROP MATERIALIZED VIEW IF EXISTS se4all.join_osm_building_distribution_line_all_buffer_mv CASCADE;
CREATE MATERIALIZED VIEW se4all.join_osm_building_distribution_line_all_buffer_mv(
    osm_building_id,
    area_m2,
    adm1_pcode,
    geom                      ) AS
SELECT s_jobabm.osm_building_id, 
    s_jobabm.area_m2,
    s_jobabm.adm1_pcode,
    s_jobabm.geom
FROM se4all.join_osm_building_adm1_buffer_mv AS s_jobabm LEFT JOIN
    se4all.join_distribution_line_all_buffer_adm1_mv AS s_jdlabam ON
    s_jdlabam.adm1_pcode = s_jobabm.adm1_pcode AND s_jobabm.geom && s_jdlabam.geom AND ST_Intersects(s_jobabm.geom, s_jdlabam.geom)
WHERE s_jdlabam.adm1_pcode IS NULL;

-- index GIST (geom)
CREATE INDEX join_osm_building_distribution_line_all_buffer_mv_geom_idx
    ON se4all.join_osm_building_distribution_line_all_buffer_mv USING GIST (geom);

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','join_osm_building_distribution_line_all_buffer_mv','mview_join_osm_building_distribution_line_all_buffer_mv.sql','Add materialised view');
