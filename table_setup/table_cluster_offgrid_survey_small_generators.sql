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
DROP TABLE IF EXISTS se4all.cluster_offgrid_survey_small_generators CASCADE;
CREATE TABLE            se4all.cluster_offgrid_survey_small_generators (
    cluster_offgrid_survey_small_generators_id   serial,
    cluster_offgrid_id          INT,
    wo_number                   INT,
    settlement_wo_id            INT,
    survey_date                 date,
    state_name                  varchar(50),
    -- lga_name                    varchar(50),
    -- community_name              varchar(50),
    business_type               varchar(50),
    business_description        varchar(100),
    generator                   varchar(10), -- solar or diesel
    geom                         geometry(Point, 3857),
    CONSTRAINT cluster_offgrid_survey_small_generators_pkey PRIMARY KEY (cluster_offgrid_survey_small_generators_id) );
    
-- metadata
COMMENT ON TABLE se4all.cluster_offgrid_survey_small_generators IS '
{"name": "cluster_offgrid_survey_small_generators",
"title": "Nigeria - Off grid cluster survey data",
"id": "",
"description": "Data was collected during Nigeria SE4ALL project survey under the Nigerian Energy Support Programme (NESP) co-funded by the European Union and the German Government - BMZ, Ministry for Economic Cooperation and Development – and implemented by Deutsche Gesellschaft für Internationale Zusammenarbeit (GIZ) in collaboration with the Federal Ministry of Power (FMP) supports inter alia electrification planning in Nigeria.",
"language": [ "en-GB" ],
"keywords": [ "nigeria", "off-grid", "survey", "nesp"  ],
"publicationDate": "2022-03-21",
"context": 
    {"homepage": "https://nigeriase4all.gov.ng/",
    "documentation": "https://nigeriase4all.gov.ng/about",
    "sourceCode": null,
    "contact": "info@power.gov.ng",
    "grantNo": null,
    "fundingAgency": "the European Union and the German Government - BMZ, Ministry for Economic Cooperation and Development.",
    "fundingAgencyLogo": null,
    "publisherLogo": null},
"spatial": 
    {"location": null,
    "extent": "nigeria",
    "resolution": null},
"temporal": 
    {"referenceDate": "2022",
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
    {"name": "Open Data Commons Open Database License (ODbL)",
        "title": "ODbL-1.0",
        "path": "https://opendatacommons.org/licenses/odbl/",
        "instruction": null,
        "attribution": "© Deutsche Gesellschaft für Internationale Zusammenarbeit (GIZ) GmbH"}],
"contributors": [
    {"title": null, "email": null, "date": null, "object": null, "comment": null} ],
"resources": [
    {"profile": null,
    "name": null,
    "path": null,
    "format": null,
    "encoding" : null,
    "schema": {
        "fields": [
            {"name": null, "description": null, "type": null, "unit": null} ],
        "primaryKey": null,
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
SELECT obj_description('se4all.cluster_offgrid_survey_small_generators' ::regclass) ::json;

-- index GIST (geom)
CREATE INDEX cluster_offgrid_survey_small_generators_geom_idx
    ON se4all.cluster_offgrid_survey_small_generators USING GIST (geom);

-- grant (grp_admin)
ALTER TABLE se4all.cluster_offgrid_survey_small_generators OWNER TO grp_admin;

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_offgrid_survey_small_generators','table_cluster_offgrid_survey_small_generators.sql','Add table');
