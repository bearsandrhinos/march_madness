view: reg_season_compact_results {
  sql_table_name: march_madness.reg_season_compact_results ;;

  dimension: day_num {
    description: "The actual day number of the game" #I will use this as the datediff to find the actual date
    type: number
    sql: ${TABLE}.DayNum ;;
  }

  dimension: lscore {
    description: "Points scored by the losing team"
    type: number
    sql: ${TABLE}.LScore ;;
  }

  dimension: lteam_id {
    description: "Team id of the losing team"
    type: number
    sql: ${TABLE}.LTeamID ;;
  }

  dimension: num_ot {
    description: "The number of overtime periods that happened in the game"
    type: number
    sql: ${TABLE}.NumOT ;;
  }

  dimension: season {
    description: "The year of the season in which the tournament occured"
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: wloc {
    description: "This identifies if the winning team was home or away"
    type: string
    sql: ${TABLE}.WLoc ;;
  }

  dimension: wscore {
    description: "The amount of points the winning team scored"
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
