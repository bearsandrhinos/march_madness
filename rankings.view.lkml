view: rankings {
  sql_table_name: march_madness.rankings ;;

  dimension: ordinal_rank {
    description: "This is the overall ranking of the team in the underlying system"
    type: number
    sql: ${TABLE}.OrdinalRank ;;
    drill_fields: [primary_team.team_logo, primary_team.team_name]
  }

  dimension: ranking_day_num {
    description: "The ranking released on this day, so all results before this day account for the ranking"
    type: number
    sql: ${TABLE}.RankingDayNum ;;
  }

  dimension: season {
    description: "This is the year the tournament was played"
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: system_name {
    description: "This is the ranking system"
    type: string
    sql: ${TABLE}.SystemName ;;
  }

  dimension: team_id {
    description: "The team id for the ranked team"
    type: number
    sql: ${TABLE}.TeamID ;;
  }

  measure: count {
    type: count
    drill_fields: [system_name]
  }

  measure: ranking {
    type: min
    sql: ${ordinal_rank} ;;
  }
}
