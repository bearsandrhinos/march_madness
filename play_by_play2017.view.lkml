view: play_by_play2017 {
  sql_table_name: march_madness.play_by_play2017 ;;

  dimension: day_num {
    description: "The day number that the game occurred"
    type: number
    sql: ${TABLE}.DayNum ;;
  }

  dimension_group: game_date {
    type: time
    timeframes: [date, month, week, year]
    sql: cast(DATE_SUB(DATE "2017-04-03", INTERVAL (154-${day_num}) DAY) as TIMESTAMP) ;;
  }

  dimension: game_id {
    type: string
    sql: CONCAT(cast(${TABLE}.daynum as string), "Y", cast(${TABLE}.Season as string), "W", cast(${TABLE}.wteamid as string), "L", cast(${TABLE}.lteamid as string)) ;;
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
    primary_key: yes
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

  dimension: assist {
    description: "Assist"
    type: number
    sql: case when ${event_type} = "assist" then 1 else 0 end ;;
  }

  dimension: block {
    type: number
    sql: case when ${event_type} = "block" then 1 else 0 end ;;
  }

  dimension: steal {
    type: number
    sql: case when ${event_type} = "steal" then 1 else 0 end ;;
  }

  dimension: turnover {
    type: number
    sql: case when ${event_type} = "turnover" then 1 else 0 end ;;
  }

  dimension: timeout {
    type: number
    sql: case when ${event_type} = "timeout" then 1 else 0 end ;;
  }



  measure: count {
    type: count
    drill_fields: []
  }


  measure: assists {
    type: sum
    sql: ${assist} ;;
  }

  measure: event {
    type: sum
    sql: case when
            ${event_type} = '{% parameter event_to_count %}'
            then 1
            else 0
            end ;;
  }

  filter: event_to_count {
    type: string
    suggest_explore: play_by_play2017
    suggest_dimension: event_type
  }
}
