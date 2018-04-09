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
    link: {
      label: "Team Dashboard"
      url: "/dashboards/97?Team%20Name={{value}}"
      icon_url: "{{ team_logo._value}}"
    }
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
