view: secondary_teams {
  sql_table_name: march_madness.secondary_teams ;;

  dimension: season {
    description: "The year the tournament was played in"
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: secondary_tourney {
    description: "The abbreviation of what tournament it is"
    type: string
    sql: ${TABLE}.SecondaryTourney ;;
  }

  dimension: team_id {
    description: "The team id for the team that participated"
    type: number
    sql: ${TABLE}.TeamID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
