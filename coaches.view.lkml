view: coaches {
  sql_table_name: march_madness.coaches ;;

  dimension: coach_name {
    description: "The coach's name"
    type: string
    sql: ${TABLE}.CoachName ;;
  }

  dimension: last_name {
    type: string
    sql: replace(REGEXP_EXTRACT(${coach_name}, r'(.*)_'), "_", " ") ;;
  }

  dimension: first_name {
    type: string
    sql: case when REGEXP_EXTRACT(REGEXP_EXTRACT(${coach_name}, r'_(.*)'), r'_(.*)') is null
                      then REGEXP_EXTRACT(${coach_name}, r'_(.*)')
                      else REGEXP_EXTRACT(REGEXP_EXTRACT(${coach_name}, r'_(.*)'), r'_(.*)') end ;;
  }

  dimension: full_name {
    type: string
    sql: upper(concat(${first_name}, ' ', ${last_name})) ;;
    }

  dimension: first_day_num {
    description: "Day number of the season that was the coach's first day"
    type: number
    sql: ${TABLE}.FirstDayNum ;;
  }

#might be used if a coach is fired
  dimension: last_day_num {
    description: "Day number of the season that was the coach's last day"
    type: number
    sql: ${TABLE}.LastDayNum ;;
  }

  dimension: season {
    description: "The year the tournament was played in"
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: team_id {
    description: "Team id of the team which the coach coached"
    type: number
    sql: ${TABLE}.TeamID ;;
  }

  measure: count {
    type: count
    drill_fields: [coach_name]
  }
}
