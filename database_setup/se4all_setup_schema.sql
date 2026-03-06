/*
Database schema
Create basic schema structure

- Groups
- Users
- Admins

__copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


 * This file is part of project se4all (https://github.com/yelsre/se4all_nigeria_database).
 * It's copyrighted by the contributors recorded in the version control history:
 * se4all_nigeria_database/database_setup/se4all_setup_schema.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/

CREATE SCHEMA se4all;
COMMENT ON SCHEMA se4all IS 'data used directly in the se4all platforms, relating to society locations and locations of energy infrastructure';
GRANT ALL ON SCHEMA se4all TO grp_user WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA se4all GRANT ALL ON TABLES TO grp_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA se4all GRANT ALL ON SEQUENCES TO grp_user;
GRANT USAGE ON SCHEMA se4all TO grp_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA se4all GRANT SELECT ON TABLES TO grp_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA se4all GRANT SELECT ON SEQUENCES TO grp_read;
ALTER SCHEMA se4all OWNER TO grp_admin;

CREATE SCHEMA import;
COMMENT ON SCHEMA import IS 'data for import into se4all schema, including data extracted from the import database';
GRANT ALL ON SCHEMA import TO grp_admin WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA import GRANT ALL ON TABLES TO grp_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA import GRANT ALL ON SEQUENCES TO grp_admin;
GRANT USAGE ON SCHEMA import TO grp_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA import GRANT SELECT ON TABLES TO grp_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA import GRANT SELECT ON SEQUENCES TO grp_read;
ALTER SCHEMA import OWNER TO grp_admin;

CREATE SCHEMA geonode;
COMMENT ON SCHEMA geonode IS 'data from the geonode database in its raw form for further processing';
GRANT ALL ON SCHEMA geonode TO grp_admin WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA geonode GRANT ALL ON TABLES TO grp_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA geonode GRANT ALL ON SEQUENCES TO grp_admin;
GRANT USAGE ON SCHEMA geonode TO grp_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA geonode GRANT SELECT ON TABLES TO grp_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA geonode GRANT SELECT ON SEQUENCES TO grp_read;
ALTER SCHEMA geonode OWNER TO grp_admin;
