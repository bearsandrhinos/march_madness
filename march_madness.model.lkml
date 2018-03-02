connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: march_madness_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: march_madness_default_datagroup

explore: cities {
  view_name: cities
  from: cities
  label: "Game Location"

  fields: [ALL_FIELDS*]
}
