# Import of cluster_all data into postgres
This file gives instruction (or information on where to find further instruction) on how to import the cluster_all dataset - instructions differ depending on method / OS.

Import should be made for the entire cluster dataset. The dataset can be found on the internal Nextcloud with the following path: Nextcloud\NESP_II\04_Daten\DB-Import\ng_clst_mit_population

## Using shp2pgsql on windows, localhost postgres server
For use of shp2pgsql,  the following cheat sheet is useful: [http://bostongis.com/pgsql2shp_shp2pgsql_quickguide.bqg](http://bostongis.com/pgsql2shp_shp2pgsql_quickguide.bqg). Then run the following two code snippets in cmd, with your shape file in the directory:

'''
shp2pgsql -s 4326 ng_clst_mit_population.shp import.cluster_all_import > cluster_all_import.sql
'''
Then...

'''
psql -d se4all_nigeria -U your_user_name -f cluster_all_import.sql
'''
You will see several "INSERT" statemenets being run. This takes a while, go make a drink.

Next, run the postprocessing script (cluster_all_import_postprocessing.sql).