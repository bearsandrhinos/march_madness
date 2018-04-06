explore: min_location {

}

view: min_location {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
  city_locations.city  AS city,
  city_locations.state  AS state,
  min(city_locations.latitude)  AS latitude,
  min(city_locations.longitude)  AS longitude

      FROM march_madness.city_locations  AS city_locations
      GROUP BY 1,2
      ;;
  }


dimension: city {
  type: string
  sql: ${TABLE}.city ;;
}

dimension: state {
  type: string
  sql: ${TABLE}.state ;;
}

dimension: latitude {
  type: number
  sql: ${TABLE}.latitude ;;
}

dimension: longitude {
  type: number
  sql: ${TABLE}.longitude ;;
}

dimension: location {
  type: location
  sql_latitude: ${latitude} ;;
  sql_longitude: ${longitude} ;;
}


#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }

}
