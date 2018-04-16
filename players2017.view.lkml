view: players2017 {
  sql_table_name: march_madness.players2017 ;;

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

  dimension: last_name {
    type: string
    sql: replace(REGEXP_EXTRACT(${player_name}, r'(.*)_'), "_", " ") ;;
  }

  dimension: first_name {
    type: string
    sql: case when REGEXP_EXTRACT(REGEXP_EXTRACT(${player_name}, r'_(.*)'), r'_(.*)') is null
                      then REGEXP_EXTRACT(${player_name}, r'_(.*)')
                      else REGEXP_EXTRACT(REGEXP_EXTRACT(${player_name}, r'_(.*)'), r'_(.*)') end ;;
  }

  dimension: full_name {
    type: string
    sql: concat(${first_name}, ' ', ${last_name}) ;;
    link: {
      label: "{{ value }} Season Dashboard"
      url: "/dashboards/105?Team={{event_team.team_name._value}}&Player={{value}}"
      icon_url: "{{ event_team.team_logo._value}}"
    }

  }

  parameter: player {
    type: string

  }

  dimension: player_highlight {
    type: string
    sql: {% parameter player %};;
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
