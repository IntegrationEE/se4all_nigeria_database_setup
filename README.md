# ⚡SE4ALL Nigeria Database set-up

This codebase provide SQL on initiation (set-up) of the SE4ALL database. The database set-up scripts were written between 2019 - 2023 and so may contain some legacy / age related issues. 

## 👥 Code contributors
- https://github.com/yelsre
- https://github.com/Omowonuola-Akintola
- https://github.com/Ludee

## 🧑‍💼 Organisations
- https://github.com/IntegrationEE
- https://github.com/rl-institut

## ⚖️ Licences

- __copyright__   = "© Integration Environment & Energy © Reiner Lemoine Institut"
- __license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
- __url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"


## 📂 `database_setup` folder

This directory contains the core scripts used to initialise a PostgreSQL
database for the SE4ALL Nigeria project. It doesn't load actual data –
instead it creates the skeleton objects and roles that downstream SQL and
import processes rely on. Key files include:

* `se4all_setup_extension.sql` – enables required PostgreSQL extensions
  (`postgis` and `hstore`).
* `se4all_setup_schema.sql` – creates the main schemas (`se4all`,
  `import`, `geonode`) with appropriate comments, ownerships and default
  privileges for three role groups (`grp_admin`, `grp_user`, `grp_read`).
* `se4all_setup_user_managment.sql` – defines role groups and a handful of
  initial login roles used for administration, testing and the Geonode
  service.
* `se4all_setup_function_databaselog.sql` – defines a simple scenario list
  table, a database log table and a helper function used by other scripts
  for versioning and auditing.
* `se4all_user_management_copyright.txt` – licensing/copyright information
  for the user management scripts.

The accompanying `graphics/` folder contains GraphML diagrams of the
database design and access workflows.

These scripts are intended to be run in the order above when provisioning a
fresh database, and they form the foundation for the subsequent `table_setup`,
`view_setup`, `data_import` and `data_processing` scripts in the repository.

## 📂 `data_import` folder

Import helpers and documentation live here. The SQL pipelines are separated
into two stages: raw ingestion (usually produced by `shp2pgsql` or
`osm2pgsql`) and a matching **post‑processing** script which:

1. Attaches rich JSON metadata comments to the imported table,
2. Creates spatial indexes, grants ownership/privileges and
3. Writes an entry to the project log (via `database_log` function).

Each dataset has an accompanying Markdown file describing where to obtain the
source (e.g. Nigerian administrative boundaries, cluster data, OSM extracts)
and giving example commands to load the shapefiles or OSM PBF. The folder also
includes a small Python helper (`distribution_line_import.py`) that walks a
directory of shapefiles and pipes them through `shp2pgsql` into the
`import` schema.

The specific files are:

* `boundary_adm1_import.md` / `_postprocessing.sql` – administrative boundary
  level‑1 import and metadata.
* `cluster_all_import.md` / `_postprocessing.sql` – national cluster dataset.
* `distribution_line_import.py` / `_postprocessing.sql` – power distribution
  line shapefiles and associated detailed metadata templates.
* `osm_import.md` / `_postprocessing.sql` – instructions and schema for loading
  OSM data for Nigeria (using `osm2pgsql`).

This directory is the first stop for anyone bringing raw spatial data into the
SE4ALL database; after running the outlined steps the cleaned tables are ready
for further processing using the scripts in `data_processing`.

## 📂 `table_setup` folder

Once raw data has been imported into the `import` schema, the SQL files in this
folder create the permanent tables in the `se4all` schema. Each script
usually:

1. Drops any existing table and recreates it with the desired columns and
   geometry types,
2. Adds a comprehensive JSON metadata comment (often copied from the
   corresponding post‑processing file),
3. Verifies the comment, builds a spatial index, and sets ownership to
   `grp_admin`, and
4. Logs the creation via the `database_log` helper.

The list of tables corresponds to the datasets handled by the project and
includes administrative boundaries, cluster data (including an off‑grid survey
version and a small‑generator subset), distribution lines (for SE4ALL, KEDCO,
Kaduna Electric), OSM building footprints, supply generator locations, and
supply quality survey results.

These table definitions are the structural backbone used by the application's
views and downstream processing; they are normally executed immediately after
running the `data_import`/post‑processing scripts to move data from `import` to
`se4all`.

## 📂 `mview_setup` folder

This directory contains scripts that create **materialized views** within the
`se4all` schema. The views are typically built on top of the base tables and
pre‑compute common spatial transformations or joins to speed up analysis:

* buffered geometries (e.g. `boundary_adm1_buffer_mv`,
  `distribution_line_all_buffer_mv`)
* filtered subsets of the cluster_offgrid table by supply group
  (`ng018`, `ng020`, etc.)
* joins between datasets, such as clusters / adm1 boundaries,
  distribution lines with buffers, or OSM buildings intersecting other
  features

Each file follows a pattern: drop any existing materialized view, create the
new view with the desired SQL, add a spatial index, and log the creation via
`database_log`. The materialized views are expected to be refreshed when the
underlying data changes and are consumed by the models, exports and any GIS
applications that require quick spatial queries.

This folder sits logically after `table_setup` because the views depend on the
final table structures. They are not essential for importing data but are
useful for performance and for delivering derived datasets in `view_setup`.

## 📂 `view_setup` folder

The smallest directory in the project defines regular (non‑materialized)
views that present **per‑region slices** of the cluster datasets. Two scripts
are included:

* `view_cluster_all_adm1_v.sql` – creates a view for each administrative unit
  (`NG001`, `NG002`, …) by joining `cluster_all` to the pre‑computed
  `join_cluster_all_adm1_mv` materialized view and attaching the state
  code/name. Clusters with negligible area are filtered out.

* `view_cluster_offgrid_adm1_v.sql` – identical logic but for the
  off‑grid cluster table (`cluster_offgrid`).

Because the scripts simply iterate through all `adm1_pcode` values, the
resulting views are convenient entry points for queries scoped to a single
state without needing `WHERE` filters. They depend on the materialized views
created earlier but do not store data themselves; PostgreSQL resolves them at
query time.

## 📂 `data_processing` folder

This folder contains the **transformation and loading logic** that moves
cleaned data from the `import` schema into the final `se4all` tables and
prepares derived datasets. The scripts can be run after the corresponding
`data_import` and `table_setup` stages and usually perform tasks such as:

* Inserting rows from an `import` table, applying geometry transforms
  (`ST_Transform`), filtering by area, and calculating additional attributes
  (e.g. `area_km2`).
* Populating the administrative boundary, cluster, off‑grid cluster, and
  distribution line tables.
* Generating materialized views and joins used elsewhere (see
  `cluster_all_distribution_line_all_mv_processing.sql`,
  `cluster_offgrid_distribution_line_all_mv_processing.sql`).
* Handling the large collection of **off‑grid survey uploads**, with a
  separate script for each state (e.g. `cluster_offgrid_survey_processing_abia.sql`,
  `..._akwa_ibom.sql`, etc.) as well as versions restricted to small
  generators. These scripts delete existing state records and insert new
  rows, normalising and recoding dozens of columns from the raw upload.

Data processing scripts are the final step before analysis and are often
re‑run when new imports arrive or survey data is updated. They are highly
stateful and may depend on preceding materialized views or tables created in
other folders.


