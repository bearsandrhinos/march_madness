view: game_cities {
  sql_table_name: march_madness.game_cities ;;

  dimension: city_id {
    description: "Four digit code to idenitify city"
    type: number
    sql: ${TABLE}.CityID ;;
  }

  dimension: crtype {
    description: "Regular Season/NCAA Tournament/Secondary Tournament"
    type: string
    sql: ${TABLE}.CRType ;;
  }

  dimension: day_num {
    description: "The day number the game was played"
    type: number
    sql: ${TABLE}.DayNum ;;
  }

  dimension: lteam_id {
    description: "The team id for losing team"
    type: number
    sql: ${TABLE}.LTeamID ;;
  }

  dimension: season {
    description: "The year the tournament was in"
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: wteam_id {
    description: "The team id for the winning team"
    type: number
    sql: ${TABLE}.WTeamID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
