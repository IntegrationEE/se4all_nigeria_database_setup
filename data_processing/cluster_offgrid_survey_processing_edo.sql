/*
Import of data from import schema

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/data_import/adm1_import.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/

-- delete all data relating to the state
DELETE FROM se4all.cluster_offgrid_survey
WHERE state_name = 'Edo';

INSERT INTO se4all.cluster_offgrid_survey (
    cluster_offgrid_id, 
    wo_number, 
    settlement_wo_id,
    survey_date,
    state_name,
    lga_name,
    community_name,
    grid_presence,
    grid_voltage,
    grid_distance_to_mv,
    grid_structure_presence,
    grid_year_built,
    grid_poles_presence,
    grid_cable_presence,
    grid_transformer_presence,
    grid_functionality,
    income_source_primary,
    income_source_secondary,
    income_source_third,
    income_source_fourth,
    crop_cultivated_millet,
    crop_cultivated_guinea_corn,
    crop_cultivated_groundnut,
    crop_cultivated_maize,
    crop_cultivated_rice,
    crop_cultivated_beans,
    crop_cultivated_pepper,
    crop_cultivated_sweet_potatoes,
    crop_cultivated_hibiscus_leaf,
    crop_cultivated_sesame_seed,
    crop_cultivated_cassava,
     --crop_cultivated_cashew,
    --crop_cultivated_yam,
    --crop_cultivated_cocoa,
    crop_cultivated_other_1,
    crop_cultivated_other_2,
    crop_cultivated_other_3,
    crop_cultivated_primary,
    crop_cultivated_secondary,
    crop_cultivated_third,
    crop_cultivated_fourth,
    count_primary_schools,
    count_secondary_schools,
    count_health_facilities,
    mobile_money_available,
    banks_available,
    market_monday,
    market_tuesday,
    market_wednesday,
    market_thursday,
    market_friday,
    market_saturday,
    market_sunday,
    count_traders_monday,
    count_traders_tuesday,
    count_traders_wednesday,
    count_traders_thursday,
    count_traders_friday,
    count_traders_saturday,
    count_traders_sunday,
    petrol_price_ngn_per_litre,
    diesel_price_ngn_per_litre,
    kerosene_price_ngn_per_litre,
    petrol_station_in_community,
    distance_to_nearest_petrol_station_km,
    households_with_genset_percentage, 
    households_genset_size_avg_kva,
    businesses_with_genset_percentage,
    businesses_genset_size_avg_kva,
    network_mtn,
    network_airtel,
    network_9mobile,
    network_glo,
    network_others,
    count_productive_use_grinding_mills,
    count_productive_use_oil_press,
    count_productive_use_other,
    name_productive_use_other,
    count_commercial_barber_beauty_salon,
    count_commercial_tailor_dressmaker,
    count_commercial_shop_kiosk,
    count_commercial_phone_charging,
    --count_commercial_tea_shop,
    --count_commercial_pos_shop,
    count_commercial_other,
    name_commercial_other,
    count_craft_carpenter,
    count_craft_welder,
    count_craft_vulcanizer,
    count_craft_car_repair,
    count_craft_bike_repair,
    count_craft_generator_repair,
    count_craft_shoemaker,
    count_craft_other,
    name_craft_other,
    accessibility_motorbike,
    accessibility_4x4_car,
    accessibility_truck,
    accessibility_saloon_car,
    accessibility_public_transport,
    -- community_notes,
    mini_grid_presence,
    -- mini_grid_status,
    -- mini_grid_primary_generation_type,
    geom
)
SELECT 
    clustr_id::INTEGER, -- cluster_offgrid_id
    wo_check::INTEGER, -- wo_number
    settlement::INTEGER, -- settlement_wo_id
    TO_DATE(enteradate, 'MM/DD/YYYY'), -- survey_date
    REPLACE(state_chec, '-', ' ' ), -- state_name
    INITCAP(selectlga), -- lga_name
    INITCAP(communityn), -- community_name
    CASE  -- grid_presence
        WHEN(enumerat_1 = 'No') THEN 'no'
        WHEN(enumerat_1 = 'Yes (connected to national grid)') THEN 'yes_connected_national_grid'
        WHEN(enumerat_1 = 'Yes (not connected to national grid)') THEN 'yes_not_connected_national_grid'
    END,
    CASE  -- grid_voltage
        WHEN(whatisthev = 'LV') THEN 'lv'
        WHEN(whatisthev = 'MV') THEN 'mv'
        WHEN(whatisthev = 'MV & LV') THEN 'mv_and_lv'
    END,
    CASE  -- grid_distance_to_mv
        WHEN(whatisthed = 'Greater than 5km') THEN 'greater_than_5_km'
        WHEN(whatisthed = 'Less than 5km') THEN 'less_than_5_km'
    END,
    istheregri::BOOLEAN, -- grid_structure_presence
    whatyearwa, -- grid_year_built
    poles::BOOLEAN, -- grid_poles_presence
    cable::BOOLEAN, -- grid_cable_presence
    transforme::BOOLEAN, -- grid_transformer_presence
    CASE -- grid_functionality
        WHEN(eu = 'Functional' AND ev = 'Functional') THEN 'everything_functional'
        WHEN(ev = 'Functional') THEN 'transformer_only_functional'
        WHEN(eu = 'Never functional' OR et = 'Never functional') THEN 'never_functional'
    END,
    LOWER("primary"::VARCHAR), -- income_source_primary
    LOWER("secondary"::VARCHAR), -- income_source_secondary
    LOWER(third::VARCHAR), -- income_source_third
    LOWER("fourth"::VARCHAR), -- income_source_fourth
    al::BOOLEAN, -- crop_cultivated_millet
    am::BOOLEAN, -- crop_cultivated_guinea_corn
    an::BOOLEAN, -- crop_cultivated_groundnut
    ao::BOOLEAN, -- crop_cultivated_maize
    ap::BOOLEAN, -- crop_cultivated_rice
    aq::BOOLEAN, -- crop_cultivated_beans
    ar::BOOLEAN, -- crop_cultivated_pepper
    "as"::BOOLEAN, -- crop_cultivated_sweet_potatoes
    "at"::BOOLEAN, -- crop_cultivated_hibiscus_leaf
    au::BOOLEAN, -- crop_cultivated_sesame_seed
    av::BOOLEAN, -- crop_cultivated_cassava
    --crop_cul11::BOOLEAN, -- crop_cultivated_cashew
    --crop_cul12::BOOLEAN, --crop_cultivated_yam
    --crop_cul13::BOOLEAN, --crop_cultivated_cocoa
    LOWER(otherspeci), -- crop_cultivated_other_1
    LOWER(otherspe_1), -- crop_cultivated_other_2
    LOWER(otherspe_2), -- crop_cultivated_other_3
    CASE  -- crop_cultivated_primary
        WHEN(primarycro = 'Others (1)') THEN LOWER(otherspeci)
        WHEN(primarycro = 'Others (2)') THEN LOWER(otherspe_1)
        WHEN(primarycro = 'Others (3)') THEN LOWER(otherspe_2)
        ELSE LOWER(primarycro)
    END,
    CASE  -- crop_cultivated_secondary
        WHEN(secondaryc = 'Others (1)') THEN LOWER(otherspeci)
        WHEN(secondaryc = 'Others (2)') THEN LOWER(otherspe_1)
        WHEN(secondaryc = 'Others (3)') THEN LOWER(otherspe_2)
        ELSE LOWER(secondaryc)
    END,
    CASE  -- crop_cultivated_third
        WHEN(thirdcropc = 'Others (1)') THEN LOWER(otherspeci)
        WHEN(thirdcropc = 'Others (2)') THEN LOWER(otherspe_1)
        WHEN(thirdcropc = 'Others (3)') THEN LOWER(otherspe_2)
        ELSE LOWER(thirdcropc)
    END,
    CASE  -- crop_cultivated_fourth
        WHEN(fourthcrop = 'Others (1)') THEN LOWER(otherspeci)
        WHEN(fourthcrop = 'Others (2)') THEN LOWER(otherspe_1)
        WHEN(fourthcrop = 'Others (3)') THEN LOWER(otherspe_2)
        ELSE LOWER(fourthcrop)
    END,
    primarysch::INTEGER, -- count_primary_schools
    secondarys::INTEGER, -- count_secondary_schools
    healthfaci::INTEGER, -- count_health_facilities
    mobilemone::BOOLEAN,-- mobile_money_available
    banks::BOOLEAN,-- banks_available
    monday::BOOLEAN,-- market_monday
    tuesday::BOOLEAN,-- market_tuesday
    wednesday::BOOLEAN,-- market_wednesday
    thursday::BOOLEAN,-- market_thursday
    friday::BOOLEAN,-- market_friday
    saturday::BOOLEAN,-- market_saturday
    sunday::BOOLEAN,-- market_sunday
    cb::INTEGER,-- count_traders_monday
    cc::INTEGER,-- count_traders_tuesday
    cd::INTEGER,-- count_traders_wednesday
    ce::INTEGER,-- count_traders_thursday
    cf::INTEGER,-- count_traders_friday
    cg::INTEGER,-- count_traders_saturday
    ch::INTEGER,-- count_traders_sunday
    CASE -- petrol_price_ngn_per_litre
        WHEN (petrollitr::INTEGER < 0) THEN null
        ELSE petrollitr::INTEGER
    END,
    CASE -- diesel_price_ngn_per_litre
        WHEN (diesellitr::INTEGER < 0) THEN null
        ELSE diesellitr::INTEGER
    END,       
    CASE -- kerosene_price_ngn_per_litre
        WHEN (keroseneli::INTEGER < 0) THEN null
        ELSE keroseneli::INTEGER
    END,   
    petrolstat::BOOLEAN, -- petrol_station_in_community
    ifnodistan::INTEGER, -- distance_to_nearest_petrol_station_km
    CASE -- households_with_genset_percentage 
        WHEN (household = '1') THEN '>90%'
        WHEN (household = '2') THEN '75%'
        WHEN (household = '3') THEN '50%'
        WHEN (household = '4') THEN '25%'
        WHEN (household = '5') THEN '10%'
    END,
    averagesiz::real, -- households_genset_size_avg_kva
    CASE -- businesses_with_genset_percentage
        WHEN (businesses = '1') THEN '>90%'
        WHEN (businesses = '2') THEN '75%'
        WHEN (businesses = '3') THEN '50%'
        WHEN (businesses = '4') THEN '25%'
        WHEN (businesses = '5') THEN '10%'
    END,     
    cm::real, -- businesses_genset_size_avg_kva
    CASE -- network_mtn
        WHEN (mtn = 'N/A') THEN 'not_available'
        ELSE mtn
    END,
    CASE -- network_airtel
        WHEN (airtel = 'N/A') THEN 'not_available'
        ELSE airtel
    END,   
    CASE -- network_9mobile
        WHEN (mobile = 'N/A') THEN 'not_available'
        ELSE mobile
    END,
    CASE -- network_glo
        WHEN (glo = 'N/A') THEN 'not_available'
        ELSE glo
    END,
    CASE -- network_others
        WHEN (others = 'N/A') THEN 'not_available'
        ELSE others
    END,
    grindingmi::INTEGER, -- count_productive_use_grinding_mills
    oilpress::INTEGER, -- count_productive_use_oil_press
    cx::INTEGER, -- count_productive_use_other
    LOWER(cy), -- name_productive_use_other
    barberbeau::INTEGER, -- count_commercial_barber_beauty_salon
    tailordres::INTEGER, -- count_commercial_tailor_dressmaker
    convenienc::INTEGER, -- count_commercial_shop_kiosk
    phonecharg::INTEGER, -- count_commercial_phone_charging
    --teashop::INTEGER,  -- count_commercial_tea_shop
    --posshop::INTEGER,  -- count_commercial_pos_shop
    de::INTEGER, -- count_commercial_other
    LOWER(df), -- name_commercial_other
    carpenter::INTEGER, -- count_craft_carpenter
    welder::INTEGER, -- count_craft_welder
    vulcanizer::INTEGER, -- count_craft_vulcanizer
    carrepair::INTEGER, -- count_craft_car_repair
    bikerepair::INTEGER, -- count_craft_bike_repair
    generatorr::INTEGER, -- count_craft_generator_repair
    shoemaker::INTEGER, -- count_craft_shoemaker
    "do"::INTEGER, -- count_craft_other
    LOWER(dp), -- name_craft_other
    CASE -- accessibility_motorbike
        WHEN (motorbike = '1 2' OR motorbike = '2') THEN 'all_year_round'
        WHEN (motorbike = '1' OR motorbike = '1 3') THEN 'dry_season_only'
        WHEN (motorbike = '3') THEN 'never' 
    END,
    CASE -- accessibility_4x4_car
        WHEN (x4caregsuv = '1 2' OR x4caregsuv = '2') THEN 'all_year_round' 
        WHEN (x4caregsuv = '1' OR x4caregsuv = '1 3') THEN 'dry_season_only'
        WHEN (x4caregsuv = '3') THEN 'never' 
    END,    
    CASE -- accessibility_truck
        WHEN (truck = '1 2' OR truck = '2') THEN 'all_year_round'
        WHEN (truck = '1' OR truck = '1 3') THEN 'dry_season_only'
        WHEN (truck = '3') THEN 'never' 
    END,
    CASE -- accessibility_saloon_car
        WHEN (salooncar = '1 2' OR salooncar = '2') THEN 'all_year_round'
        WHEN (salooncar = '1' OR salooncar = '1 3') THEN 'dry_season_only'
        WHEN (salooncar = '3') THEN 'never' 
    END,
    CASE -- accessibility_public_transport
        WHEN (publictran = '1 2' OR publictran = '2') THEN 'all_year_round'
        WHEN (publictran = '1' OR publictran = '1 3') THEN 'dry_season_only'
        WHEN (publictran = '3') THEN 'never' 
    END,
    -- generalcom, -- community_notes
    isthecommu::BOOLEAN, -- mini_grid_presence
    -- colum_name, -- mini_grid_status
    --mg_gen_typ, -- mini_grid_primary_generation_type
    ST_Transform(geom,3857)
FROM import.offgrid_survey_edo_wo_1;

-- Update values from cluster_offgrid

UPDATE se4all.cluster_offgrid_survey AS s_cos
SET building_count = s_co.building_count
FROM se4all.cluster_offgrid AS s_co
WHERE ST_Within(s_cos.geom, s_co.geom);

UPDATE se4all.cluster_offgrid_survey AS s_cos
SET grid_dist_km = s_co.grid_dist_km
FROM se4all.cluster_offgrid AS s_co
WHERE ST_Within(s_cos.geom, s_co.geom);

-- error in running DB log, something to do with the postgres version, removed for now.
-- database log (project,version,io,schema_name,table_name,script_name,comment)
-- SELECT database_log('se4all','v0','setup','se4all','cluster_offgrid_survey','cluster_offgrid_survey_processing_edo.sql','Insert data');
