view: conferences {
  sql_table_name: march_madness.conferences ;;

  dimension: string_field_0 {
    type: string
    sql: ${TABLE}.string_field_0 ;;
  }

  dimension: string_field_1 {
    type: string
    sql: ${TABLE}.string_field_1 ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
