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
    drill_fields: [event_team.team_name, player_name.full_name, event_type]
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

  dimension: opposing_team_id {
    description: "The opponent team id"
    type: number
    sql: if(${event_team_id} = ${wteam_id}, ${lteam_id}, ${wteam_id});;
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

  dimension: foul_pers {
    label: "Personal Foul"
    type: number
    sql: case when ${event_type} = "foul_pers" then 1 else 0 end ;;
  }

  dimension: foul_tech {
    label: "Technical Foul"
    type: number
    sql: case when ${event_type} = "foul_tech" then 1 else 0 end ;;
  }

  dimension: reb_off {
    label: "Offensive Rebound"
    type: number
    sql: case when ${event_type} = "reb_off" then 1 else 0 end ;;
  }

  dimension: reb_def {
    label: "Defensive Rebound"
    type: number
    sql: case when ${event_type} = "reb_def" then 1 else 0 end ;;
  }

  dimension: reb_dead {
    label: "Dead ball rebound"
    type: number
    sql: case when ${event_type} = "reb_dead" then 1 else 0 end ;;
  }

  dimension: tot_reb {
    type: number
    sql: ${reb_off} + ${reb_def} + ${reb_dead} ;;
  }

  dimension: sub_in {
    label: "Subbed in"
    type: number
    sql: case when ${event_type} = "sub_in" then 1 else 0 end ;;
  }

  dimension: sub_out {
    label: "Subbed out"
    type: number
    sql: case when ${event_type} = "sub_out" then 1 else 0 end ;;
  }

  dimension: made1_free {
    label: "Made Free Throw"
    type: number
    sql: case when ${event_type} = "made1_free" then 1 else 0 end ;;
  }

  dimension: miss1_free {
    label: "Miss Free Throw"
    type: number
    sql: case when ${event_type} = "miss1_free" then 1 else 0 end ;;
  }

  dimension: made2_dunk {
    label: "Made Dunk"
    type: number
    sql: case when ${event_type} = "made2_dunk" then 1 else 0 end ;;
  }

  dimension: miss2_dunk {
    label: "Missed Dunk"
    type: number
    sql: case when ${event_type} = "miss2_dunk" then 1 else 0 end ;;
  }

  dimension: miss2_tip {
    label: "Missed Tip"
    type: number
    sql: case when ${event_type} = "miss2_tip" then 1 else 0 end ;;
  }

  dimension: made2_tip {
    label: "Made Tip"
    type: number
    sql: case when ${event_type} = "made2_tip" then 1 else 0 end ;;
  }

  dimension: miss2_lay {
    label: "Missed Layup"
    type: number
    sql: case when ${event_type} = "miss2_lay" then 1 else 0 end ;;
  }

  dimension: made2_lay {
    label: "Made Layup"
    type: number
    sql: case when ${event_type} = "made2_lay" then 1 else 0 end ;;
  }

  dimension: miss2_jump {
    label: "Missed Jump Shot"
    type: number
    sql: case when ${event_type} = "miss2_jump" then 1 else 0 end ;;
  }

  dimension: made2_jump {
    label: "Made Jump"
    type: number
    sql: case when ${event_type} = "made2_jump" then 1 else 0 end ;;
  }

  dimension: field_goal_makes {
    type: number
    sql: ${made2_dunk} + ${made2_jump} + ${made2_lay} + ${made2_tip} + ${made3_jump} ;;
  }

  dimension: assist_sec {
    type: number
    sql: case when ${assist} = 1 then ${elapsed_seconds} else 0 end ;;
  }

  dimension: field_goal_sec {
    type: number
    sql: case when ${field_goal_makes} = 1 then ${elapsed_seconds} else 0 end ;;
  }

  dimension: field_goals_from_assists {
    type: number
    sql: case when ${assist_sec} = ${field_goal_sec} then 1 else 0 end ;;
  }

  dimension: field_goal_miss {
    type: number
    sql: ${miss2_dunk} + ${miss2_jump} + ${miss2_lay} + ${miss2_tip} + ${miss3_jump} ;;
  }

  dimension: miss3_jump {
    label: "Missed 3-pointer"
    type: number
    sql: case when ${event_type} = "miss3_jump" then 1 else 0 end ;;
  }

  dimension: made3_jump {
    label: "Made 3-pointer"
    type: number
    sql: case when ${event_type} = "made3_jump" then 1 else 0 end ;;
  }

  dimension: 2_pointer {
    type: number
    sql: ${made2_dunk} + ${made2_jump} + ${made2_lay} + ${made2_tip} ;;
  }

  dimension: 2_pointers_miss {
    type: number
    sql: ${miss2_dunk} + ${miss2_jump} + ${miss2_lay} + ${miss2_tip} ;;
  }

  dimension: points_in_the_paint {
    type: number
    sql: ${made2_dunk} + ${made2_lay} + ${made2_tip} ;;
  }

  dimension: missed_in_the_paint {
    type: number
    sql: ${miss2_dunk} + ${miss2_lay} + ${miss2_tip} ;;
  }

  dimension: points {
    type: number
    sql: ${made1_free} + 2*${2_pointer} + 3*${made3_jump} ;;
  }


  measure: count {
    type: count
    drill_fields: []
    html:
    {% if value <= 5 %}
    <p style="color: red; font-size:100%">{{ rendered_value }}</p>
    {% elsif value > 4 %}
    <p style="color: green; font-size:100%">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black;  font-size:100%">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }

  measure: games {
    type: count_distinct
    sql: ${game_id} ;;
  }


  measure: assists {
    type: sum
    sql: ${assist} ;;
    drill_fields: [event_team.team_name, player_name.full_name, assists]
  }


  measure: blocks {
    type: sum
    sql: ${block} ;;
    drill_fields: [event_team.team_name, player_name.full_name, blocks]
  }

  measure: steals {
    type: sum
    sql: ${steal} ;;
    drill_fields: [event_team.team_name, player_name.full_name, steals]
  }

  measure: turnovers {
    type: sum
    sql: ${turnover} ;;
    drill_fields: [event_team.team_name, player_name.full_name, turnovers]
  }

  measure: timeouts {
    type: sum
    sql: ${timeout} ;;
  }

  measure: pers_fouls {
    label: "Total Personal Fouls"
    type: sum
    sql: ${foul_pers} ;;
  }

  measure: tech_fouls {
    label: "Total Techs"
    type: sum
    sql: ${foul_tech} ;;
  }

  measure: def_reb {
    label: "Total Defensive Rebs"
    type: sum
    sql: ${reb_def} ;;
  }

  measure: off_reb {
    label: "Total Offensive Rebs"
    type: sum
    sql: ${reb_off} ;;
  }

  measure: dead_reb {
    label: "Total Dead ball Rebs"
    type: sum
    sql: ${reb_dead} ;;
  }

  measure: total_rebs {
    label: "Total Rebounds"
    type: sum
    sql: ${tot_reb} ;;
    drill_fields: [event_team.team_name, player_name.full_name, total_rebs]

  }

  measure: FTM {
    type: sum
    sql: ${made1_free} ;;
  }

  measure: running_FTM {
    type: running_total
    sql: ${FTM} ;;
  }

  measure: FT_missed {
    type: sum
    sql: ${miss1_free} ;;
  }

  measure: FTA {
    type: number
    sql: ${FTM} + ${FT_missed} ;;
  }


  measure: running_FTA {
    type: running_total
    sql: ${FTA} ;;
  }

  measure: FTP {
    label: "FT%"
    type: number
    sql: ${FTM}/nullif(${FTA},0) ;;
    value_format_name: percent_1
    html:
    {% if value >= 0.85 %}
    <p style="color: black; background-color: seagreen; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.8 %}
    <p style="color: black; background-color: MEDIUMSEAGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.75 %}
    <p style="color: black; background-color: PALEGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.7 %}
    <p style="color: black; background-color: PALEGOLDENROD; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.65 %}
    <p style="color: black; background-color: LEMONCHIFFON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.6 %}
    <p style="color: black; background-color: LIGHTSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.55 %}
    <p style="color: black; background-color: DARKSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.55 %}
    <p style="color: black; background-color: SALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0 %}
    <p style="color: black; background-color: INDIANRED; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: GHOSTWHITE; font-size:120%; text-align:center">{{ rendered_value }}</p>

    {% endif %}
    ;;
  }

  measure: l_points {
    type: max
    sql: ${lpoints} ;;
  }

  measure: w_points {
    type: max
    sql: ${wpoints} ;;
  }

  measure: running_l_points {
    type: running_total
    sql: ${l_points} ;;
  }

  measure: FGM {
    type: sum
    sql: ${field_goal_makes} ;;
  }

  measure: FG_from_assist {
    type: sum
    sql: ${field_goals_from_assists} ;;
  }

  measure: running_FGM {
    type: running_total
    sql: ${FGM} ;;
  }

  measure: FG_missed {
    hidden: yes
    type: sum
    sql: ${field_goal_miss} ;;
  }

  measure: FGA {
    type: number
    sql: ${FGM} + ${FG_missed} ;;
  }

  measure: running_FGA {
    type: running_total
    sql: ${FGA} ;;
  }
  measure: FGP {
    label: "FG%"
    type: number
    sql: ${FGM}/nullif(${FGA},0) ;;
    value_format_name: percent_1
    html:
    {% if value >= 0.6 %}
    <p style="color: black; background-color: seagreen; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.5 %}
    <p style="color: black; background-color: MEDIUMSEAGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.45 %}
    <p style="color: black; background-color: PALEGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.4 %}
    <p style="color: black; background-color: PALEGOLDENROD; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.35 %}
    <p style="color: black; background-color: LEMONCHIFFON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.3 %}
    <p style="color: black; background-color: LIGHTSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.25 %}
    <p style="color: black; background-color: DARKSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.2 %}
    <p style="color: black; background-color: SALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0 %}
    <p style="color: black; background-color: INDIANRED; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: GHOSTWHITE; font-size:120%; text-align:center">{{ rendered_value }}</p>

    {% endif %}
    ;;
  }

  measure: 3PFGM {
    type: sum
    sql: ${made3_jump} ;;
  }

  measure: 3PFG_miss {
    hidden: yes
    type: sum
    sql: ${miss3_jump} ;;
  }

  measure: 3PFGA {
    type: number
    sql: ${3PFGM} + ${3PFG_miss} ;;
  }

  measure: 3PFGP {
    label: "3PFG %"
    type: number
    sql: ${3PFGM}/nullif(${3PFGA}, 0) ;;
    value_format_name: percent_1
    html:
    {% if value >= 0.45 %}
    <p style="color: black; background-color: seagreen; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.4 %}
    <p style="color: black; background-color: MEDIUMSEAGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.35 %}
    <p style="color: black; background-color: PALEGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.3 %}
    <p style="color: black; background-color: PALEGOLDENROD; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.25 %}
    <p style="color: black; background-color: LEMONCHIFFON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.2 %}
    <p style="color: black; background-color: LIGHTSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.15 %}
    <p style="color: black; background-color: DARKSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.1 %}
    <p style="color: black; background-color: SALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0 %}
    <p style="color: black; background-color: INDIANRED; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: GHOSTWHITE; font-size:120%; text-align:center">{{ rendered_value }}</p>

    {% endif %}
    ;;
  }

  measure: paint_FG {
    type: sum
    sql: ${points_in_the_paint} ;;
  }

  measure: paint_miss {
    type: sum
    sql: ${missed_in_the_paint} ;;
  }

  measure: paint_FGA {
    type: number
    sql: ${paint_FG} + ${paint_miss} ;;
  }

  measure: paint_FGP {
    type: number
    sql: ${paint_FG}/nullif(${paint_FGA}, 0) ;;
    value_format_name: percent_1
    html:
    {% if value >= 0.7 %}
    <p style="color: black; background-color: seagreen; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.6 %}
    <p style="color: black; background-color: MEDIUMSEAGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.55 %}
    <p style="color: black; background-color: PALEGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.5 %}
    <p style="color: black; background-color: PALEGOLDENROD; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.45 %}
    <p style="color: black; background-color: LEMONCHIFFON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.4 %}
    <p style="color: black; background-color: LIGHTSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.35 %}
    <p style="color: black; background-color: DARKSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.25 %}
    <p style="color: black; background-color: SALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0 %}
    <p style="color: black; background-color: INDIANRED; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: GHOSTWHITE; font-size:120%; text-align:center">{{ rendered_value }}</p>

    {% endif %}
    ;;
  }

  measure: mid_range_make {
    type: sum
    sql: ${made2_jump} ;;
  }

  measure: mid_range_miss {
    type: sum
    sql: ${miss2_jump} ;;
  }

  measure: mid_range_attempts{
    type: number
    sql: ${mid_range_make} + ${mid_range_miss} ;;
  }

  measure: mid_range_percent {
    type: number
    sql: ${mid_range_make}/nullif(${mid_range_attempts}, 0) ;;
    value_format_name: percent_1
    html:
    {% if value >= 0.6 %}
    <p style="color: black; background-color: seagreen; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.5 %}
    <p style="color: black; background-color: MEDIUMSEAGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.45 %}
    <p style="color: black; background-color: PALEGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.4 %}
    <p style="color: black; background-color: PALEGOLDENROD; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.35 %}
    <p style="color: black; background-color: LEMONCHIFFON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.3 %}
    <p style="color: black; background-color: LIGHTSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.25 %}
    <p style="color: black; background-color: DARKSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.2 %}
    <p style="color: black; background-color: SALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0 %}
    <p style="color: black; background-color: INDIANRED; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: GHOSTWHITE; font-size:120%; text-align:center">{{ rendered_value }}</p>

    {% endif %}
    ;;
  }



  measure: total_points {
    type: sum
    sql: ${points} ;;
    drill_fields: [event_team.team_name, player_name.full_name, FGM, FGA, FGP, 3PFGM, 3PFGA, 3PFGP, FTM, FTA, FTP]
  }

  measure: PPG {
    type: number
    sql: ${total_points}/nullif(${games}, 0) ;;
    value_format_name: decimal_1
    html:
    {% if value >= 20 %}
    <p style="color: black; background-color: seagreen; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 16 %}
    <p style="color: black; background-color: MEDIUMSEAGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 12 %}
    <p style="color: black; background-color: PALEGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 10 %}
    <p style="color: black; background-color: PALEGOLDENROD; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 8 %}
    <p style="color: black; background-color: LEMONCHIFFON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 5 %}
    <p style="color: black; background-color: LIGHTSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 3 %}
    <p style="color: black; background-color: DARKSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 1 %}
    <p style="color: black; background-color: SALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0 %}
    <p style="color: black; background-color: INDIANRED; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: GHOSTWHITE; font-size:120%; text-align:center">{{ rendered_value }}</p>

    {% endif %}
    ;;
  }

  measure: APG {
    type: number
    sql: ${assists}/nullif(${games}, 0) ;;
    value_format_name: decimal_1
    html:
    {% if value >= 8 %}
    <p style="color: black; background-color: seagreen; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 7 %}
    <p style="color: black; background-color: MEDIUMSEAGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 6 %}
    <p style="color: black; background-color: PALEGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 5 %}
    <p style="color: black; background-color: PALEGOLDENROD; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 4 %}
    <p style="color: black; background-color: LEMONCHIFFON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 3 %}
    <p style="color: black; background-color: LIGHTSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 2 %}
    <p style="color: black; background-color: DARKSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 1 %}
    <p style="color: black; background-color: SALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0 %}
    <p style="color: black; background-color: INDIANRED; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: GHOSTWHITE; font-size:120%; text-align:center">{{ rendered_value }}</p>

    {% endif %}
    ;;
  }

  measure: RPG {
    type: number
    sql: ${total_rebs}/nullif(${games}, 0) ;;
    value_format_name: decimal_1
    html:
    {% if value >= 8 %}
    <p style="color: black; background-color: seagreen; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 7 %}
    <p style="color: black; background-color: MEDIUMSEAGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 6 %}
    <p style="color: black; background-color: PALEGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 5 %}
    <p style="color: black; background-color: PALEGOLDENROD; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 4 %}
    <p style="color: black; background-color: LEMONCHIFFON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 3 %}
    <p style="color: black; background-color: LIGHTSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 2 %}
    <p style="color: black; background-color: DARKSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 1 %}
    <p style="color: black; background-color: SALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0 %}
    <p style="color: black; background-color: INDIANRED; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: GHOSTWHITE; font-size:120%; text-align:center">{{ rendered_value }}</p>

    {% endif %}
    ;;
  }

  measure: defensinve_RPG {
    type: number
    sql: ${def_reb}/nullif(${games}, 0) ;;
    value_format_name: decimal_1
  }

  measure: offensive_RPG {
    type: number
    sql: ${off_reb}/nullif(${games}, 0) ;;
    value_format_name: decimal_1
  }

  measure:STLPG {
    type: number
    sql: ${steals}/nullif(${games}, 0) ;;
    value_format_name: decimal_1
    html:
    {% if value >= 2 %}
    <p style="color: black; background-color: seagreen; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 1.5 %}
    <p style="color: black; background-color: MEDIUMSEAGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 1 %}
    <p style="color: black; background-color: PALEGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.75 %}
    <p style="color: black; background-color: PALEGOLDENROD; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.5 %}
    <p style="color: black; background-color: LEMONCHIFFON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.25 %}
    <p style="color: black; background-color: LIGHTSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.15 %}
    <p style="color: black; background-color: DARKSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.1 %}
    <p style="color: black; background-color: SALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0 %}
    <p style="color: black; background-color: INDIANRED; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: GHOSTWHITE; font-size:120%; text-align:center">{{ rendered_value }}</p>

    {% endif %}
    ;;

  }

  measure: BLKPG {
    type: number
    sql: ${blocks}/nullif(${games}, 0) ;;
    value_format_name: decimal_1
    html:
    {% if value >= 1.5 %}
    <p style="color: black; background-color: seagreen; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 1.25 %}
    <p style="color: black; background-color: MEDIUMSEAGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 1 %}
    <p style="color: black; background-color: PALEGREEN; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.75 %}
    <p style="color: black; background-color: PALEGOLDENROD; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.5 %}
    <p style="color: black; background-color: LEMONCHIFFON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.25 %}
    <p style="color: black; background-color: LIGHTSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.15 %}
    <p style="color: black; background-color: DARKSALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0.1 %}
    <p style="color: black; background-color: SALMON; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 0 %}
    <p style="color: black; background-color: INDIANRED; font-size:120%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: GHOSTWHITE; font-size:120%; text-align:center">{{ rendered_value }}</p>

    {% endif %}
    ;;
  }

  measure: TOPG {
    type: number
    sql: ${turnovers}/nullif(${games}, 0) ;;
    value_format_name: decimal_1
  }

  #measure: event {
   # type: sum
   # sql: case when
    #        ${event_type} = '{% parameter event_to_count %}'
    #        then 1
    #        else 0
     #       end ;;
 # }

 # filter: event_to_count {
  #  type: string
  #  suggest_explore: play_by_play2017
  #  suggest_dimension: event_type
  #}
}
