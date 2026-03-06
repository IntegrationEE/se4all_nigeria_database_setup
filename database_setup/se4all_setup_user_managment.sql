/*
Database user managment
Create user groups, admins and users

- Groups
- Users
- Admins

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"

 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/database_setup/se4all_setup_user_managment.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- Groups
CREATE USER grp_read WITH NOLOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT NOREPLICATION;

CREATE USER grp_geonode WITH NOLOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION;
    GRANT grp_read TO grp_geonode;

CREATE USER grp_user WITH NOLOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT NOREPLICATION; 
    GRANT grp_read TO grp_user;
    
CREATE USER grp_admin WITH NOLOGIN SUPERUSER NOCREATEDB CREATEROLE NOREPLICATION;
    GRANT grp_user TO grp_admin;

-- Admin
CREATE ROLE admin_user_default LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB CREATEROLE REPLICATION;
    GRANT grp_user TO admin_user_default; 
    GRANT grp_admin TO admin_user_default;      

-- User
CREATE ROLE user_default LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
    GRANT grp_user TO user_default;          

-- Tests
CREATE ROLE test_user LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
    GRANT grp_user TO test_user;         
CREATE ROLE test_read LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
    GRANT grp_read TO test_read;           
CREATE ROLE test_geonode LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
    GRANT grp_geonode TO test_geonode;  
