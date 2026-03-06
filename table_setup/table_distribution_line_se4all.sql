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
DROP TABLE IF EXISTS se4all.distribution_line_se4all CASCADE;
CREATE TABLE            se4all.distribution_line_se4all (
    source                  varchar (50),
    distribution_line_se4all_id    serial,
    source_distribution_line_se4all_id    varchar (50),
    name                    varchar(500),
    description             varchar(500),
    condition               varchar (10),
    voltage_kv              INT,
    length_km               decimal(8,3),
    geom                    geometry(Multilinestring, 3857),
    CONSTRAINT distribution_line_se4all_pkey PRIMARY KEY (distribution_line_se4all_id) );

-- metadata
COMMENT ON TABLE se4all.distribution_line_se4all IS '
{"name": "distribution_line_se4all",
"title": "Medium Voltage - MV - electricity grid cable",
"id": "",
"description": "electricity grid cable line locations collected from site visits",
"language": [ "en-GB" ],
"keywords": [ "nigeria", "MV", "distribution", "grid"  ],
"publicationDate": "",
"context": 
    {"homepage": "https://www.giz.de/en/worldwide/26374.html",
    "documentation": null,
    "sourceCode": null,
    "contact": null,
    "grantNo": null,
    "fundingAgency": "European Union, German Cooperation Deutsche Zusammenarbeit",
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
    {"title": null,
    "description": null,
    "path": null, 
    "licenses": [
        {"name": null,
        "title": null,
        "path": null,
        "instruction": null,
        "attribution": null} ] }
     ],
"licenses": [
    {"name": "",
    "title": "",
    "path": "",
    "instruction": "",
    "attribution": ""}],
"contributors": [
    {"title": null, "email": null, "date": null, "object": null, "comment": null}
 ],
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
SELECT obj_description('se4all.distribution_line_se4all' ::regclass) ::json;

-- index GIST (geom)
CREATE INDEX distribution_line_se4all_geom_idx
    ON se4all.distribution_line_se4all USING GIST (geom);

-- grant (grp_admin)
ALTER TABLE se4all.distribution_line_se4all OWNER TO grp_admin;

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','distribution_line_se4all','table_distribution_line_se4all.sql','Add table');
