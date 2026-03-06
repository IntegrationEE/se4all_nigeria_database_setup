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

*/

-- table
DROP TABLE IF EXISTS se4all.boundary_adm1 CASCADE;
CREATE TABLE            se4all.boundary_adm1 (
    adm1_pcode  char(5),
    adm1_en     varchar(50),
    geom        geometry(MultiPolygon, 3857),
    CONSTRAINT boundary_adm1_pkey PRIMARY KEY (adm1_pcode) );

-- metadata
-- metadata needs to be updated if the source is different from the listed below
COMMENT ON TABLE se4all.boundary_adm1 IS '{
    "name": "boundary_adm1",
    "title": "Nigeria - Administrative Boundary level 1",
    "id": "",
    "description": "The dataset represents the Common Operational Data (COD) for administrative boundaries of Nigeria. Each administrative unit contains the p-code and name. Admin COD datasets (Admin 0 – 2) for Nigeria are endorsed by the Office of the Surveyor General of the Federal Republic of Nigeria (OSGOF) and the IMWG Feb 2017. See metadata for description of methodology for admin level 3 and the cleaning and processing performed by ITOS. Levels 0 - 3 are polygonal administrative units, Level 3 only covers Adamawa, Borno and Yobe States and are for operational purposes only. A senatorial district shapefile is also included. Senatorial districts respect administrative level 1 (state) but are not reflected in the gazetteer, geodatabase, or live services. The administrative level 0-2 and senatorial district boundaries are suitable for database or GIS linkage to the Nigeria 2016 Population Data tables.",
    "language": [ "en-GB" ],
    "keywords": [ "nigeria", "administrative", "boundaries" ],
    "publicationDate": "",
    "context":
        {"homepage": "",
        "documentation": "",
        "sourceCode": "",
        "contact": "",
        "grantNo": "",
        "fundingAgency": "",
        "fundingAgencyLogo": "",
        "publisherLogo": ""},
    "spatial": 
        {"location": null,
        "extent": "nigeria",
        "resolution": ""},
    "temporal": 
        {"referenceDate": "2017-02-23",
        "timeseries": 
            {"start": "",
            "end": "",
            "resolution": "",
            "alignment": "",
            "aggregationType": ""} 
        },
    "sources": [
        {"title": "Office for the Surveyor General of the Federation of Nigeria OSGOF",
        "description": "",
        "path": "https://data.humdata.org/dataset/nga-administrative-boundaries", 
        "licenses": [
            {"name": "",
            "title": "",
            "path": "",
            "instruction": "",
            "attribution": ""}] },
            {"title": "Ehealth, United Nations Cartographic Section UNCS",
            "description": "",
            "path": "https://data.humdata.org/dataset/nga-administrative-boundaries", 
            "licenses": [
                {"name": "y",
                "title": "",
                "path": "",
                "instruction": "",
                "attribution": ""} ] }
     ],
"licenses": [
    {"name": "Humanitarian use only",
    "title": "",
    "path": "",
    "instruction": "",
    "attribution": ""}],
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
            {"name": null, "description": null, "type": null, "unit": null},
            {"name": null, "description": null, "type": null, "unit": null}],
        "primaryKey": null,
        "foreignKeys": null },
    "dialect": 
        {"delimiter": null,
        "decimalSeparator": "."} } ],
"review": 
    {"path": null,
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
SELECT obj_description('se4all.boundary_adm1' ::regclass) ::json;

-- index GIST (geom)
CREATE INDEX boundary_adm1_geom_idx
    ON se4all.boundary_adm1 USING GIST (geom);

-- grant (grp_admin)
ALTER TABLE se4all.boundary_adm1 OWNER TO grp_admin;

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','boundary_adm1','table_boundary_adm1.sql','Add table');
