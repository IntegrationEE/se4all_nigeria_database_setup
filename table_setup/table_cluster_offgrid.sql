/*

Create table

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
__copyright__   = "© Reiner Lemoine Institut"
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

-- table
DROP TABLE IF EXISTS se4all.cluster_offgrid CASCADE;
CREATE TABLE            se4all.cluster_offgrid (
    cluster_offgrid_id      serial,
    area_km2                real, -- the area of the cluster
    building_count          integer, -- the number of buildings (count)
    large_building_count    integer, -- the number of larger buildings defined in processing script
    percentage_large_building   integer, -- the percentage of larger buildings
    building_area_km2       real, -- the area of buildings in the cluster
    building_count_density_perkm2  real, -- the building count divided by the cluster area in km2
    percentage_building_area   real, -- the building area_km2 divided by the area_km2
    grid_dist_km            real,
    geom                    geometry(Polygon, 3857),
    CONSTRAINT cluster_offgrid_pkey PRIMARY KEY (cluster_offgrid_id) );


-- metadata
COMMENT ON TABLE se4all.cluster_offgrid IS '
{"name": "cluster_offgrid",
"title": "OpenStreetMap building layer modified and buffered into clusters",
"id": "",
"description": "Extract of clusters from OpenStreetMap",
"language": [ "en-GB" ],
"keywords": [ "nigeria", "building", "osm"  ],
"publicationDate": null,
"context": 
    {"homepage": null,
    "documentation": null,
    "sourceCode": null,
    "contact": null,
    "grantNo": null,
    "fundingAgency": null,
    "fundingAgencyLogo": null,
    "publisherLogo": null},
"spatial": 
    {"location": null,
    "extent": "nigeria",
    "resolution": null},
"temporal": 
    {"referenceDate": "",
    "timeseries": 
        {"start": "",
        "end": "",
        "resolution": "",
        "alignment": "",
        "aggregationType": ""} },
"sources": [
    {"title": "Open Street Map",
    "description": "Open Street Map dataset",
    "path": "https://openstreetmap.org", 
    "licenses": [
        {"name": "Open Data Commons Open Database License (ODbL)",
        "title": "ODbL-1.0",
        "path": "https://opendatacommons.org/licenses/odbl/",
        "instruction": null,
        "attribution": "© OpenStreetMap contributors"} ] }
     ],
"licenses": [
    {"name": "",
    "title": "",
    "path": "",
    "instruction": "",
    "attribution": null}],
"contributors": [
    {"title": null, "email": null, "date": null, "object": null, "comment": null} ],
"resources": [
    {"profile": "tabular-data-resource",
    "name": "model_draft.oep_metadata_table_example_v140",
    "path": "http://openenergyplatform.org/dataedit/view/model_draft/oep_metadata_table_example_v140",
    "format": "PostgreSQL",
    "encoding" : "UTF-8",
    "schema": {
        "fields": [
            {"name": "id", "description": "Unique identifier", "type": "serial", "unit": null},
            {"name": "year", "description": "Reference year", "type": "integer", "unit": null},
            {"name": "value", "description": "Example value", "type": "double precision", "unit": "MW"},
            {"name": "geom", "description": "Geometry", "type": "geometry(Point, 4326)", "unit": null} ],
        "primaryKey": ["id"],
        "foreignKeys": [{
                "fields": ["year"],
                "reference": {
                    "resource": "schema.table",
                    "fields": ["year"] } } ] },
    "dialect": 
        {"delimiter": null,
        "decimalSeparator": "."} } ],
"review": {
    "path": null,
    "badge": null},
"metaMetadata":
    {"metadataVersion": "OEP-1.4.0",
    "metadataLicense":
        {"name": "CC0-1.0",
        "title": "Creative Commons Zero v1.0 Universal",
        "path": "https://creativecommons.org/publicdomain/zero/1.0/"} },
"_comment":
    {"metadata": "Metadata documentation and explanation (https://github.com/OpenEnergyPlatform/organisation/wiki/metadata)",
    "dates": "Dates and time must follow the ISO8601 including time zone (YYYY-MM-DD or YYYY-MM-DDThh:mm:ss±hh)",
    "units": "Use a space between numbers and units (100 m)",
    "languages": "Languages must follow the IETF (BCP47) format (en-GB, en-US, de-DE)",
    "licenses": "License name must follow the SPDX License List (https://spdx.org/licenses/)",
    "review": "Following the OEP Data Review (https://github.com/OpenEnergyPlatform/data-preprocessing/wiki)",
    "null": "If not applicable use (null)"} }';

-- format verification
SELECT obj_description('se4all.cluster_offgrid' ::regclass) ::json;

-- index GIST (geom)
CREATE INDEX cluster_offgrid_geom_idx
    ON se4all.cluster_offgrid USING GIST (geom);

-- grant (grp_admin)
ALTER TABLE se4all.cluster_offgrid OWNER TO grp_admin;

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_offgrid','table_cluster_offgrid.sql','Add table');
