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
DROP TABLE IF EXISTS se4all.cluster_all CASCADE;
CREATE TABLE            se4all.cluster_all (
    cluster_all_id          serial,
    fid                     int8 NOT NULL,
    area_km2                real,
    grid_dist_km            real,
    geom                    geometry(MultiPolygon, 3857),
    CONSTRAINT cluster_all_pkey PRIMARY KEY (cluster_all_id) );

-- metadata
COMMENT ON TABLE se4all.cluster_all IS '
{"name": "cluster_all",
"title": "Nigeria SE4ALL all clusters country-wide",
"id": "",
"description": "population clusters for nigeria se4all project, derived from high resolution settlement layer",
"language": [ "en-GB" ],
"keywords": [ "nigeria", "settlement", "cluster", "se4all"  ],
"publicationDate": null,
"context": 
    {"homepage": "https://reiner-lemoine-institut.de/szenariendb/",
    "documentation": "https://github.com/OpenEnergyPlatform/organisation/wiki/metadata",
    "sourceCode": "https://github.com/OpenEnergyPlatform/examples/tree/master/metadata",
    "contact": "https://github.com/Ludee",
    "grantNo": "03ET4057",
    "fundingAgency": "Bundesministerium für Wirtschaft und Energie",
    "fundingAgencyLogo": "https://www.innovation-beratung-foerderung.de/INNO/Redaktion/DE/Bilder/Titelbilder/titel_foerderlogo_bmwi.jpg?__blob=poster&v=2",
    "publisherLogo": "https://reiner-lemoine-institut.de//wp-content/uploads/2015/09/rlilogo.png"},
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
    {"title": "High Resolution Settlement Layer",
    "description": "The High Resolution Settlement Layer (HRSL) provides estimates of human population distribution at a resolution of 1 arc-second (approximately 30 m) for the year 2015.",
    "path": "https://ciesin.columbia.edu/data/hrsl/", 
    "licenses": [
        {"name": "CC0-4.0",
        "title": "Attribution 4.0 International (CC BY 4.0)",
        "path": "https://creativecommons.org/licenses/by/4.0/",
        "instruction": "You are free: To Share, To Adapt",
        "attribution": "Facebook Connectivity Lab and Center for International Earth Science Information Network - CIESIN - Columbia University. 2016. High Resolution Settlement Layer (HRSL). Source imagery for HRSL © 2016 DigitalGlobe. Accessed DAY MONTH YEAR."} ] }
     ],
"licenses": [
    {"name": "",
    "title": "",
    "path": "",
    "instruction": "",
    "attribution": "© Reiner Lemoine Institut Facebook Connectivity Lab and Center for International Earth Science Information Network - CIESIN - Columbia University. 2016. High Resolution Settlement Layer (HRSL). Source imagery for HRSL © 2016 DigitalGlobe"}],
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
    "path": "https://github.com/OpenEnergyPlatform/data-preprocessing/wiki",
    "badge": "platin"},
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
SELECT obj_description('se4all.cluster_all' ::regclass) ::json;

-- index GIST (geom)
CREATE INDEX cluster_all_geom_idx
    ON se4all.cluster_all USING GIST (geom);

-- grant (grp_admin)
ALTER TABLE se4all.cluster_all OWNER TO grp_admin;

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_all','table_cluster_all.sql','Add table');
