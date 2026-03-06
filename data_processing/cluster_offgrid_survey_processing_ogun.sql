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
WHERE state_name = 'Ogun';

-- insert data from import for SURVEY OGUN 1 (there is no WO 2 in OGUN)
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
    -- mini_grid_presence,
    -- mini_grid_status,
    -- mini_grid_primary_generation_type,
    -- community_notes,
    geom
)
SELECT 
    clustr_id::INTEGER, -- cluster_offgrid_id
    wo_check::INTEGER, -- wo_number
    settlement::INTEGER, -- settlement_wo_id
    TO_DATE("enter a da", 'YYYY-MM-DD'), -- survey_date
    INITCAP(state_chec), -- state_name
    CASE -- lga_name
        WHEN("select lga" = '1') THEN 'Abeokuta North'
        WHEN("select lga" = '2') THEN 'Abeokuta South'
        WHEN("select lga" = '3') THEN 'Ado Odo-Ota'
        WHEN("select lga" = '4') THEN 'Egbado North'
        WHEN("select lga" = '5') THEN 'Egbado South'
        WHEN("select lga" = '6') THEN 'Ewekoro'
        WHEN("select lga" = '7') THEN 'Ifo'
        WHEN("select lga" = '8') THEN 'Ijebu East'
        WHEN("select lga" = '9') THEN 'Ijebu North'
        WHEN("select lga" = '10') THEN 'Ijebu North East'
        WHEN("select lga" = '11') THEN 'Ijebu Ode'
        WHEN("select lga" = '12') THEN 'Ikenne'
        WHEN("select lga" = '13') THEN 'Imeko Afon'
        WHEN("select lga" = '14') THEN 'Ipokia'
        WHEN("select lga" = '15') THEN 'Obafemi Owode'
        WHEN("select lga" = '16') THEN 'Odeda'
        WHEN("select lga" = '17') THEN 'Odogbolu'
        WHEN("select lga" = '18') THEN 'Ogun Waterside'
        WHEN("select lga" = '19') THEN 'Remo North'
        WHEN("select lga" = '20') THEN 'Sagamu'
    END,
    INITCAP(community), -- community_name
    CASE  -- grid_presence
        WHEN("enumerat_1" = '0') THEN 'no'
        WHEN("enumerat_1" = '1') THEN 'yes_connected_national_grid'
        WHEN("enumerat_1" = '2') THEN 'yes_not_connected_national_grid'
    END,
    CASE  -- grid_voltage
        WHEN("what is th" = '1') THEN 'lv'
        WHEN("what is th" = '2') THEN 'mv'
        WHEN("what is th" = '3') THEN 'mv_and_lv'
    END,
    CASE  -- grid_distance_to_mv
        WHEN("what is _1" = '2') THEN 'greater_than_5_km'
        WHEN("what is _1" = '1') THEN 'less_than_5_km'
    END,
    "is there g"::BOOLEAN, -- grid_structure_presence
    "what year", -- grid_year_built
    poles::BOOLEAN, -- grid_poles_presence
    cable::BOOLEAN, -- grid_cable_presence
    transforme::BOOLEAN, -- grid_transformer_presence
    CASE -- grid_functionality
        WHEN(cable_1 = '1' AND transfor_1 = '1') THEN 'everything_functional'
        WHEN(transfor_1 = '1') THEN 'transformer_only_functional'
        WHEN(cable_1 = '2' OR transfor_1 = '2') THEN 'never_functional'
    END,
    LOWER("1) primary"), -- income_source_primary
    LOWER("2) seconda"), -- income_source_secondary
    LOWER("3) third"), -- income_source_third
    LOWER("4) fourth"), -- income_source_fourth
    "main cro_1"::BOOLEAN, -- crop_cultivated_millet
    "main cro_2"::BOOLEAN, -- crop_cultivated_guinea_corn
    "main cro_3"::BOOLEAN, -- crop_cultivated_groundnut
    "main cro_4"::BOOLEAN, -- crop_cultivated_maize
    "main cro_5"::BOOLEAN, -- crop_cultivated_rice
    "main cro_6"::BOOLEAN, -- crop_cultivated_beans
    "main cro_7"::BOOLEAN, -- crop_cultivated_pepper
    "main cro_8"::BOOLEAN, -- crop_cultivated_sweet_potatoes
    "main cro_9"::BOOLEAN, -- crop_cultivated_hibiscus_leaf
    "main cro10"::BOOLEAN, -- crop_cultivated_sesame_seed
    "main cro11"::BOOLEAN, -- crop_cultivated_cassava
    LOWER("other spec"), -- crop_cultivated_other_1
    LOWER("other sp_1"), -- crop_cultivated_other_2
    LOWER("other sp_2"), -- crop_cultivated_other_3
    CASE  -- crop_cultivated_primary
        WHEN("primary cr" = '1') THEN 'millet'
        WHEN("primary cr" = '2') THEN 'guinea corn'
        WHEN("primary cr" = '3') THEN 'groundnut'
        WHEN("primary cr" = '4') THEN 'maize'
        WHEN("primary cr" = '5') THEN 'rice'
        WHEN("primary cr" = '6') THEN 'beans'
        WHEN("primary cr" = '7') THEN 'pepper'
        WHEN("primary cr" = '8') THEN 'sweet potatoes'
        WHEN("primary cr" = '9') THEN 'hibiscus leaf'
        WHEN("primary cr" = '10') THEN 'sesame seed'
        WHEN("primary cr" = '11') THEN 'cassava'
        WHEN("primary cr" = '96') THEN LOWER("other spec")
        WHEN("primary cr" = '97') THEN LOWER("other sp_1")
        WHEN("primary cr" = '98') THEN LOWER("other sp_2")
    END,
    CASE  -- crop_cultivated_secondary
        WHEN("secondary" = '1') THEN 'millet'
        WHEN("secondary" = '2') THEN 'guinea corn'
        WHEN("secondary" = '3') THEN 'groundnut'
        WHEN("secondary" = '4') THEN 'maize'
        WHEN("secondary" = '5') THEN 'rice'
        WHEN("secondary" = '6') THEN 'beans'
        WHEN("secondary" = '7') THEN 'pepper'
        WHEN("secondary" = '8') THEN 'sweet potatoes'
        WHEN("secondary" = '9') THEN 'hibiscus leaf'
        WHEN("secondary" = '10') THEN 'sesame seed'
        WHEN("secondary" = '11') THEN 'cassava'
        WHEN("secondary" = '96') THEN LOWER("other spec")
        WHEN("secondary" = '97') THEN LOWER("other sp_1")
        WHEN("secondary" = '98') THEN LOWER("other sp_2")
    END,
    CASE  -- crop_cultivated_third
        WHEN("third crop" = '1') THEN 'millet'
        WHEN("third crop" = '2') THEN 'guinea corn'
        WHEN("third crop" = '3') THEN 'groundnut'
        WHEN("third crop" = '4') THEN 'maize'
        WHEN("third crop" = '5') THEN 'rice'
        WHEN("third crop" = '6') THEN 'beans'
        WHEN("third crop" = '7') THEN 'pepper'
        WHEN("third crop" = '8') THEN 'sweet potatoes'
        WHEN("third crop" = '9') THEN 'hibiscus leaf'
        WHEN("third crop" = '10') THEN 'sesame seed'
        WHEN("third crop" = '11') THEN 'cassava'
        WHEN("third crop" = '96') THEN LOWER("other spec")
        WHEN("third crop" = '97') THEN LOWER("other sp_1")
        WHEN("third crop" = '98') THEN LOWER("other sp_2")
    END,
    CASE  -- crop_cultivated_fourth
        WHEN("fourth cro" = '1') THEN 'millet'
        WHEN("fourth cro" = '2') THEN 'guinea corn'
        WHEN("fourth cro" = '3') THEN 'groundnut'
        WHEN("fourth cro" = '4') THEN 'maize'
        WHEN("fourth cro" = '5') THEN 'rice'
        WHEN("fourth cro" = '6') THEN 'beans'
        WHEN("fourth cro" = '7') THEN 'pepper'
        WHEN("fourth cro" = '8') THEN 'sweet potatoes'
        WHEN("fourth cro" = '9') THEN 'hibiscus leaf'
        WHEN("fourth cro" = '10') THEN 'sesame seed'
        WHEN("fourth cro" = '11') THEN 'cassava'
        WHEN("fourth cro" = '96') THEN LOWER("other spec")
        WHEN("fourth cro" = '97') THEN LOWER("other sp_1")
        WHEN("fourth cro" = '98') THEN LOWER("other sp_2")
    END,
    "primary sc"::INTEGER, -- count_primary_schools
    secondar_1::INTEGER, -- count_secondary_schools
    "health fac"::INTEGER, -- count_health_facilities
    "mobile mon"::BOOLEAN,-- mobile_money_available
    banks::BOOLEAN,-- banks_available
    monday::BOOLEAN,-- market_monday
    tuesday::BOOLEAN,-- market_tuesday
    wednesday::BOOLEAN,-- market_wednesday
    thursday::BOOLEAN,-- market_thursday
    friday::BOOLEAN,-- market_friday
    saturday::BOOLEAN,-- market_saturday
    sunday::BOOLEAN,-- market_sunday
    monday_1::INTEGER,-- count_traders_monday
    tuesday_1::INTEGER,-- count_traders_tuesday
    wednesday_::INTEGER,-- count_traders_wednesday
    thursday_1::INTEGER,-- count_traders_thursday
    friday_1::INTEGER,-- count_traders_friday
    saturday_1::INTEGER,-- count_traders_saturday
    sunday_1::INTEGER,-- count_traders_sunday
    CASE -- petrol_price_ngn_per_litre
        WHEN ("petrol (li"::INTEGER < 0) THEN null
        ELSE "petrol (li"::INTEGER
    END,
    CASE -- diesel_price_ngn_per_litre
        WHEN ("diesel (li"::INTEGER < 0) THEN null
        ELSE "diesel (li"::INTEGER
    END,       
    CASE -- kerosene_price_ngn_per_litre
        WHEN ("kerosene ("::INTEGER < 0) THEN null
        ELSE "kerosene ("::INTEGER
    END,   
    "petrol sta"::BOOLEAN, -- petrol_station_in_community
    "if no, dis"::INTEGER, -- distance_to_nearest_petrol_station_km
    CASE -- households_with_genset_percentage 
        WHEN ("% househol" = '1') THEN '>90%'
        WHEN ("% househol" = '2') THEN '75%'
        WHEN ("% househol" = '3') THEN '50%'
        WHEN ("% househol" = '4') THEN '25%'
        WHEN ("% househol" = '5') THEN '10%'
    END,
    "average si"::real, -- households_genset_size_avg_kva
    CASE -- businesses_with_genset_percentage
        WHEN ("% business" = '1') THEN '>90%'
        WHEN ("% business" = '2') THEN '75%'
        WHEN ("% business" = '3') THEN '50%'
        WHEN ("% business" = '4') THEN '25%'
        WHEN ("% business" = '5') THEN '10%'
    END,     
    "average _1"::real, -- businesses_genset_size_avg_kva
    CASE -- network_mtn
        WHEN (mtn = '1') THEN '2G'
        WHEN (mtn = '2') THEN '3G'
        WHEN (mtn = '3') THEN '4G'
        WHEN (mtn = '4') THEN 'not_available'
    END,
    CASE -- network_airtel
        WHEN (airtel = '1') THEN '2G'
        WHEN (airtel = '2') THEN '3G'
        WHEN (airtel = '3') THEN '4G'
        WHEN (airtel = '4') THEN 'not_available'
    END,
    CASE -- network_9mobile
        WHEN ("9mobile" = '1') THEN '2G'
        WHEN ("9mobile" = '2') THEN '3G'
        WHEN ("9mobile" = '3') THEN '4G'
        WHEN ("9mobile" = '4') THEN 'not_available'
    END, 
    CASE -- network_glo
        WHEN (glo = '1') THEN '2G'
        WHEN (glo = '2') THEN '3G'
        WHEN (glo = '3') THEN '4G'
        WHEN (glo = '4') THEN 'not_available'
    END, 
    CASE -- network_others
        WHEN (others = '1') THEN '2G'
        WHEN (others = '2') THEN '3G'
        WHEN (others = '3') THEN '4G'
        WHEN (others = '4') THEN 'not_available'
    END, 
    "grinding m"::INTEGER, -- count_productive_use_grinding_mills
    "oil press"::INTEGER, -- count_productive_use_oil_press
    "others_1"::INTEGER, -- count_productive_use_other
    LOWER("please s_1"), -- name_productive_use_other
    "barber/bea"::INTEGER, -- count_commercial_barber_beauty_salon
    "tailor/dre"::INTEGER, -- count_commercial_tailor_dressmaker
    "convenienc"::INTEGER, -- count_commercial_shop_kiosk
    "phone char"::INTEGER, -- count_commercial_phone_charging
    "others_2"::INTEGER, -- count_commercial_other
    LOWER("others_3"), -- name_commercial_other
    carpenter::INTEGER, -- count_craft_carpenter
    welder::INTEGER, -- count_craft_welder
    vulcanizer::INTEGER, -- count_craft_vulcanizer
    "car repair"::INTEGER, -- count_craft_car_repair
    "bike repai"::INTEGER, -- count_craft_bike_repair
    generato_1::INTEGER, -- count_craft_generator_repair
    shoemaker::INTEGER, -- count_craft_shoemaker
    "other(s)"::INTEGER, -- count_craft_other
    LOWER("others_4"), -- name_craft_other
    CASE -- accessibility_motorbike
        WHEN (motorbike = '1 2') THEN 'all_year_round'
        WHEN (motorbike = '1') THEN 'dry_season'
        WHEN (motorbike = '3') THEN 'never' 
    END,
    CASE -- accessibility_4x4_car
        WHEN ("4x4 car (e" = '1 2') THEN 'all_year_round' 
        WHEN ("4x4 car (e" = '1') THEN 'dry_season'
        WHEN ("4x4 car (e" = '3') THEN 'never' 
    END,    
    CASE -- accessibility_truck
        WHEN (truck = '1 2') THEN 'all_year_round'
        WHEN (truck = '1') THEN 'dry_season'
        WHEN (truck = '3') THEN 'never' 
    END,
    CASE -- accessibility_saloon_car
        WHEN ("saloon car" = '1 2') THEN 'all_year_round'
        WHEN ("saloon car" = '1') THEN 'dry_season'
        WHEN ("saloon car" = '3') THEN 'never' 
    END,
    CASE -- accessibility_public_transport
        WHEN ("public tra" = '1 2') THEN 'all_year_round'
        WHEN ("public tra" = '1') THEN 'dry_season'
        WHEN ("public tra" = '3') THEN 'never' 
    END,
    -- generalcom, -- community_notes
    -- mg_present::BOOLEAN, -- mini_grid_presence
    -- mg_status, -- mini_grid_status
    -- mg_gen_typ, -- mini_grid_primary_generation_type
    ST_Transform(geom,3857)
FROM import.offgrid_survey_ogun_wo_1;


-- Update values from cluster_offgrid

UPDATE se4all.cluster_offgrid_survey AS s_cos
SET building_count = s_co.building_count
FROM se4all.cluster_offgrid AS s_co
WHERE ST_Within(s_cos.geom, s_co.geom);

UPDATE se4all.cluster_offgrid_survey AS s_cos
SET grid_dist_km = s_co.grid_dist_km
FROM se4all.cluster_offgrid AS s_co
WHERE ST_Within(s_cos.geom, s_co.geom);

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_offgrid_survey','cluster_offgrid_survey_processing_ogun.sql','Insert data');