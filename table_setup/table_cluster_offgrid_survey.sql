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
DROP TABLE IF EXISTS se4all.cluster_offgrid_survey CASCADE;
CREATE TABLE            se4all.cluster_offgrid_survey (
    cluster_offgrid_survey_id   serial,
    cluster_offgrid_id          INT,
    wo_number                   INT,
    settlement_wo_id            INT,
    survey_date                 date,
    state_name                  varchar(50),
    lga_name                    varchar(50),
    community_name              varchar(50),
    grid_presence               varchar(31), -- options are: yes_connected_national_grid / yes_not_connected_national_grid / no
    grid_voltage                varchar(9), -- options are: lv / mv / mv_and_lv
    grid_distance_to_mv         varchar(17), -- options are: less_than_5_km / greater_than_5_km
    grid_structure_presence     boolean,
    grid_year_built             varchar(4),
    grid_poles_presence         boolean,
    grid_cable_presence         boolean,
    grid_transformer_presence   boolean, 
    grid_functionality          varchar(27), -- options are: everything_functional / transformer_only_functional / never_functional / functioned_in_the_past
    mini_grid_presence          boolean,
    mini_grid_status            varchar(16), -- options are: functional, in_commissioning
    mini_grid_primary_generation_type   varchar(6), -- options are: solar, hydro, diesel, other           
    -- mini_grid_company           varchar(50), -- discuss to include this or not
    income_source_primary       varchar(50),
    income_source_secondary     varchar(50),
    income_source_third         varchar(50),
    income_source_fourth        varchar(50),
    crop_cultivated_millet      boolean,
    crop_cultivated_guinea_corn boolean,
    crop_cultivated_groundnut   boolean,
    crop_cultivated_maize       boolean,
    crop_cultivated_rice        boolean,
    crop_cultivated_beans       boolean,
    crop_cultivated_pepper      boolean,
    crop_cultivated_sweet_potatoes      boolean,
    crop_cultivated_hibiscus_leaf       boolean,
    crop_cultivated_sesame_seed         boolean,
    crop_cultivated_cassava     boolean,
    crop_cultivated_cashew      boolean,
    crop_cultivated_yam         boolean,
    crop_cultivated_cocoa       boolean,
    crop_cultivated_other_1     varchar(50),
    crop_cultivated_other_2     varchar(50),
    crop_cultivated_other_3     varchar(50),
    crop_cultivated_primary     varchar(50),
    crop_cultivated_secondary   varchar(50),
    crop_cultivated_third       varchar(50),
    crop_cultivated_fourth      varchar(50),
    count_primary_schools       INT,
    count_secondary_schools     INT,
    count_health_facilities     INT,
    mobile_money_available      boolean,
    banks_available             boolean,
    market_monday               boolean,
    market_tuesday              boolean,
    market_wednesday            boolean,
    market_thursday             boolean,
    market_friday               boolean,
    market_saturday             boolean,
    market_sunday               boolean,
    count_traders_monday        INT,
    count_traders_tuesday       INT,
    count_traders_wednesday     INT,
    count_traders_thursday      INT,
    count_traders_friday        INT,
    count_traders_saturday      INT,
    count_traders_sunday        INT,
    petrol_price_ngn_per_litre  INT,
    diesel_price_ngn_per_litre  INT,
    kerosene_price_ngn_per_litre    INT,
    petrol_station_in_community boolean,
    distance_to_nearest_petrol_station_km   INT,
    households_with_genset_percentage   varchar(4), -- options are: 10% / 25% / 50% / 75% / >90%
    households_genset_size_avg_kva  real,
    businesses_with_genset_percentage   varchar(4), -- options are: 10% / 25% / 50% / 75% / >90%
    businesses_genset_size_avg_kva  real,
    network_mtn                 varchar(13), -- options are: not_available / 2G / 3G / 4G
    network_airtel              varchar(13), -- options are: not_available / 2G / 3G / 4G
    network_9mobile             varchar(13), -- options are: not_available / 2G / 3G / 4G
    network_glo                 varchar(13), -- options are: not_available / 2G / 3G / 4G
    network_others              varchar(50),
    count_productive_use_grinding_mills INT,
    count_productive_use_oil_press      INT,
    count_productive_use_other          INT,
    name_productive_use_other   varchar(50),
    count_commercial_barber_beauty_salon    INT,
    count_commercial_tailor_dressmaker      INT,
    count_commercial_shop_kiosk             INT,
    count_commercial_phone_charging         INT,
    count_commercial_tea_shop   INT,
    count_commercial_pos_shop   INT,
    count_commercial_other      INT,
    name_commercial_other       varchar(50),
    count_craft_carpenter       INT,
    count_craft_welder          INT,
    count_craft_vulcanizer      INT,
    count_craft_car_repair      INT,
    count_craft_bike_repair     INT,
    count_craft_generator_repair    INT,
    count_craft_shoemaker       INT,
    count_craft_other           INT,
    name_craft_other            varchar(50),
    accessibility_motorbike     varchar(15), -- options are: never /dry_season / all_year_round
    accessibility_4x4_car       varchar(15), -- options are: never /dry_season / all_year_round
    accessibility_truck         varchar(15), -- options are: never /dry_season / all_year_round
    accessibility_saloon_car    varchar(15), -- options are: never /dry_season / all_year_round
    accessibility_public_transport          varchar(15), -- options are: never /dry season / all_year_round
    -- community_notes             varchar(2000), -- discuss how to deal with this
    geom                         geometry(Point, 3857),
    building_count          integer, -- value calculated from join with se4all cluster offgrid
    grid_dist_km            real, -- value calculated from join with se4all cluster offgrid
    CONSTRAINT cluster_offgrid_survey_pkey PRIMARY KEY (cluster_offgrid_survey_id) );
    
-- metadata
COMMENT ON TABLE se4all.cluster_offgrid_survey IS '
{"name": "cluster_offgrid_survey",
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
SELECT obj_description('se4all.cluster_offgrid_survey' ::regclass) ::json;

-- index GIST (geom)
CREATE INDEX cluster_offgrid_survey_geom_idx
    ON se4all.cluster_offgrid_survey USING GIST (geom);

-- grant (grp_admin)
ALTER TABLE se4all.cluster_offgrid_survey OWNER TO grp_admin;

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_offgrid_survey','table_cluster_offgrid_survey.sql','Add table');
