

include: "team_game_log.view"
view: donut_view {

  derived_table: {
    explore_source: team_game_log {
      column: three_point_field_goal_percentage {
        field: team_game_log.3_point_field_goal_percentage
      }
      column: team_id {}
      column: field_goal_percentage {}
      column: free_throw_percentage {}
      column: field_goal_attempts {}
      column: field_goal_makes {}
      column: free_throw_attempts {}
      column: free_throw_makes {}
      column: three_point_field_goal_attempts {
        field: team_game_log.3_point_field_goal_attempts
      }
      column: three_point_field_goal_makes {
        field: team_game_log.3_point_field_goal_makes
      }
#       filters: {
#         field: team_game_log.season
#         value: "2017"
#       }
#       filters: {
#         field: primary_rankings.system_name
#         value: "POM"
#       }
#       filters: {
#         field: opposing_rankings.system_name
#         value: "POM"
#       }
    }
  }
  dimension: three_point_field_goal_percentage {
    hidden: yes
    value_format_name: percent_1
    type: number

  }

  dimension: threePFGP {
    type: number
    value_format: "00\%"
    sql: cast((${three_point_field_goal_percentage}*100) as int64) ;;
  }
  dimension: team_id {
    type: number
    primary_key: yes
    description: "The individual team id"
  }
  dimension: field_goal_percentage {
    hidden: yes
    value_format_name: percent_1
    type: number
  }

  dimension: FGP {
    type: number
    value_format: "00\%"
    sql: cast((${field_goal_percentage}*100) as int64) ;;
  }
  dimension: free_throw_percentage {
    hidden: yes
    value_format_name: percent_1
    type: number
  }

  dimension: FTP {
    type: number
    value_format: "00\%"
    sql: cast((${free_throw_percentage}*100) as int64) ;;
  }
  dimension: field_goal_attempts {
    type: number
  }
  dimension: field_goal_makes {
    type: number
  }
  dimension: free_throw_attempts {
    type: number
  }
  dimension: free_throw_makes {
    type: number
  }
  dimension: three_point_field_goal_attempts {
    type: number
  }
  dimension: three_point_field_goal_makes {
    type: number
  }

  measure: FGA {
    type: sum_distinct
    sql: ${field_goal_attempts} ;;
  }

  measure: FGM {
    type: sum_distinct
    sql: ${field_goal_makes} ;;
  }

  measure: fgmiss {
    type: number
    sql: ${FGA} -${FGM} ;;
  }

  measure: FTA {
    type: sum_distinct
    sql: ${free_throw_attempts} ;;
  }

  measure: FTM {
    type: sum_distinct
    sql: ${free_throw_makes} ;;
  }

  measure: FTmiss {
    type: number
    sql: ${FTA} - ${FTM} ;;
  }

  measure: Three_PFGA {
    type: sum_distinct
    sql: ${three_point_field_goal_attempts} ;;
  }

  measure: Three_PFGM {
    type: sum_distinct
    sql: ${three_point_field_goal_makes} ;;
  }

  measure: Three_miss {
    type: number
    sql: ${Three_PFGA} - ${Three_PFGM} ;;
  }

}
