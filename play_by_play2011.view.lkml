view: play_by_play2011 {
  sql_table_name: march_madness.play_by_play2011 ;;

  dimension: day_num {
    description: "The day number that the game occurred"
    type: number
    sql: ${TABLE}.DayNum ;;
  }

#0-1200 seconds is the first half
#1201-2400 is the second half
#higher is due to overtime
#I want to try and make this into minutes and seconds
  dimension: elapsed_seconds {
    description: "This is the number of seconds into the game in which the event happened"
    type: number
    sql: ${TABLE}.ElapsedSeconds ;;
  }

  dimension: event_id {
    description: "This is the unique id for each event"
    type: number
    sql: ${TABLE}.EventID ;;
  }

  dimension: event_player_id {
    description: "This is the player id of the player who the event corresponds to"
    type: number
    sql: ${TABLE}.EventPlayerID ;;
  }

  dimension: event_team_id {
    description: "This is the team id of the team in which the event occurred"
    type: number
    sql: ${TABLE}.EventTeamID ;;
  }

  dimension: event_type {
    description: "This is the event type."
    type: string
    sql: ${TABLE}.EventType ;;
  }

  dimension: lpoints {
    description: "The amount of points for the losing team after event"
    type: number
    sql: ${TABLE}.LPoints ;;
  }

  dimension: lteam_id {
    description: "Losing team id"
    type: number
    sql: ${TABLE}.LTeamID ;;
  }

  dimension: season {
    description: "Year of the tournament"
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: wpoints {
    description: "The amount of points for the winning team after the event"
    type: number
    sql: ${TABLE}.WPoints ;;
  }

  dimension: wteam_id {
    description: "Winning team id"
    type: number
    sql: ${TABLE}.WTeamID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
