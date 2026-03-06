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

-- delete all data
DELETE FROM se4all.supply_quality_survey;

-- insert data from Nasarawa
INSERT INTO se4all.supply_quality_survey (
    survey_date,
    state_name,
    lga_name,
    ward_name,
    -- community_name,
    electricity_supply_from_any_source,
    grid_source, 
    genset_source, 
    genset_size,
    shs_source, 
    shs_size,
    grid_presence,
    infrastructure_connected_mv,
    grid_year_built,
    grid_poles_presence,
    grid_cable_presence,
    grid_transformer_presence,
    grid_functionality,
    time_last_functioned,
    year_last_functioned,
    frequency_on,
    duration_on,
    rationed,
    rationed_explain,
    low_voltage,
    low_voltage_explain,
    geom
)
SELECT 
    TO_DATE("date"::varchar, 'MM/DD/YYYY'), -- survey_date,
    INITCAP("1. state"), -- state_name,
    INITCAP("2. lga"), -- lga_name,
    INITCAP("3. ward"), -- ward_name,
    -- "4. heath facility name", -- community_name,
    CASE -- electricity_supply_from_any_source,
        WHEN("11. electricity supply (from any source)?" = 'Yes') THEN TRUE
        WHEN("11. electricity supply (from any source)?" = 'No electricity supply') THEN FALSE
    END,
    "12. select the sources of electricity/grid supply from nepa/aed"::BOOLEAN, -- grid_source, 
    "12. select the sources of electricity/diesel/petrol generator"::BOOLEAN, -- genset_source, 
    "12a. what is your generator capacity?", -- genset_size,
    "12. select the sources of electricity/supply from solar home sy"::BOOLEAN, -- shs_source, 
    "12b. what is the inverter size and number of batteries you use?", -- shs_size,
    "14. is there any national grid (nepa) infrastructure (working o"::BOOLEAN, -- grid_presence,
    CASE -- infrastructure_connected_mv
        WHEN("15. is the lv grid infrastructure connected to the national gri" = 'Yes, there is a connection to the national grid') THEN TRUE
        WHEN("15. is the lv grid infrastructure connected to the national gri" = 'No, the MV / national grid is far away from the Heath Centre') THEN FALSE
    END,
    "16. year grid infrastructure built", -- grid_year_built
    CASE -- grid_poles_presence
        WHEN("18. is there any national grid (nepa/aedc) infrastructure (work" LIKE '%Poles%') THEN TRUE
    END,
    CASE -- grid_cable_presence
        WHEN("18. is there any national grid (nepa/aedc) infrastructure (work" LIKE '%Cable%') THEN TRUE
    END,
    CASE -- grid_transformer_presence
        WHEN("18. is there any national grid (nepa/aedc) infrastructure (work" LIKE '%Transformer%') THEN TRUE
    END,
    "19. has the national grid (nepa/aedc) ever functioned at the he"::BOOLEAN, -- grid_functionality,
    CASE -- time_last_functioned
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Few Hours Ago') THEN 'few_hrs_ago'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Yesterday') THEN 'yesterday'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Two Days Ago') THEN 'two_days_ago'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Last Week') THEN 'last_week'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'A Month Ago') THEN '1_month_ago'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Above a Month Ago') THEN '>1_month_ago'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'A Year or More') THEN '>=1_yr_ago'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Never Had Light') THEN 'never'
    END,
    "21. year last light", -- year_last_functioned,
    CASE -- frequency_on
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Always (Every Day)') THEN 'every_day'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Often (Once In Two Days)') THEN 'once_every_2_days'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Sometimes (Once A Week)') THEN 'once_per_week'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Sometimes (Once A Month)') THEN 'once_per_month'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'No Light (For a long Period of Time)') THEN 'not_for_a_long_period'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Never (The Light Was Never On)') THEN 'never'
    END,
    CASE -- duration_on
        WHEN("23. length of time lights are on" = 'Never') THEN 'never'
        WHEN("23. length of time lights are on" = 'Lights remain ON for just a few hours then go off again') THEN 'few_hrs'
        WHEN("23. length of time lights are on" = 'Lights remain ON for more than 4 hours per day') THEN '>4_hrs_day'
        WHEN("23. length of time lights are on" = 'Lights remain ON for more than 8 hours per day') THEN '>8_hrs_day'
        WHEN("23. length of time lights are on" = 'Lights remain ON for at least half of the day (12 or more hours)') THEN '>12_hrs_day'
        WHEN("23. length of time lights are on" = 'Lights remain ON for a few days') THEN 'few_days'
        WHEN("23. length of time lights are on" = 'Lights remain ON for a few weeks') THEN 'few_weeks'
    END,
    "24. is the grid supply from nepa/aedc rationed?"::BOOLEAN, -- rationed,
    "25. describe how the power is rationed (i.e. when does the heal", -- rationed_explain,
    "26. does the grid power have voltage (light dimming) problems?"::BOOLEAN, -- low_voltage
    "27. if yes please explain",-- low_voltage_explain
    ST_Transform(geom,3857)
FROM import.grid_supply_quality_nasarawa;

-- insert data from Kano
INSERT INTO se4all.supply_quality_survey (
    survey_date,
    state_name,
    lga_name,
    ward_name,
    -- community_name,
    electricity_supply_from_any_source,
    grid_source, 
    genset_source, 
    -- genset_size, info not available
    shs_source, 
    -- shs_size, info not available
    grid_presence,
    -- infrastructure_connected_mv, info not available
    -- grid_year_built, info not available
    grid_poles_presence,
    grid_cable_presence,
    grid_transformer_presence,
    grid_functionality,
    time_last_functioned,
    year_last_functioned,
    frequency_on,
    duration_on,
    rationed,
    rationed_explain,
    --low_voltage, info not available
    --low_voltage_explain, info not available
    geom
)
SELECT 
    TO_DATE("date"::varchar, 'YYYY-MM-DD'), -- survey_date,
    INITCAP("1. state"), -- state_name,
    INITCAP("2. lga"), -- lga_name,
    INITCAP("3. ward"), -- ward_name,
    -- "4. heath facility name", -- community_name,
    CASE -- electricity_supply_from_any_source,
        WHEN("11. electricity supply (from any source)?" = 'No electricity supply') THEN FALSE
        ELSE TRUE
    END,
    CASE -- grid_source, 
        WHEN("11. electricity supply (from any source)?" LIKE '%NEPA%') THEN TRUE
        ELSE FALSE
    END,
    CASE -- genset_source,
        WHEN("11. electricity supply (from any source)?" LIKE '%diesel generator%') THEN TRUE
        ELSE FALSE
    END,
    CASE -- shs_source, 
        WHEN("11. electricity supply (from any source)?" LIKE '%SHS%') THEN TRUE
        ELSE FALSE
    END,
    CASE  -- grid_presence,
        WHEN("18. is there any national grid (nepa/aedc) infrastructure (work" IS NULL) THEN FALSE
        ELSE TRUE
    END,
    CASE -- grid_poles_presence
        WHEN("18. is there any national grid (nepa/aedc) infrastructure (work" LIKE '%Poles%') THEN TRUE
    END,
    CASE -- grid_cable_presence
        WHEN("18. is there any national grid (nepa/aedc) infrastructure (work" LIKE '%Cable%') THEN TRUE
    END,
    CASE -- grid_transformer_presence
        WHEN("18. is there any national grid (nepa/aedc) infrastructure (work" LIKE '%Transformer%') THEN TRUE
    END,
    "19. has the national grid (nepa/aedc) ever functioned at the he"::BOOLEAN, -- grid_functionality,
    CASE -- time_last_functioned
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Few hours ago') THEN 'few_hrs_ago'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Yesterday') THEN 'yesterday'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Two days ago') THEN 'two_days_ago'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Last week') THEN 'last_week'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'A Month Ago') THEN '1_month_ago'
        -- WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Above a month ago') THEN '>1_month_ago'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'A Year or more') THEN '>=1_yr_ago'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Never had light') THEN 'never'
    END,
    "21. year last light", -- year_last_functioned,
    CASE -- frequency_on
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Always(Every Day)') THEN 'every_day'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Often(Once in two Days)') THEN 'once_every_2_days'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Sometimes(Once a week)') THEN 'once_per_week'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Seldom(Once a month)') THEN 'once_per_month'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'No Light (For a long Period of Time)') THEN 'not_for_a_long_period'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Never(The light was never ON)') THEN 'never'
    END,
    CASE -- duration_on
        WHEN("23. length of time lights are on" = 'Never') THEN 'never'
        WHEN("23. length of time lights are on" = 'Lights remain ON for just a few hours then go off again') THEN 'few_hrs'
        WHEN("23. length of time lights are on" = 'Lights remain ON for more than 4 hours per day') THEN '>4_hrs_day'
        WHEN("23. length of time lights are on" = 'Lights remain ON for more than 8 hours per day') THEN '>8_hrs_day'
        WHEN("23. length of time lights are on" = 'Lights remain ON for at least half of the day (12 or more hours)') THEN '>12_hrs_day'
        WHEN("23. length of time lights are on" = 'Lights remain ON for a few days') THEN 'few_days'
        WHEN("23. length of time lights are on" = 'Lights remain ON for a few weeks') THEN 'few_weeks'
    END,
    "24. is the grid supply from nepa/aedc rationed?"::BOOLEAN, -- rationed,
    "25. describe how the power is rationed (i.e. when does the heal", -- rationed_explain,
    --"26. does the grid power have voltage (light dimming) problems?"::BOOLEAN, -- low_voltage
    --"27. if yes please explain",-- low_voltage_explain
    ST_Transform(geom,3857)
FROM import.grid_supply_quality_kano;

-- insert data from Osun
INSERT INTO se4all.supply_quality_survey (
    survey_date,
    state_name,
    lga_name,
    ward_name,
    -- community_name,
    electricity_supply_from_any_source,
    grid_source, 
    genset_source, 
    -- genset_size, info not available
    shs_source, 
    -- shs_size, info not available
    grid_presence,
    -- infrastructure_connected_mv, info not available
    -- grid_year_built, info not available
    grid_poles_presence,
    grid_cable_presence,
    grid_transformer_presence,
    grid_functionality,
    time_last_functioned,
    year_last_functioned,
    frequency_on,
    duration_on,
    rationed,
    rationed_explain,
    --low_voltage, info not available
    --low_voltage_explain, info not available
    geom
)
SELECT 
    TO_DATE("date"::varchar, 'YYYY-MM-DD'), -- survey_date,
    INITCAP("1. state"), -- state_name,
    INITCAP("2. lga"), -- lga_name,
    INITCAP("3. ward"), -- ward_name,
    -- "4. heath facility name", -- community_name,
    CASE -- electricity_supply_from_any_source,
        WHEN("11. electricity supply (from any source)?" = 'No electricity supply') THEN FALSE
        ELSE TRUE
    END,
    CASE -- grid_source, 
        WHEN("11. electricity supply (from any source)?" LIKE '%NEPA%') THEN TRUE
        ELSE FALSE
    END,
    CASE -- genset_source,
        WHEN("11. electricity supply (from any source)?" LIKE '%diesel generator%') THEN TRUE
        ELSE FALSE
    END,
    CASE -- shs_source, 
        WHEN("11. electricity supply (from any source)?" LIKE '%SHS%') THEN TRUE
        ELSE FALSE
    END,
    CASE  -- grid_presence,
        WHEN("18. is there any national grid (nepa/aedc) infrastructure (work" IS NULL) THEN FALSE
        ELSE TRUE
    END,
    CASE -- grid_poles_presence
        WHEN("18. is there any national grid (nepa/aedc) infrastructure (work" LIKE '%Poles%') THEN TRUE
    END,
    CASE -- grid_cable_presence
        WHEN("18. is there any national grid (nepa/aedc) infrastructure (work" LIKE '%Cable%') THEN TRUE
    END,
    CASE -- grid_transformer_presence
        WHEN("18. is there any national grid (nepa/aedc) infrastructure (work" LIKE '%Transformer%') THEN TRUE
    END,
    "19. has the national grid (nepa/aedc) ever functioned at the he"::BOOLEAN, -- grid_functionality,
    CASE -- time_last_functioned
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Few hours ago') THEN 'few_hrs_ago'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Yesterday') THEN 'yesterday'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Two days ago') THEN 'two_days_ago'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Last week') THEN 'last_week'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'A Month Ago') THEN '1_month_ago'
        -- WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Above a month ago') THEN '>1_month_ago'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'A Year or more') THEN '>=1_yr_ago'
        WHEN("20. date that the power from the national grid (nepa/aedc) was " = 'Never had light') THEN 'never'
    END,
    "21. year last light", -- year_last_functioned,
    CASE -- frequency_on
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Always(Every Day)') THEN 'every_day'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Often(Once in two Days)') THEN 'once_every_2_days'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Sometimes(Once a week)') THEN 'once_per_week'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Seldom(Once a month)') THEN 'once_per_month'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'No Light (For a long Period of Time)') THEN 'not_for_a_long_period'
        WHEN("22. frequency of lights on from the national grid (nepa/aedc)" = 'Never(The light was never ON)') THEN 'never'
    END,
    CASE -- duration_on
        WHEN("23. length of time lights are on" = 'Never') THEN 'never'
        WHEN("23. length of time lights are on" = 'Lights remain ON for just a few hours then go off again') THEN 'few_hrs'
        WHEN("23. length of time lights are on" = 'Lights remain ON for more than 4 hours per day') THEN '>4_hrs_day'
        WHEN("23. length of time lights are on" = 'Lights remain ON for more than 8 hours per day') THEN '>8_hrs_day'
        WHEN("23. length of time lights are on" = 'Lights remain ON for at least half of the day (12 or more hours)') THEN '>12_hrs_day'
        WHEN("23. length of time lights are on" = 'Lights remain ON for a few days') THEN 'few_days'
        WHEN("23. length of time lights are on" = 'Lights remain ON for a few weeks') THEN 'few_weeks'
    END,
    "24. is the grid supply from nepa/aedc rationed?"::BOOLEAN, -- rationed,
    "25. describe how the power is rationed (i.e. when does the heal", -- rationed_explain,
    --"26. does the grid power have voltage (light dimming) problems?"::BOOLEAN, -- low_voltage
    --"27. if yes please explain",-- low_voltage_explain
    ST_Transform(geom,3857)
FROM import.grid_supply_quality_osun;


-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','supply_quality_survey','supply_quality_survey_processing_abia.sql','Insert data');
