# -*- coding: utf-8 -*-
"""
se4all import distribution_line files
# create download folder
# define files for download
# download to folder and unzip
# load & import shapefiles
"""

__copyright__   = " © Reiner Lemoine Institut © Integration Environment & Energy"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://github.com/openego/data_processing/blob/master/LICENSE"
__author__      = "Ludee, yelsre"


import os, subprocess
import dateutil.parser as dparser


# create download folder
download_folder = r'C:\Users\your_user\Nextcloud\NESP_II\04_Daten\DB-Import\grid'
if not os.path.exists(download_folder):
    os.makedirs(download_folder)
    
# load shapefiles
full_dir = os.walk(download_folder) 
shapefile_list = []
for dirpaths, dirnames, files in full_dir:
    for file_ in files:
        if file_[-3:] == 'shp':
            # path
            shape_path = os.path.join(dirpaths, file_)
            # table
            table_name = os.path.join(file_)[:-4]
            entry = []
            entry.append(shape_path)
            entry.append(table_name)
            shapefile_list.append(entry)

# execute
for shape_path, table_name in shapefile_list:
    cmd = 'shp2pgsql -s 4326 "' + shape_path + '" import.' + table_name + ' | psql -d se4all_nigeria -U your_db_user > NUL'
    subprocess.check_call(cmd, shell=True)
