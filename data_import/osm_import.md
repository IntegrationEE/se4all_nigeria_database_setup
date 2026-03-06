# Import of OSM data to postgres
This file gives instruction (or information on where to find further instruction) on how to import OSM data - instructions differ depending on method / OS.

Import should be made for the whole of Nigeria. Download the .osm.pbf file from Geofabrik download server, [here](http://download.geofabrik.de/africa.html). 

## Using osm2pgsql on windows, localhost postgres server
For first time set-up of osm2pgsql,  instructions on learnosm.org are used: [https://learnosm.org/en/osm-data/osm2pgsql/](https://learnosm.org/en/osm-data/osm2pgsql/).
* Download of windows binary file from here: [https://lonvia.dev.openstreetmap.org/osm2pgsql-winbuild/releases/](https://lonvia.dev.openstreetmap.org/osm2pgsql-winbuild/releases/). The following version was used: "osm2pgsql-1.2.0-x64.zip". Earlier versions may face issues when running in Slim mode.
* For entire Nigeria, the following worked - run the following in cmd (check below for meaning of flags):
    > osm2pgsql --create --slim --hstore-all --number-processes 2 --cache 1000 -H localhost -P 5432 -d se4all -U postgres -W -p osm_nga -S C:\temp\default.style C:\temp\nigeria-191201.osm.pbf

Worked with the following system specifications, taking 18 minutes:

| System specification  | Value                |
| --------------------- | -------------------- |
| Processor             | Intel i5-72000U CPU  |
| RAM                   | 8 GB                 |
| osm2pgsql version     | 1.2.0-x64            | 

* You might reach a problem with the -W flag, check this forum for information on how to resolve it: [https://forum.openstreetmap.org/viewtopic.php?id=22931](https://forum.openstreetmap.org/viewtopic.php?id=22931). 
    * Hint: update of pg_hba.conf file with "trust" in "method": [https://www.postgresql.org/docs/9.1/auth-pg-hba-conf.html](https://www.postgresql.org/docs/9.1/auth-pg-hba-conf.html)
