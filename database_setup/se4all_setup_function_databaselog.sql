/*
Database Log Function (Multiproject version)

Function to add an entry to the Database Log table:
se4all_setup_function_databaselog.sql

Inputs:
    project,version,io,schema_name,table_name,script_name,comment

Outputs:
    id          SERIAL,
    project     text,
    version     text,
    io          text,
    schema_name text,
    table_name  text,
    script_name text,
    entries     integer,
    "comment"   text,
    user_name   text,
    "timestamp" timestamp,
    meta_data   text

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "Creative Commons Zero v1.0 Universal (CC0-1.0)"
__url__         = "https://creativecommons.org/publicdomain/zero/1.0/"
__author__      = "Ludwig Hülk"
*/


-- Scenario list
DROP TABLE IF EXISTS    se4all.scenario_list CASCADE;
CREATE TABLE            se4all.scenario_list (
    id              serial,
    model           text,
    version         text,
    version_name    text,
    "release"       boolean,
    "comment"       text,
    "timestamp"     timestamp,
    CONSTRAINT scenario_list_pkey PRIMARY KEY (version));

-- Access rights
ALTER TABLE se4all.scenario_list OWNER TO grp_admin;
GRANT INSERT ON TABLE se4all.scenario_list TO grp_user;
GRANT SELECT ON TABLE se4all.scenario_list TO grp_read;

-- Metadata
COMMENT ON TABLE se4all.scenario_list IS '{
    "title": "Scenario List",
    "description": "Version info",
    "language": [ "eng", "ger" ],
    "sources": [
        {"name": "eGo DataProcessing", "description": "Code", "url": "https://github.com/openego/data_processing", "license": "AGPL-3.0-or-later", "copyright": "eGo DataProcessing © Flensburg University of Applied Sciences, Centre for Sustainable Energy Systems © Europa-Universität Flensburg, Centre for Sustainable Energy Systems © Reiner Lemoine Institut © DLR Institute for Networked Energy Systems"},
        {"name": "eGo DataProcessing", "description": "Documentation", "url": "http://data-processing.readthedocs.io/en/latest/", "license": "CC-BY-4.0", "copyright": "eGo DataProcessing Documentation © Flensburg University of Applied Sciences, Centre for Sustainable Energy Systems © Europa-Universität Flensburg, Centre for Sustainable Energy Systems © Reiner Lemoine Institut © DLR Institute for Networked Energy Systems"}],
    "spatial": 
        {"location": "none",
        "extent": "none",
        "resolution": "none"},
    "temporal": 
        {"reference_date": "none",
        "start": "none",
        "end": "none",
        "resolution": "none"},
    "license": 
        {"id": "CC0-1.0",
        "name": "Creative Commons Zero v1.0 Universal",
        "version": "1.0",
        "url": "https://creativecommons.org/publicdomain/zero/1.0/legalcode",
        "instruction": "You can: Commercial Use, Private Use, Modify, Distribute; You cannot: Use Trademark, Hold Liable, Use Patent Claims; You must: none!",
        "copyright": "© Reiner Lemoine Institut"},
    "contributors": [
        {"name": "Ludwig Hülk", "email": "none", "date": "2016-10-01", "comment": "Create table" },
        {"name": "Ludwig Hülk", "email": "none", "date": "2016-11-16", "comment": "Add metadata" },
        {"name": "Ludwig Hülk", "email": "none", "date": "2017-03-21", "comment": "Update metadata to 1.1" },
        {"name": "Ludwig Hülk", "email": "none", "date": "2017-04-06", "comment": "Update metadata to 1.2" },
        {"name": "Ludwig Hülk", "email": "none", "date": "2017-06-19", "comment": "Update metadata to 1.3" },
        {"name": "Ludwig Hülk", "email": "none", "date": "2018-02-21", "comment": "Update license to CC0" } ],
    "resources": [
        {"name": "se4all.scenario_list",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "unique identifier", "unit": "none" },
            {"name": "model", "description": "model name", "unit": "none" },
            {"name": "version", "description": "scenario version number", "unit": "none" },
            {"name": "version_name", "description": "version name", "unit": "none" },
            {"name": "release", "description": "external release", "unit": "none" },
            {"name": "comment", "description": "additional information and comments", "unit": "none" },
            {"name": "timestamp", "description": "timestamp (Berlin)", "unit": "none" } ] } ],
    "metadata_version": "1.3"}';

-- Scenarios
INSERT INTO se4all.scenario_list (model,version,version_name,release,comment,timestamp) VALUES
    ('NESP2', 'v0', 'Database Setup', 'FALSE', 'Setup database and scenario log', '2019-09-11'),
    ('NESP2', 'v1', 'Database Tests', 'FALSE', 'Data setup and tests', '2019-09-11'),
    ('NESP2', 'v2', 'Database Deployment', 'TRUE', 'Data publication', '2019-09-11');


-- Database Log
DROP TABLE IF EXISTS    se4all.database_log CASCADE;
CREATE TABLE            se4all.database_log (
    id          SERIAL,
    project     text,
    version     text,
    io          text,
    schema_name text,
    table_name  text,
    script_name text,
    entries     integer,
    comment     text,
    user_name   text,
    "timestamp" timestamp,
    meta_data   text,
    CONSTRAINT database_log_pkey PRIMARY KEY (id));

-- Foreign Key to Scenario List
ALTER TABLE se4all.database_log
    ADD CONSTRAINT database_log_fkey FOREIGN KEY (version) 
        REFERENCES se4all.scenario_list(version) 
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Access rights
ALTER TABLE se4all.database_log OWNER TO grp_admin;
GRANT INSERT ON TABLE se4all.database_log TO grp_user;
GRANT SELECT ON TABLE se4all.database_log TO grp_read;

-- Metadata
COMMENT ON TABLE se4all.database_log IS '{
    "title": "Database Log",
    "description": "Versioning and table info",
    "language": [ "eng" ],
    "sources": [
        {"name": "eGo DataProcessing", "description": "Code", "url": "https://github.com/openego/data_processing", "license": "AGPL-3.0-or-later", "copyright": "eGo DataProcessing © Flensburg University of Applied Sciences, Centre for Sustainable Energy Systems © Europa-Universität Flensburg, Centre for Sustainable Energy Systems © Reiner Lemoine Institut © DLR Institute for Networked Energy Systems"},
        {"name": "eGo DataProcessing", "description": "Documentation", "url": "http://data-processing.readthedocs.io/en/latest/", "license": "CC-BY-4.0", "copyright": "eGo DataProcessing Documentation © Flensburg University of Applied Sciences, Centre for Sustainable Energy Systems © Europa-Universität Flensburg, Centre for Sustainable Energy Systems © Reiner Lemoine Institut © DLR Institute for Networked Energy Systems"}],
    "spatial": 
        {"location": "none",
        "extent": "none",
        "resolution": "none"},
    "temporal": 
        {"reference_date": "none",
        "start": "none",
        "end": "none",
        "resolution": "none"},
    "license": 
        {"id": "CC0-1.0",
        "name": "Creative Commons Zero v1.0 Universal",
        "version": "1.0",
        "url": "https://creativecommons.org/publicdomain/zero/1.0/legalcode",
        "instruction": "You can: Commercial Use, Private Use, Modify, Distribute; You cannot: Use Trademark, Hold Liable, Use Patent Claims; You must: none!",
        "copyright": "© Reiner Lemoine Institut"},
    "contributors": [
        {"name": "Ludwig Hülk", "email": "none", "date": "2016-10-01", "comment": "Create table" },
        {"name": "Ludwig Hülk", "email": "none", "date": "2016-10-12", "comment": "Add user_name" },
        {"name": "Ludwig Hülk", "email": "none", "date": "2016-11-16", "comment": "Add io" },
        {"name": "Ludwig Hülk", "email": "none", "date": "2016-11-16", "comment": "Add metadata" },
        {"name": "Ludwig Hülk", "email": "none", "date": "2017-01-15", "comment": "Update metadata"},
        {"name": "Ludwig Hülk", "email": "none", "date": "2017-03-21", "comment": "Update metadata to 1.1"},
        {"name": "Ludwig Hülk", "email": "none", "date": "2017-04-06", "comment": "Update metadata to 1.2"},
        {"name": "Ludwig Hülk", "email": "none", "date": "2017-06-19", "comment": "Update metadata to 1.3"},
        {"name": "Ludwig Hülk", "email": "none", "date": "2018-02-21", "comment": "Update license to CC0" } ],
    "resources": [
        {"name": "se4all.database_log",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none" },
            {"name": "project", "description": "Project name", "unit": "none" },
            {"name": "version", "description": "Scenario version", "unit": "none" },
            {"name": "io", "description": "Input or output", "unit": "none" },
            {"name": "schema_name", "description": "Schema name", "unit": "none" },
            {"name": "table_name", "description": "Table name", "unit": "none" },
            {"name": "script_name", "description": "Script name", "unit": "none" },
            {"name": "entries", "description": "Number of rows", "unit": "none" },
            {"name": "comment", "description": "Current status and comments", "unit": "none" },
            {"name": "user_name", "description": "Author (session user)", "unit": "none" },
            {"name": "timestamp", "description": "Timestamp without time zone", "unit": "YYYY-MM-DD HH:MM:SS" },
            {"name": "meta_data", "description": "Copy of the input metadata", "unit": "none" } ] } ],
    "metadata_version": "1.3"}';


-- Database Log function
DROP FUNCTION IF EXISTS     database_log(text,text,text,text,text,text,text);
CREATE OR REPLACE FUNCTION  database_log(text,text,text,text,text,text,text)
    RETURNS text AS 
    $$
    DECLARE
        _project        ALIAS FOR $1;
        _version        ALIAS FOR $2;
        _io             ALIAS FOR $3;
        _schema_name    ALIAS FOR $4;
        _table_name     ALIAS FOR $5;
        _script_name    ALIAS FOR $6;
        _comment        ALIAS FOR $7;
    BEGIN
        EXECUTE 'INSERT INTO se4all.database_log ' ||
            '(project,version,io,schema_name,table_name,script_name,entries,comment,user_name,timestamp,meta_data)
            SELECT ' || quote_literal(_project) || ',' || 
                quote_literal(_version) || ',' || 
                quote_literal(_io) || ',' ||
                quote_literal(_schema_name) || ',' ||
                quote_literal(_table_name) || ',' ||
                quote_literal(_script_name) || ',' ||
                'COUNT(*),' ||
                quote_literal(_comment) || ',' || 
                'session_user,' ||
                E'NOW() AT TIME ZONE \'Europe/Berlin\' ,' ||
                E'obj_description(\'' || _schema_name || '.' || _table_name  || E'\' ::regclass) ::json ' || 
            'FROM ' || _schema_name || '.' || _table_name || ';' ;
        RETURN 'inserted';
    END;
    $$ LANGUAGE plpgsql;

-- Access rights
ALTER FUNCTION database_log(text,text,text,text,text,text,text) OWNER TO grp_user;
GRANT EXECUTE ON FUNCTION database_log(text,text,text,text,text,text,text) TO grp_user;

-- Database Log entry (project,version,io,schema_name,table_name,script_name,comment)
SELECT database_log('se4all','v0','setup','se4all','database_log','se4all_function_databaselog.sql','Function test');

-- Select latest entry
SELECT * FROM se4all.database_log ORDER BY id DESC LIMIT 1;

