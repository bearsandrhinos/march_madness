view: teams1 {
  sql_table_name: march_madness.teams1 ;;

  dimension: first_d1_season {
    type: number
    sql: ${TABLE}.FirstD1Season ;;
  }

  dimension: last_d1_season {
    type: number
    sql: ${TABLE}.LastD1Season ;;
  }

  dimension: logo_url {
    type: string
    sql: ${TABLE}.Logo ;;
  }

  dimension: team_id {
    type: number
    sql: ${TABLE}.TeamID ;;
  }

  dimension: team_name {
    type: string
    sql: ${TABLE}.TeamName ;;
  }

  dimension: team_logo {
    sql: ${logo_url} ;;
    html: <img src="{{value}}"  /> ;;
  }

  measure: count {
    type: count
    drill_fields: [team_name]
  }
}
