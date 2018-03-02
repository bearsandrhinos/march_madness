view: players2015 {
  sql_table_name: march_madness.players2015 ;;

  dimension: player_id {
    description: "This is the unique identifier for the player"
    type: number
    sql: ${TABLE}.PlayerID ;;
  }

  #need to modify, move first name first and last name last and get the underscore out of there
  dimension: player_name {
    description: "Player name"
    type: string
    sql: ${TABLE}.PlayerName ;;
  }

  dimension: season {
    description: "Year the tournament is played in"
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: team_id {
    description: "Team id for the player's team"
    type: number
    sql: ${TABLE}.TeamID ;;
  }

  measure: count {
    type: count
    drill_fields: [player_name]
  }
}
