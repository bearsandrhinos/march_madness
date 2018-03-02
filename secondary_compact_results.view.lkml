view: secondary_compact_results {
  sql_table_name: march_madness.secondary_compact_results ;;

  dimension: day_num {
    description: "The day number the game was played"
    type: number
    sql: ${TABLE}.DayNum ;;
  }

  dimension: lscore {
    description: "The amount of points the losing team scored"
    type: number
    sql: ${TABLE}.LScore ;;
  }

  dimension: lteam_id {
    description: "Losing team id"
    type: number
    sql: ${TABLE}.LTeamID ;;
  }

  dimension: num_ot {
    description: "Number of overtime periods in the game"
    type: number
    sql: ${TABLE}.NumOT ;;
  }

  dimension: season {
    description: "Year the tournament took place"
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: secondary_tourney {
    description: "The abbreviation for the tournament"
    type: string
    sql: ${TABLE}.SecondaryTourney ;;
  }

  dimension: wloc {
    description: "The winning team is H is they are home and A if away"
    type: string
    sql: ${TABLE}.WLoc ;;
  }

  dimension: wscore {
    description: "The amount of points the winning team scored"
    type: number
    sql: ${TABLE}.WScore ;;
  }

  dimension: wteam_id {
    description: "The winning team id"
    type: number
    sql: ${TABLE}.WTeamID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
