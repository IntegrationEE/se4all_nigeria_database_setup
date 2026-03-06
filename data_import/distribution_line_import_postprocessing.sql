/*

Post processing for distribution line files

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/database_import/distribution_line_import_postprocessing.sql
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

-- metadata
COMMENT ON TABLE import.kaduna_electric_line_data_03312016 IS '
{"name": "kaduna_electric_line_data_03312016",
"title": "Kaduna electric line data",
"id": "",
"description": "distribution line data for kaduna electric distribution company in Nigeria",
"language": [ "en-GB" ],
"keywords": [ "nigeria", "distribution", "kaduna", "electric"  ],
"publicationDate": null,
"context": 
    {"homepage": "",
    "documentation": "https://kadunaelectric.com",
    "sourceCode": null,
    "contact": "",
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
    "attribution": null}],
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
COMMENT ON TABLE import.kedco_grid_data_simplified_06172015_with_overlaps_removed IS '
{"name": "kedco_grid_data_simplified_06172015_with_overlaps_removed",
"title": "Nigeria - Kano Electricity Distribution Company - Grid Map",
"id": "",
"description": "Data collected as input to the geospatial least-cost planning for universal electricity access by 2030 developed as part of the ESMAP funded World Bank Nigeria Electricity Access Project (NEAP). The dataset covers the service area for the Kano Electricity Distribution Company (KEDCO) Nigeria. The data collection has been undertaken by the Earth Institute, Sustainable Engineering Lab, in close collaboration with KEDCO.",
"language": [ "en-GB" ],
"keywords": [ "nigeria", "distribution", "kedco", "neap"  ],
"publicationDate": "2016-11-10",
"context": 
    {"homepage": "https://www.earth.columbia.edu/",
    "documentation": "https://energydata.info/dataset/kano-electricity-distribution-plc-kedco-mv-lines-2016",
    "sourceCode": null,
    "contact": "ytanvez@worldbank.org",
    "grantNo": null,
    "fundingAgency": "World Bank Nigeria Electricity Access Project (NEAP)",
    "fundingAgencyLogo": null,
    "publisherLogo": null},
"spatial": 
    {"location": null,
    "extent": "nigeria",
    "resolution": null},
"temporal": 
    {"referenceDate": "2016",
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
    {"name": "CC-BY-4.0",
        "title": "Attribution 4.0 International (CC BY 4.0)",
        "path": "https://creativecommons.org/licenses/by/4.0/",
        "instruction": "You are free: To Share, To Adapt",
        "attribution": "Columbia University Earth Institute"}],
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
SELECT obj_description('import.kaduna_electric_line_data_03312016' ::regclass) ::json;
SELECT obj_description('import.kedco_grid_data_simplified_06172015_with_overlaps_removed' ::regclass) ::json;

-- index GIST (geom)
CREATE INDEX kaduna_electric_line_data_03312016_geom_idx
    ON import.kaduna_electric_line_data_03312016 USING GIST (geom);
CREATE INDEX kedco_grid_data_simplified_06172015_with_overlaps_removed_geom_idx
    ON import.kedco_grid_data_simplified_06172015_with_overlaps_removed USING GIST (geom);

-- grant (grp_admin)
ALTER TABLE import.kaduna_electric_line_data_03312016 OWNER TO grp_admin;
ALTER TABLE import.kedco_grid_data_simplified_06172015_with_overlaps_removed OWNER TO grp_admin;

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','import','kaduna_electric_line_data_03312016','distribution_line_import_postprocessing.sql','Postprocessing');
SELECT database_log('se4all','v0','setup','import','kedco_grid_data_simplified_06172015_with_overlaps_removed','distribution_line_import_postprocessing.sql','Postprocessing');

