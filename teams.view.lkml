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
  }

  measure: count {
    type: count
    drill_fields: [team_id, team_name]
  }
}
