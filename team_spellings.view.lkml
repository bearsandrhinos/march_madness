view: team_spellings {
  sql_table_name: march_madness.team_spellings ;;

  dimension: team_id {
    description: "The id of the team"
    type: number
    sql: ${TABLE}.TeamID ;;
  }

  dimension: team_name_spelling {
    description: "Lower case form of the team name"
    type: string
    sql: ${TABLE}.TeamNameSpelling ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
