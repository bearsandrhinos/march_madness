view: ncaa_tourney_compact_results {
  sql_table_name: march_madness.ncaa_tourney_compact_results ;;

  dimension: day_num {
    description: "This is the actual day number that the game occurred on"
    type: number
    sql: ${TABLE}.DayNum ;;
  }

  dimension: lscore {
    description: "The amount of points the losing team scored"
    type: number
    sql: ${TABLE}.LScore ;;
  }

  dimension: lteam_id {
    description: "The team id of the losing team"
    type: number
    sql: ${TABLE}.LTeamID ;;
  }

  dimension: num_ot {
    description: "The amount of overtime periods in the game"
    type: number
    sql: ${TABLE}.NumOT ;;
  }

  dimension: season {
    description: "The year that the tournament took place"
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: wloc {
    description: "H if the winning team was considered the home team and A if they were considered the away team"
    type: yesno
    sql: ${TABLE}.WLoc ;;
  }

  dimension: wscore {
    description: "The amount of points that the winning team scored"
    type: number
    sql: ${TABLE}.WScore ;;
  }

  dimension: wteam_id {
    description: "The team id of the winning team"
    type: number
    sql: ${TABLE}.WTeamID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
