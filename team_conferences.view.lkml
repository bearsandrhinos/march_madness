view: team_conferences {
  sql_table_name: march_madness.team_conferences ;;

  dimension: conf_abbrev {
    description: "Abbreviation of the conference in which the team belongs to"
    type: string
    sql: ${TABLE}.ConfAbbrev ;;
  }

  dimension: season {
    description: "The year the tournament was played"
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: team_id {
    description: "The team id to correspond to their conference"
    type: number
    sql: ${TABLE}.TeamID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
