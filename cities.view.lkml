view: cities {
  sql_table_name: march_madness.cities ;;

  dimension: city_id {
    description: "Four digit code to uniquely identify the city"
    primary_key: yes
    type: number
    sql: ${TABLE}.CityID ;;
  }

  dimension: city {
    description: "Name of the city"
    type: string
    sql: ${TABLE}.City ;;
  }


  dimension: state {
    description: "State in which city is located"
    type: string
    sql: ${TABLE}.State ;;
    map_layer_name: us_states
  }

  dimension: state_map {
    description: "This is for the state where the team is from"
    type: string
    sql: case when ${state} in ("BA", "MX", "VI") then NULL ELSE ${state} end ;;
    map_layer_name: us_states
  }

  measure: count {
    type: count
    drill_fields: [city_id]
  }
}
