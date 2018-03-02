view: conference_tourney_games {
  sql_table_name: march_madness.conference_tourney_games ;;

  dimension: conf_abbrev {
    description: "The abbreviation of the conference"
    type: string
    sql: ${TABLE}.ConfAbbrev ;;
  }

  dimension: day_num {
    description: "The day number the game was played"
    type: number
    sql: ${TABLE}.DayNum ;;
  }

  dimension: lteam_id {
    description: "The losing team id"
    type: number
    sql: ${TABLE}.LTeamID ;;
  }

  dimension: season {
    description: "The year the tournament was played in"
    type: number
    sql: ${TABLE}.Season ;;
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
