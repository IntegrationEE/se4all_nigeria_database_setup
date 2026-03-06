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
WHERE state_name = 'Kwara';

-- insert data from import for SURVEY Kwara 1
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
    crop_cultivated_cashew,
    crop_cultivated_yam,
    crop_cultivated_cocoa,
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
    count_commercial_tea_shop,
    count_commercial_pos_shop,
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
   -- mini_grid_presence,
   -- mini_grid_status,
   -- mini_grid_primary_generation_type,
    geom
)
SELECT 
    cluster_id::INTEGER, -- cluster_offgrid_id
    wo_check::INTEGER, -- wo_number
    settlement::INTEGER, -- settlement_wo_id
    TO_DATE(enteradate, 'DD/MM/YYYY'), -- survey_date
    INITCAP(state_chec), -- state_name
    INITCAP(selectlga), -- lga_name
    INITCAP(communityn), -- community_name
    CASE  -- grid_presence
        WHEN(grid= 'No') THEN 'no'
        WHEN(grid = 'Yes (connected to national grid)') THEN 'yes_connected_national_grid'
        WHEN(grid = 'Yes (not connected to national grid)') THEN 'yes_not_connected_national_grid'
    END,
    CASE  -- grid_voltage
        WHEN(voltage_of = 'LV') THEN 'lv'
        WHEN(voltage_of = 'MV') THEN 'mv'
        WHEN(voltage_of = 'MV & LV') THEN 'mv_and_lv'
    END,
    CASE  -- grid_distance_to_mv
        WHEN(distance_o = 'Greater than 5km') THEN 'greater_than_5_km'
        WHEN(distance_o = 'Less than 5km') THEN 'less_than_5_km'
    END,
    grid_struc::BOOLEAN, -- grid_structure_presence
    year_built, -- grid_year_built
    poles::BOOLEAN, -- grid_poles_presence
    cable::BOOLEAN, -- grid_cable_presence
    transforme::BOOLEAN, -- grid_transformer_presence
    CASE -- grid_functionality
        WHEN(function_c = 'Functional' AND function_t = 'Functional') THEN 'everything_functional'
        WHEN(function_t = 'Functional') THEN 'transformer_only_functional'
        WHEN(function_c = 'Never functional' OR function_t = 'Never functional') THEN 'never_functional'
    END,
    LOWER("primary"), -- income_source_primary
    LOWER("secondary"), -- income_source_secondary
    LOWER(third), -- income_source_third
    LOWER(fourth), -- income_source_fourth
    crop_culti::BOOLEAN, -- crop_cultivated_millet
    crop_cul_1::BOOLEAN, -- crop_cultivated_guinea_corn
    crop_cul_2::BOOLEAN, -- crop_cultivated_groundnut
    crop_cul_3::BOOLEAN, -- crop_cultivated_maize
    crop_cul_4::BOOLEAN, -- crop_cultivated_rice
    crop_cul_5::BOOLEAN, -- crop_cultivated_beans
    crop_cul_6::BOOLEAN, -- crop_cultivated_pepper
    crop_cul_7::BOOLEAN, -- crop_cultivated_sweet_potatoes
    crop_cul_8::BOOLEAN, -- crop_cultivated_hibiscus_leaf
    crop_cul_9::BOOLEAN, -- crop_cultivated_sesame_seed
    crop_cul10::BOOLEAN, -- crop_cultivated_cassava
    crop_cul11::BOOLEAN, -- crop_cultivated_cashew
    crop_cul12::BOOLEAN, -- crop_cultivated_yam
    crop_cul13::BOOLEAN, -- crop_cultivated_cocoa
    LOWER(other_crop), -- crop_cultivated_other_1
    LOWER(other_cr_1), -- crop_cultivated_other_2
    LOWER(other_cr_2), -- crop_cultivated_other_3
    CASE  -- crop_cultivated_primary
        WHEN(primarycro = 'Others(1)') THEN LOWER(other_crop)
        WHEN(primarycro = 'Others(2)') THEN LOWER(other_cr_1)
        WHEN(primarycro = 'Others(3)') THEN LOWER(other_cr_2)
        ELSE LOWER(primarycro)
    END,
    CASE  -- crop_cultivated_secondary
        WHEN(secondaryc = 'Others(1)') THEN LOWER(other_crop)
        WHEN(secondaryc = 'Others(2)') THEN LOWER(other_cr_1)
        WHEN(secondaryc = 'Others(3)') THEN LOWER(other_cr_2)
        ELSE LOWER(secondaryc)
    END,
    CASE  -- crop_cultivated_third
        WHEN(thirdcropc = 'Others(1)') THEN LOWER(other_crop)
        WHEN(thirdcropc = 'Others(2)') THEN LOWER(other_cr_1)
        WHEN(thirdcropc = 'Others(3)') THEN LOWER(other_cr_2)
        ELSE LOWER(thirdcropc)
    END,
    CASE  -- crop_cultivated_fourth
        WHEN(fourthcrop = 'Others(1)') THEN LOWER(other_crop)
        WHEN(fourthcrop = 'Others(2)') THEN LOWER(other_cr_1)
        WHEN(fourthcrop = 'Others(3)') THEN LOWER(other_cr_2)
        ELSE LOWER(fourthcrop)
    END,
    primarysch::INTEGER, -- count_primary_schools
    secondarys::INTEGER, -- count_secondary_schools
    healthfaci::INTEGER, -- count_health_facilities
    mobile_mon::BOOLEAN,-- mobile_money_available
    banks::BOOLEAN,-- banks_available
    mrkt_monda::BOOLEAN,-- market_monday
    mrkt_tuesd::BOOLEAN,-- market_tuesday
    mrkt_wedne::BOOLEAN,-- market_wednesday
    mrkt_thurs::BOOLEAN,-- market_thursday
    mrkt_frida::BOOLEAN,-- market_friday
    mrkt_satur::BOOLEAN,-- market_saturday
    mrkt_sunda::BOOLEAN,-- market_sunday
    trader_mon::INTEGER,-- count_traders_monday
    trader_tue::INTEGER,-- count_traders_tuesday
    trader_wed::INTEGER,-- count_traders_wednesday
    trader_thu::INTEGER,-- count_traders_thursday
    trader_fri::INTEGER,-- count_traders_friday
    trader_sat::INTEGER,-- count_traders_saturday
    trader_sun::INTEGER,-- count_traders_sunday
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
    petrol_sta::BOOLEAN, -- petrol_station_in_community
    ifnodistan::INTEGER, -- distance_to_nearest_petrol_station_km
    LOWER(gen_owners), -- households_with_genset_percentage 
    averagesiz::real, -- households_genset_size_avg_kva
    LOWER(businesses), -- businesses_with_genset_percentage
    average_si::real, -- businesses_genset_size_avg_kva
    CASE -- network_mtn
        WHEN (network_mt = 'N/A') THEN 'not_available'
        ELSE network_mt
    END,
    CASE -- network_airtel
        WHEN (network_ai = 'N/A') THEN 'not_available'
        ELSE network_ai
    END,   
    CASE -- network_9mobile
        WHEN (network_9m = 'N/A') THEN 'not_available'
        ELSE network_9m
    END,
    CASE -- network_glo
        WHEN (network_gl = 'N/A') THEN 'not_available'
        ELSE network_gl
    END,
    CASE -- network_others
        WHEN (network_ot = 'N/A') THEN 'not_available'
        ELSE network_ot
    END,
    grindingmi::INTEGER, -- count_productive_use_grinding_mills
    oilpress::INTEGER, -- count_productive_use_oil_press
    other_acti::INTEGER, -- count_productive_use_other
    LOWER(specified_), -- name_productive_use_other
    barberbeau::INTEGER, -- count_commercial_barber_beauty_salon
    tailordres::INTEGER, -- count_commercial_tailor_dressmaker
    convenienc::INTEGER, -- count_commercial_shop_kiosk
    phonecharg::INTEGER, -- count_commercial_phone_charging
    teashop::INTEGER,    -- count_commercial_tea_shop
    posshop::INTEGER,    -- count_commercial_pos_shop
    other_comm::INTEGER, -- count_commercial_other
    LOWER(specify_co), -- name_commercial_other
    carpenter::INTEGER, -- count_craft_carpenter
    welder::INTEGER, -- count_craft_welder
    vulcanizer::INTEGER, -- count_craft_vulcanizer
    carrepair::INTEGER, -- count_craft_car_repair
    bikerepair::INTEGER, -- count_craft_bike_repair
    generatorr::INTEGER, -- count_craft_generator_repair
    shoemaker::INTEGER, -- count_craft_shoemaker
    other_craf::INTEGER, -- count_craft_other
    LOWER(specify_cr), -- name_craft_other
    CASE -- accesibility_motorbike
        WHEN (motorbike = 'Dry season Rainy season') THEN 'all_year_round'
        WHEN (motorbike = 'Dry season') THEN 'dry_season_only'
        WHEN (motorbike = 'N/A') THEN 'never' 
    END,
    CASE -- accessibility_4x4_car
        WHEN (x4caregsuv = 'Dry season Rainy season') THEN 'all_year_round' 
        WHEN (x4caregsuv = 'Dry season') THEN 'dry_season_only'
        WHEN (x4caregsuv = 'N/A') THEN 'never' 
    END,    
    CASE -- accessibility_truck
        WHEN (truck = 'Dry season Rainy season') THEN 'all_year_round'
        WHEN (truck = 'Dry season') THEN 'dry_season_only'
        WHEN (truck = 'N/A') THEN 'never' 
    END,
    CASE -- accessibility_saloon_car
        WHEN (salooncar = 'Dry season Rainy season') THEN 'all_year_round'
        WHEN (salooncar = 'Dry season') THEN 'dry_season_only'
        WHEN (salooncar = 'N/A') THEN 'never' 
    END,
    CASE -- accessibility_public_transport
        WHEN (publictran = 'Dry season Rainy season') THEN 'all_year_round'
        WHEN (publictran = 'Dry season') THEN 'dry_season_only'
        WHEN (publictran = 'N/A') THEN 'never' 
    END,
    -- generalcom, -- community_notes
   -- mg_present::BOOLEAN, -- mini_grid_presence
   -- mg_status, -- mini_grid_status
    --mg_gen_typ, -- mini_grid_primary_generation_type
    ST_Transform(geom,3857)
FROM import.offgrid_survey_kwara_wo_1;

-- Update values from cluster_offgrid

UPDATE se4all.cluster_offgrid_survey AS s_cos
SET building_count = s_co.building_count
FROM se4all.cluster_offgrid AS s_co
WHERE ST_Within(s_cos.geom, s_co.geom);

UPDATE se4all.cluster_offgrid_survey AS s_cos
SET grid_dist_km = s_co.grid_dist_km
FROM se4all.cluster_offgrid AS s_co
WHERE ST_Within(s_cos.geom, s_co.geom);

--error in running DB log, something to do with the postgres version, removed for now.
-- database log (project,version,io,schema_name,table_name,script_name,comment)
--SELECT database_log('se4all','v0','setup','se4all','cluster_offgrid_survey','cluster_offgrid_survey_processing_kwara.sql','Insert data');


-- insert data from import for SURVEY Kwara 2
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
    crop_cultivated_cashew,
    crop_cultivated_yam,
    crop_cultivated_cocoa,
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
    count_commercial_tea_shop,
    count_commercial_pos_shop,
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
   -- mini_grid_presence,
   -- mini_grid_status,
   -- mini_grid_primary_generation_type,
    geom
)
SELECT 
    cluster_id::INTEGER, -- cluster_offgrid_id
    wo_check::INTEGER, -- wo_number
    settlement::INTEGER, -- settlement_wo_id
    TO_DATE(enteradate, 'DD/MM/YYYY'), -- survey_date
    INITCAP(state_chec), -- state_name
    INITCAP(selectlga), -- lga_name
    INITCAP(communityn), -- community_name
    CASE  -- grid_presence
        WHEN(grid= 'No') THEN 'no'
        WHEN(grid = 'Yes (connected to national grid)') THEN 'yes_connected_national_grid'
        WHEN(grid = 'Yes (not connected to national grid)') THEN 'yes_not_connected_national_grid'
    END,
    CASE  -- grid_voltage
        WHEN(voltage_of = 'LV') THEN 'lv'
        WHEN(voltage_of = 'MV') THEN 'mv'
        WHEN(voltage_of = 'MV & LV') THEN 'mv_and_lv'
    END,
    CASE  -- grid_distance_to_mv
        WHEN(distance_o = 'Greater than 5km') THEN 'greater_than_5_km'
        WHEN(distance_o = 'Less than 5km') THEN 'less_than_5_km'
    END,
    grid_struc::BOOLEAN, -- grid_structure_presence
    year_built, -- grid_year_built
    poles::BOOLEAN, -- grid_poles_presence
    cable::BOOLEAN, -- grid_cable_presence
    transforme::BOOLEAN, -- grid_transformer_presence
    CASE -- grid_functionality
        WHEN(function_c = 'Functional' AND function_t = 'Functional') THEN 'everything_functional'
        WHEN(function_t = 'Functional') THEN 'transformer_only_functional'
        WHEN(function_c = 'Never functional' OR function_t = 'Never functional') THEN 'never_functional'
    END,
    LOWER("primary"), -- income_source_primary
    LOWER("secondary"), -- income_source_secondary
    LOWER(third), -- income_source_third
    LOWER(fourth), -- income_source_fourth
    crop_culti::BOOLEAN, -- crop_cultivated_millet
    crop_cul_1::BOOLEAN, -- crop_cultivated_guinea_corn
    crop_cul_2::BOOLEAN, -- crop_cultivated_groundnut
    crop_cul_3::BOOLEAN, -- crop_cultivated_maize
    crop_cul_4::BOOLEAN, -- crop_cultivated_rice
    crop_cul_5::BOOLEAN, -- crop_cultivated_beans
    crop_cul_6::BOOLEAN, -- crop_cultivated_pepper
    crop_cul_7::BOOLEAN, -- crop_cultivated_sweet_potatoes
    crop_cul_8::BOOLEAN, -- crop_cultivated_hibiscus_leaf
    crop_cul_9::BOOLEAN, -- crop_cultivated_sesame_seed
    crop_cul10::BOOLEAN, -- crop_cultivated_cassava
    crop_cul11::BOOLEAN, -- crop_cultivated_cashew
    crop_cul12::BOOLEAN, -- crop_cultivated_yam
    crop_cul13::BOOLEAN, -- crop_cultivated_cocoa
    LOWER(other_crop), -- crop_cultivated_other_1
    LOWER(other_cr_1), -- crop_cultivated_other_2
    LOWER(other_cr_2), -- crop_cultivated_other_3
    CASE  -- crop_cultivated_primary
        WHEN(primarycro = 'Others(1)') THEN LOWER(other_crop)
        WHEN(primarycro = 'Others(2)') THEN LOWER(other_cr_1)
        WHEN(primarycro = 'Others(3)') THEN LOWER(other_cr_2)
        ELSE LOWER(primarycro)
    END,
    CASE  -- crop_cultivated_secondary
        WHEN(secondaryc = 'Others(1)') THEN LOWER(other_crop)
        WHEN(secondaryc = 'Others(2)') THEN LOWER(other_cr_1)
        WHEN(secondaryc = 'Others(3)') THEN LOWER(other_cr_2)
        ELSE LOWER(secondaryc)
    END,
    CASE  -- crop_cultivated_third
        WHEN(thirdcropc = 'Others(1)') THEN LOWER(other_crop)
        WHEN(thirdcropc = 'Others(2)') THEN LOWER(other_cr_1)
        WHEN(thirdcropc = 'Others(3)') THEN LOWER(other_cr_2)
        ELSE LOWER(thirdcropc)
    END,
    CASE  -- crop_cultivated_fourth
        WHEN(fourthcrop = 'Others(1)') THEN LOWER(other_crop)
        WHEN(fourthcrop = 'Others(2)') THEN LOWER(other_cr_1)
        WHEN(fourthcrop = 'Others(3)') THEN LOWER(other_cr_2)
        ELSE LOWER(fourthcrop)
    END,
    primarysch::INTEGER, -- count_primary_schools
    secondarys::INTEGER, -- count_secondary_schools
    healthfaci::INTEGER, -- count_health_facilities
    mobile_mon::BOOLEAN,-- mobile_money_available
    banks::BOOLEAN,-- banks_available
    mrkt_monda::BOOLEAN,-- market_monday
    mrkt_tuesd::BOOLEAN,-- market_tuesday
    mrkt_wedne::BOOLEAN,-- market_wednesday
    mrkt_thurs::BOOLEAN,-- market_thursday
    mrkt_frida::BOOLEAN,-- market_friday
    mrkt_satur::BOOLEAN,-- market_saturday
    mrkt_sunda::BOOLEAN,-- market_sunday
    trader_mon::INTEGER,-- count_traders_monday
    trader_tue::INTEGER,-- count_traders_tuesday
    trader_wed::INTEGER,-- count_traders_wednesday
    trader_thu::INTEGER,-- count_traders_thursday
    trader_fri::INTEGER,-- count_traders_friday
    trader_sat::INTEGER,-- count_traders_saturday
    trader_sun::INTEGER,-- count_traders_sunday
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
    petrol_sta::BOOLEAN, -- petrol_station_in_community
    ifnodistan::INTEGER, -- distance_to_nearest_petrol_station_km
    LOWER(gen_owners), -- households_with_genset_percentage 
    averagesiz::real, -- households_genset_size_avg_kva
    LOWER(businesses), -- businesses_with_genset_percentage
    average_si::real, -- businesses_genset_size_avg_kva
    CASE -- network_mtn
        WHEN (network_mt = 'N/A') THEN 'not_available'
        ELSE network_mt
    END,
    CASE -- network_airtel
        WHEN (network_ai = 'N/A') THEN 'not_available'
        ELSE network_ai
    END,   
    CASE -- network_9mobile
        WHEN (network_9m = 'N/A') THEN 'not_available'
        ELSE network_9m
    END,
    CASE -- network_glo
        WHEN (network_gl = 'N/A') THEN 'not_available'
        ELSE network_gl
    END,
    CASE -- network_others
        WHEN (network_ot = 'N/A') THEN 'not_available'
        ELSE network_ot
    END,
    grindingmi::INTEGER, -- count_productive_use_grinding_mills
    oilpress::INTEGER, -- count_productive_use_oil_press
    other_acti::INTEGER, -- count_productive_use_other
    LOWER(specified_), -- name_productive_use_other
    barberbeau::INTEGER, -- count_commercial_barber_beauty_salon
    tailordres::INTEGER, -- count_commercial_tailor_dressmaker
    convenienc::INTEGER, -- count_commercial_shop_kiosk
    phonecharg::INTEGER, -- count_commercial_phone_charging
    teashop::INTEGER,    -- count_commercial_tea_shop
    posshop::INTEGER,    -- count_commercial_pos_shop
    other_comm::INTEGER, -- count_commercial_other
    LOWER(specify_co), -- name_commercial_other
    carpenter::INTEGER, -- count_craft_carpenter
    welder::INTEGER, -- count_craft_welder
    vulcanizer::INTEGER, -- count_craft_vulcanizer
    carrepair::INTEGER, -- count_craft_car_repair
    bikerepair::INTEGER, -- count_craft_bike_repair
    generatorr::INTEGER, -- count_craft_generator_repair
    shoemaker::INTEGER, -- count_craft_shoemaker
    other_craf::INTEGER, -- count_craft_other
    LOWER(specify_cr), -- name_craft_other
    CASE -- accessibility_motorbike
        WHEN (motorbike = 'Dry season Rainy season') THEN 'all_year_round'
        WHEN (motorbike = 'Dry season') THEN 'dry_season_only'
        WHEN (motorbike = 'N/A') THEN 'never' 
    END,
    CASE -- accessibility_4x4_car
        WHEN (x4caregsuv = 'Dry season Rainy season') THEN 'all_year_round' 
        WHEN (x4caregsuv = 'Dry season') THEN 'dry_season_only'
        WHEN (x4caregsuv = 'N/A') THEN 'never' 
    END,    
    CASE -- accessibility_truck
        WHEN (truck = 'Dry season Rainy season') THEN 'all_year_round'
        WHEN (truck = 'Dry season') THEN 'dry_season_only'
        WHEN (truck = 'N/A') THEN 'never' 
    END,
    CASE -- accessibility_saloon_car
        WHEN (salooncar = 'Dry season Rainy season') THEN 'all_year_round'
        WHEN (salooncar = 'Dry season') THEN 'dry_season_only'
        WHEN (salooncar = 'N/A') THEN 'never' 
    END,
    CASE -- accessibility_public_transport
        WHEN (publictran = 'Dry season Rainy season') THEN 'all_year_round'
        WHEN (publictran = 'Dry season') THEN 'dry_season_only'
        WHEN (publictran = 'N/A') THEN 'never' 
    END,
    -- generalcom, -- community_notes
   -- mg_present::BOOLEAN, -- mini_grid_presence
   -- mg_status, -- mini_grid_status
    --mg_gen_typ, -- mini_grid_primary_generation_type
    ST_Transform(geom,3857)
FROM import.offgrid_survey_kwara_wo_2;

-- Update values from cluster_offgrid

UPDATE se4all.cluster_offgrid_survey AS s_cos
SET building_count = s_co.building_count
FROM se4all.cluster_offgrid AS s_co
WHERE ST_Within(s_cos.geom, s_co.geom);

UPDATE se4all.cluster_offgrid_survey AS s_cos
SET grid_dist_km = s_co.grid_dist_km
FROM se4all.cluster_offgrid AS s_co
WHERE ST_Within(s_cos.geom, s_co.geom);

--error in running DB log, something to do with the postgres version, removed for now.
-- database log (project,version,io,schema_name,table_name,script_name,comment)
--SELECT database_log('se4all','v0','setup','se4all','cluster_offgrid_survey','cluster_offgrid_survey_processing_kwara.sql','Insert data');

