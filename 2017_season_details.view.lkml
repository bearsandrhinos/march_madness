explore: season_details_2017_1 {

}
###This view is just to get the donut multiples.  Maybe use for other things.

view: season_details_2017_1 {

# Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
      eventteamid  AS team_id,
      play_by_play2017.EventType  AS event_type,
      COUNT(*) AS event_count
        FROM march_madness.play_by_play2017  AS play_by_play2017
        GROUP BY 1,2;;
}

  dimension: team_id {
    type: number
    sql: ${TABLE}.team_id ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: event_count {
    type: number
    sql: ${TABLE}.event_count ;;
  }

  dimension: assist {
    description: "Assist"
    type: number
    sql: case when ${event_type} = "assist" then ${event_count} end ;;
  }

  dimension: block {
    type: number
    sql: case when ${event_type} = "block" then ${event_count} end ;;
  }

  dimension: steal {
    type: number
    sql: case when ${event_type} = "steal" then ${event_count} end ;;
  }

  dimension: turnover {
    type: number
    sql: case when ${event_type} = "turnover" ${event_count} end ;;
  }

  dimension: timeout {
    type: number
    sql: case when ${event_type} = "timeout" ${event_count} end ;;
  }

  dimension: foul_pers {
    label: "Personal Foul"
    type: number
    sql: case when ${event_type} = "foul_pers" ${event_count} end ;;
  }

  dimension: foul_tech {
    label: "Technical Foul"
    type: number
    sql: case when ${event_type} = "foul_tech" ${event_count} end ;;
  }

  dimension: reb_off {
    label: "Offensive Rebound"
    type: number
    sql: case when ${event_type} = "reb_off" ${event_count} end ;;
  }

  dimension: reb_def {
    label: "Defensive Rebound"
    type: number
    sql: case when ${event_type} = "reb_def" ${event_count} end ;;
  }

  dimension: reb_dead {
    label: "Dead ball rebound"
    type: number
    sql: case when ${event_type} = "reb_dead" ${event_count} end ;;
  }

  dimension: tot_reb {
    type: number
    sql: ${reb_off} + ${reb_def} + ${reb_dead} ;;
  }

  dimension: sub_in {
    label: "Subbed in"
    type: number
    sql: case when ${event_type} = "sub_in" ${event_count} end ;;
  }

  dimension: sub_out {
    label: "Subbed out"
    type: number
    sql: case when ${event_type} = "sub_out" ${event_count} end ;;
  }

  dimension: made1_free {
    label: "Made Free Throw"
    type: number
    sql: case when ${event_type} = "made1_free" ${event_count} end ;;
  }

  dimension: miss1_free {
    label: "Miss Free Throw"
    type: number
    sql: case when ${event_type} = "miss1_free" ${event_count} end ;;
  }

  dimension: free_attempt {
    type: number
    sql: ${made1_free} + ${miss1_free} ;;
  }

  dimension: FTP {
    type: number
    sql: ${made1_free}/nullif(${free_attempt}, 0) ;;
  }

  dimension: made2_dunk {
    label: "Made Dunk"
    type: number
    sql: case when ${event_type} = "made2_dunk" ${event_count} end ;;
  }

  dimension: miss2_dunk {
    label: "Missed Dunk"
    type: number
    sql: case when ${event_type} = "miss2_dunk" ${event_count} end ;;
  }

  dimension: miss2_tip {
    label: "Missed Tip"
    type: number
    sql: case when ${event_type} = "miss2_tip" ${event_count} end ;;
  }

  dimension: made2_tip {
    label: "Made Tip"
    type: number
    sql: case when ${event_type} = "made2_tip" ${event_count} end ;;
  }

  dimension: miss2_lay {
    label: "Missed Layup"
    type: number
    sql: case when ${event_type} = "miss2_lay" ${event_count} end ;;
  }

  dimension: made2_lay {
    label: "Made Layup"
    type: number
    sql: case when ${event_type} = "made2_lay" ${event_count} end ;;
  }

  dimension: miss2_jump {
    label: "Missed Jump Shot"
    type: number
    sql: case when ${event_type} = "miss2_jump" ${event_count} end ;;
  }

  dimension: made2_jump {
    label: "Made Jump"
    type: number
    sql: case when ${event_type} = "made2_jump" ${event_count} end ;;
  }



  measure: count {
    type: count
    drill_fields: []
  }

  measure: free_made {
    type: sum
    sql: ${made1_free} ;;
  }

  measure: free_miss {
    type: sum
    sql: ${miss1_free} ;;
  }
}
