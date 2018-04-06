view: teams {
  sql_table_name: march_madness.teams ;;

  dimension: team_id {
    description: "4 digit team id to uniquely differentiate each team in the NCAA"
    primary_key: yes
    type: number
    sql: ${TABLE}.TeamID ;;
  }

 # dimension: opp_team_id {
#    type: number
#    sql: ${TABLE}.TeamID ;;
 # }

  #dimension: opp_team_name {
   # type: string
    #sql: ${TABLE}.TeamName ;;
#  }

  dimension: first_d1_season {
    description: "The first year the corresponding team was in D1 basketball"
    type: number
    sql: ${TABLE}.FirstD1Season ;;
  }

  dimension: last_d1_season {
    description: "The last year the corresponding team was in D1 basketball"
    type: number
    sql: ${TABLE}.LastD1Season ;;
  }

  dimension: team_name {
    description: "This is a compact spelling of the college team"
    type: string
    sql: ${TABLE}.TeamName ;;
    link: {
      label: "Google"
      url: "http://www.google.com/search?q={{ value }} college basketball"
      icon_url: "http://google.com/favicon.ico"
    }
  }

  dimension: team_image {
    sql: ${team_name} ;;
    html: <img src="https://b.fssta.com/uploads/content/dam/fsdigital/fscom/global/dev/static_resources/cbk/teams/retina/606.vresize.80.80.medium.2.png"  />
      ;; }

  measure: count {
    type: count
    drill_fields: [team_id, team_name]
  }
}
