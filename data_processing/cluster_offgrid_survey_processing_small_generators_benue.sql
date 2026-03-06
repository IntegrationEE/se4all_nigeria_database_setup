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
DELETE FROM se4all.cluster_offgrid_survey_small_generators
WHERE state_name = 'Benue';

-- insert data from import for survey_small_geneators Benue 1
INSERT INTO se4all.cluster_offgrid_survey_small_generators (
    cluster_offgrid_id,
    wo_number,
    settlement_wo_id,
    survey_date,
    state_name,
    -- lga_name,
    -- community_name,
    business_type,
    business_description,
    generator, -- solar or diesel
    geom
)
SELECT 
    clustr_id::INTEGER, -- cluster_offgrid_id
    wo_check::INTEGER, -- wo_number
    settlement::INTEGER, -- settlement_wo_id
    TO_DATE(today::varchar, 'YYYY-MM-DD'), -- survey_date
    INITCAP(state_chec), -- state_name
    -- INITCAP(selectlga), -- lga_name
    -- INITCAP(communityn), -- community_name
    fac_type, -- business_type
    CASE  -- business_description
        WHEN(fac_type = 'productive_user/production') THEN (
            SELECT
            CASE
                WHEN (productive = 'other type of production') THEN other_prdt
                ELSE productive
            END
        )
        WHEN(fac_type = 'commercial/shop') THEN (
            SELECT
            CASE
                WHEN (productive = 'other type of shops /commercial') THEN other_com
                ELSE com_type
            END
        )
        WHEN(fac_type = 'craft') THEN (
            SELECT
            CASE
                WHEN (craft = 'other craft(pls describe)') THEN other_prdt
                ELSE craft
            END
        )
        WHEN(fac_type = 'education') THEN (
            SELECT
            CASE
                WHEN (education = 'other type of education') THEN other_educ
                ELSE education
            END
        )
        WHEN(fac_type = 'health') THEN (
            SELECT
            CASE
                WHEN (health = 'other type of health') THEN other_hlth
                ELSE health
            END
        )
        WHEN(fac_type = 'public_amenity') THEN (
            SELECT
            CASE
                WHEN (publ_amnt = 'other public amenity') THEN other_publ
                ELSE publ_amnt
            END
        )
    END,
    CASE -- generator
        WHEN (generator = 'solar') THEN 'solar'
        WHEN (generator = 'yes, generator in use') THEN 'diesel'
        ELSE generator
    END,
    ST_Transform(geom,3857)
FROM import.offgrid_survey_small_generators_benue_wo_1
WHERE generator != 'no generator';

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_offgrid_survey_small_generators','cluster_offgrid_survey_processing_small_generators_benue_sql','Insert data');

-- insert data from import for survey_small_geneators Benue 2
INSERT INTO se4all.cluster_offgrid_survey_small_generators (
    cluster_offgrid_id,
    wo_number,
    settlement_wo_id,
    survey_date,
    state_name,
    -- lga_name,
    -- community_name,
    business_type,
    business_description,
    generator, -- solar or diesel
    geom
)
SELECT 
    clustr_id::INTEGER, -- cluster_offgrid_id
    wo_check::INTEGER, -- wo_number
    settlement::INTEGER, -- settlement_wo_id
    TO_DATE(today::varchar, 'YYYY-MM-DD'), -- survey_date
    INITCAP(state_chec), -- state_name
    -- INITCAP(selectlga), -- lga_name
    -- INITCAP(communityn), -- community_name
    fac_type, -- business_type
    CASE  -- business_description
        WHEN(fac_type = 'productive_user/production') THEN (
            SELECT
            CASE
                WHEN (productive = 'other type of production') THEN other_prdt
                ELSE productive
            END
        )
        WHEN(fac_type = 'commercial/shop') THEN (
            SELECT
            CASE
                WHEN (productive = 'other type of shops /commercial') THEN other_com
                ELSE com_type
            END
        )
        WHEN(fac_type = 'craft') THEN (
            SELECT
            CASE
                WHEN (craft = 'other craft(pls describe)') THEN other_prdt
                ELSE craft
            END
        )
        WHEN(fac_type = 'education') THEN (
            SELECT
            CASE
                WHEN (education = 'other type of education') THEN other_educ
                ELSE education
            END
        )
        WHEN(fac_type = 'health') THEN (
            SELECT
            CASE
                WHEN (health = 'other type of health') THEN other_hlth
                ELSE health
            END
        )
        WHEN(fac_type = 'public_amenity') THEN (
            SELECT
            CASE
                WHEN (publ_amnt = 'other public amenity') THEN other_publ
                ELSE publ_amnt
            END
        )
    END,
    CASE -- generator
        WHEN (generator = 'solar') THEN 'solar'
        WHEN (generator = 'yes, generator in use') THEN 'diesel'
        ELSE generator
    END,
    ST_Transform(geom,3857)
FROM import.offgrid_survey_small_generators_benue_wo_2
WHERE generator != 'no generator';

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_offgrid_survey_small_generators','cluster_offgrid_survey_processing_small_generators_benue.sql','Insert data');

-- insert data from import for survey_small_geneators Benue 3
INSERT INTO se4all.cluster_offgrid_survey_small_generators (
    cluster_offgrid_id,
    wo_number,
    settlement_wo_id,
    survey_date,
    state_name,
    -- lga_name,
    -- community_name,
    business_type,
    business_description,
    generator, -- solar or diesel
    geom
)
SELECT 
    clustr_id::INTEGER, -- cluster_offgrid_id
    wo_check::INTEGER, -- wo_number
    settlement::INTEGER, -- settlement_wo_id
    TO_DATE(today::varchar, 'YYYY-MM-DD'), -- survey_date
    INITCAP(state_chec), -- state_name
    -- INITCAP(selectlga), -- lga_name
    -- INITCAP(communityn), -- community_name
    fac_type, -- business_type
    CASE  -- business_description
        WHEN(fac_type = 'productive_user/production') THEN (
            SELECT
            CASE
                WHEN (productive = 'other type of production') THEN other_prdt
                ELSE productive
            END
        )
        WHEN(fac_type = 'commercial/shop') THEN (
            SELECT
            CASE
                WHEN (productive = 'other type of shops /commercial') THEN other_com
                ELSE com_type
            END
        )
        WHEN(fac_type = 'craft') THEN (
            SELECT
            CASE
                WHEN (craft = 'other craft(pls describe)') THEN other_prdt
                ELSE craft
            END
        )
        WHEN(fac_type = 'education') THEN (
            SELECT
            CASE
                WHEN (education = 'other type of education') THEN other_educ
                ELSE education
            END
        )
        WHEN(fac_type = 'health') THEN (
            SELECT
            CASE
                WHEN (health = 'other type of health') THEN other_hlth
                ELSE health
            END
        )
        WHEN(fac_type = 'public_amenity') THEN (
            SELECT
            CASE
                WHEN (publ_amnt = 'other public amenity') THEN other_publ
                ELSE publ_amnt
            END
        )
    END,
    CASE -- generator
        WHEN (generator = 'solar') THEN 'solar'
        WHEN (generator = 'yes, generator in use') THEN 'diesel'
        ELSE generator
    END,
    ST_Transform(geom,3857)
FROM import.offgrid_survey_small_generators_benue_wo_3
WHERE generator != 'no generator';

-- database log (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','cluster_offgrid_survey_small_generators','cluster_offgrid_survey_processing_small_generators_benue.sql','Insert data');
