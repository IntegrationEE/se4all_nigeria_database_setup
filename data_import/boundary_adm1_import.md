# Import of cluster_all data into postgres
This file gives instruction (or information on where to find further instruction) on how to import the cluster_all dataset - instructions differ depending on method / OS.

Import should be made for entire administrative boundary. The dataset can be found on the internal Nextcloud with the following path: Nextcloud\NESP_II\04_Daten\DB-Import\nga_adm_osgof_20190417_SHP

## Using shp2pgsql on windows, localhost postgres server
For use of shp2pgsql,  the following cheat sheet is useful: [http://bostongis.com/pgsql2shp_shp2pgsql_quickguide.b<qg](http://bostongis.com/pgsql2shp_shp2pgsql_quickguide.bqg). Then cmd into the directory and run  the following code snippets:

'''
shp2pgsql -s 4326 nga_admbnda_adm1_osgof_20190417.shp import.boundary_adm1_import > boundary_adm1_import.sql
'''
Then...

'''
psql -d se4all_nigeria -U your_user_name -f boundary_adm1_import.sql
'''
You will see several "INSERT" statemenets being run. 

Next, run the postprocessing script (boundary_adm1_import_postprocessing.sql).