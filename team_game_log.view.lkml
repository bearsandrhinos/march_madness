view: team_game_log {

  derived_table: {
    sql: SELECT
  CONCAT(cast(reg_season_detailed_results.daynum as string), "Y", cast(reg_season_detailed_results.Season as string), "W", cast(reg_season_detailed_results.wteamid as string), "L", cast(reg_season_detailed_results.lteamid as string)) AS game_id,
  reg_season_detailed_results.DayNum    AS day_num,
  reg_season_detailed_results.WTeamID   AS team_id,
  reg_season_detailed_results.LTeamID   AS opponent_id,
  reg_season_detailed_results.WScore    AS score,
  reg_season_detailed_results.LScore    AS opponent_score,
  reg_season_detailed_results.NumOT     AS num_ot,
  reg_season_detailed_results.Season    AS season,
  reg_season_detailed_results.WFGA      AS fga,
  reg_season_detailed_results.WFGM      AS fgm,
  reg_season_detailed_results.WFGA3     AS fga3,
  reg_season_detailed_results.WFGM3     AS fgm3,
  reg_season_detailed_results.WFTA      AS fta,
  reg_season_detailed_results.WFTM      AS ftm,
  reg_season_detailed_results.WDR       AS defr,
  reg_season_detailed_results.WOR       AS offr,
  reg_season_detailed_results.WAst      AS ast,
  reg_season_detailed_results.WBlk      AS blk,
  reg_season_detailed_results.WStl      AS stl,
  reg_season_detailed_results.WPF       AS pf,
  reg_season_detailed_results.WTO       AS turnover,
  (Case when reg_season_detailed_results.WLoc = 'H' then 'H'
        when reg_season_detailed_results.WLoc = 'N' then 'N' else 'A' end)       AS loc,
  reg_season_detailed_results.LFGA      AS opp_fga,
  reg_season_detailed_results.LFGM      AS opp_fgm,
  reg_season_detailed_results.LFGA3     AS opp_fga3,
  reg_season_detailed_results.LFGM3     AS opp_fgm3,
  reg_season_detailed_results.LFTA      AS opp_fta,
  reg_season_detailed_results.LFTM      AS opp_ftm,
  reg_season_detailed_results.LDR       AS opp_defr,
  reg_season_detailed_results.LOR       AS opp_offr,
  reg_season_detailed_results.LAst      AS opp_ast,
  reg_season_detailed_results.LBlk      AS opp_blk,
  reg_season_detailed_results.LStl      AS opp_stl,
  reg_season_detailed_results.LPF       AS opp_pf,
  reg_season_detailed_results.LTO       AS opp_turnover,
  game_cities.CityID                    AS city_id

FROM march_madness.reg_season_detailed_results  AS reg_season_detailed_results
LEFT JOIN march_madness.game_cities  AS game_cities ON reg_season_detailed_results.DayNum = game_cities.DayNum AND
            reg_season_detailed_results.LTeamID = game_cities.LTeamID AND
            reg_season_detailed_results.WTeamID = game_cities.WTeamID

  UNION ALL

  SELECT
  CONCAT(cast(reg_season_detailed_results.daynum as string), "Y", cast(reg_season_detailed_results.Season as string), "W", cast(reg_season_detailed_results.wteamid as string), "L", cast(reg_season_detailed_results.lteamid as string)) AS game_id,
  reg_season_detailed_results.DayNum      AS day_num,
  reg_season_detailed_results.LTeamID     AS team_id,
  reg_season_detailed_results.WTeamID     AS opponent_id,
  reg_season_detailed_results.LScore      AS score,
  reg_season_detailed_results.WScore      AS opponent_score,
  reg_season_detailed_results.NumOT       AS num_ot,
  reg_season_detailed_results.Season      AS season,
  reg_season_detailed_results.LFGA        AS fga,
  reg_season_detailed_results.LFGM        AS fgm,
  reg_season_detailed_results.LFGA3       AS fga3,
  reg_season_detailed_results.LFGM3       AS fgm3,
  reg_season_detailed_results.LFTA        AS fta,
  reg_season_detailed_results.LFTM        AS ftm,
  reg_season_detailed_results.LDR         AS defr,
  reg_season_detailed_results.LOR         AS offr,
  reg_season_detailed_results.LAst        AS ast,
  reg_season_detailed_results.LBlk        AS blk,
  reg_season_detailed_results.LStl        AS stl,
  reg_season_detailed_results.LPF         AS pf,
  reg_season_detailed_results.LTO         AS turnover,
  (Case when reg_season_detailed_results.WLoc = 'H' then 'A'
        when reg_season_detailed_results.WLoc = 'N' then 'N' else 'H' end)       AS loc,
  reg_season_detailed_results.WFGA        AS opp_fga,
  reg_season_detailed_results.WFGM        AS opp_fgm,
  reg_season_detailed_results.WFGA3       AS opp_fga3,
  reg_season_detailed_results.WFGM3       AS opp_fgm3,
  reg_season_detailed_results.WFTA        AS opp_fta,
  reg_season_detailed_results.WFTM        AS opp_ftm,
  reg_season_detailed_results.WDR         AS opp_defr,
  reg_season_detailed_results.WOR         AS opp_offr,
  reg_season_detailed_results.WAst        AS opp_ast,
  reg_season_detailed_results.WBlk        AS opp_blk,
  reg_season_detailed_results.WStl        AS opp_stl,
  reg_season_detailed_results.WPF         AS opp_pf,
  reg_season_detailed_results.WTO         AS opp_turnover,
  game_cities.CityID                      AS city_id

FROM march_madness.reg_season_detailed_results  AS reg_season_detailed_results
LEFT JOIN march_madness.game_cities  AS game_cities ON reg_season_detailed_results.DayNum = game_cities.DayNum AND
            reg_season_detailed_results.LTeamID = game_cities.LTeamID AND
            reg_season_detailed_results.WTeamID = game_cities.WTeamID

       ;;
    }

    dimension: game_id {
      primary_key: yes
      type: string
      sql: ${TABLE}.game_id ;;
    }

    dimension: day_num {
      type: number
      sql: ${TABLE}.day_num ;;
    }
### You did it!!!
    dimension_group: game {
      type: time
      timeframes: [date, month, week, year]
      sql: cast(DATE_SUB(DATE "2017-04-03", INTERVAL (154-${day_num}) DAY) as TIMESTAMP) ;;


    }

    dimension: team_id {
      description: "The individual team id"
      type: string
      sql: ${TABLE}.team_id ;;
    }

    dimension: opponent_id {
      description: "The opposing team id"
      type: string
      sql: ${TABLE}.opponent_id ;;
    }

    dimension: win_id {
      hidden: yes
      type: string
      sql: case when ${win} = 1 then ${team_id}
                else ${opponent_id} end;;
    }

    dimension: lose_id {
      hidden: yes
      type: string
      sql: case when ${win} = 0 then ${team_id}
                else ${opponent_id} end;;
    }

    dimension: score {
      description: "Team score"
      type: number
      sql: ${TABLE}.score ;;
    }

    dimension: opponent_score {
      description: "Opposing team's score"
      type: number
      sql: ${TABLE}.opponent_score ;;
    }

    dimension: num_ot {
      description: "The number of overtimes in the game"
      label: "Amount of Overtimes"
      type: number
      sql: ${TABLE}.num_ot ;;
    }

    dimension: season {
      description: "Year in which the NCAA Tournament took place.  For example, 2017 is the 2016-17 season."
      label: "Season"
      type: number
      sql: ${TABLE}.Season ;;
    }

    dimension: score_diff {
      description: "The score differential"
      type: number
      sql: ${score} - ${opponent_score} ;;
      link: {
        label: "Game Dashboard"
        url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
        icon_url: "{{primary_team.team_logo._value}}"
        }
    }

  dimension: score_diff_2 {
    description: "The score differential"
    type: number
    sql: ${score} - ${opponent_score} ;;
    html: <a href="{{link}}">{{team_game_log.final_score._value}}</a> ;;
    drill_fields: [game_details* ]
    link: {
      label: "Game Dashboard"
      url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
      icon_url: "{{primary_team.team_logo._value}}"
    }
  }

  set: game_details {
    fields: [game_date, final_score, field_goal_makes, field_goal_makes, field_goal_percentage]
  }

    dimension: final_score {
      type: string
      sql: concat(cast(${score} as string), "-", cast(${opponent_score} as string)) ;;
    }

    dimension: win {
      description: "If the team won the game"
      type: number
      sql: if(${score_diff} > 0, 1, 0) ;;
    }

    dimension: lose {
      description: "If the team lost the game"
      type: number
      sql: if(${score_diff} < 0,1, 0) ;;
    }

  dimension: ast {
    #hidden: yes
    description: "The number of assists by the team"
    label: "ASTs"
    type: number
    sql: ${TABLE}.ast ;;
  }

  dimension: blk {
    #hidden: yes
    description: "The number of blocks by the team"
    label: "BLKs"
    type: number
    sql: ${TABLE}.blk ;;
  }

  dimension: defr {
    #hidden: yes
    description: "The number of defensive rebounds by the team"
    label: "Def. Reb."
    type: number
    sql: ${TABLE}.defr ;;
  }

  dimension: fga {
    #hidden: yes
    description: "The number of field goal attempts by the team"
    label: "FGA"
    type: number
    sql: ${TABLE}.FGA ;;
  }

  dimension: fga3 {
    #hidden: yes
    description: "The number of three point field goal attempts by the team"
    label: "3PFGA "
    type: number
    sql: ${TABLE}.FGA3 ;;
  }

  dimension: fgm {
    #hidden: yes
    description: "The number of field goals made by the team"
    label: "FGM"
    type: number
    sql: ${TABLE}.FGM ;;
  }

  dimension: FGP {
    #hidden: yes
    label: "FGP"
    description: "Field goal percentage"
    type:number
    sql: ${fgm}/nullif(${fga}, 0) ;;
    value_format_name: percent_1
  }

  dimension: fgm3 {
    #hidden: yes
    description: "The number of three point field goals made by the team"
    label: "3PFGM"
    type: number
    sql: ${TABLE}.FGM3 ;;
  }

  dimension: 3PFGP {
    #hidden: yes
    label: "3PFGP"
    description: "3 point field goal percentage"
    type: number
    sql: ${fgm3}/nullif(${fga3}, 0) ;;
    value_format_name: percent_1
  }

  dimension: fta {
    #hidden: yes
    description: "The number of free throw attempts by the team"
    label: "FTA"
    type: number
    sql: ${TABLE}.FTA ;;
  }

  dimension: ftm {
    #hidden: yes
    description: "The number of free throws made by the team"
    label: "FTM"
    type: number
    sql: ${TABLE}.FTM ;;
  }

  dimension: FTP {
   # hidden: yes
    label: "FTP"
    description: "Free throw percentage"
    type: number
    sql: ${ftm}/nullif(${fta}, 0) ;;
    value_format_name: percent_1
  }

  dimension: loc {
    description: "The location of the team, home or away"
    label: "Location"
    type: string
    sql: ${TABLE}.Loc ;;
  }

  dimension: offr {
   # hidden: yes
    description: "The number of offensive rebounds by the team"
    label: "Off. Reb."
    type: number
    sql: ${TABLE}.offR ;;
  }

  dimension: total_reb {
    #hidden: yes
    description: "Total rebounds"
    type: number
    sql: ${offr} + ${defr} ;;
  }

  dimension: pf {
    #hidden: yes
    description: "The number of personal fouls committed by the team"
    label: "Personal Fouls"
    type: number
    sql: ${TABLE}.PF ;;
  }


  dimension: stl {
   # hidden: yes
    description: "The number of steals by the team"
    label: "STLs"
    type: number
    sql: ${TABLE}.Stl ;;
  }


  dimension: turnover {
    #hidden: yes
    description: "The number of turnovers committed by the team"
    label: "Turnovers"
    type: number
    sql: ${TABLE}.turnover ;;
  }

  dimension: opp_ast {
    #hidden: yes
    description: "The number of assists by the opposing team"
    label: "Opposing ASTs"
    type: number
    sql: ${TABLE}.opp_ast ;;
  }

  dimension: opp_blk {
    #hidden: yes
    description: "The number of blocks by the opposing team"
    label: "Opposing BLKs"
    type: number
    sql: ${TABLE}.opp_blk ;;
  }

  dimension: opp_defr {
   # hidden: yes
    description: "The number of defensive rebounds by the opposing team"
    label: "Opposing Def. Reb."
    type: number
    sql: ${TABLE}.opp_defr ;;
  }

  dimension: opp_fga {
    #hidden: yes
    description: "The number of field goal attempts by the opposing team"
    label: "Opposing FGA"
    type: number
    sql: ${TABLE}.opp_FGA ;;
  }

  dimension: opp_fga3 {
   # hidden: yes
    description: "The number of three point field goal attempts by the opposing team"
    label: "Opposing 3PFGA "
    type: number
    sql: ${TABLE}.opp_FGA3 ;;
  }

  dimension: opp_fgm {
   # hidden: yes
    description: "The number of field goals made by the opposing team"
    label: "Opposing FGM"
    type: number
    sql: ${TABLE}.opp_FGM ;;
  }

  dimension: opp_fgm3 {
   # hidden: yes
    description: "The number of three point field goals made by the opposing team"
    label: "Opposing 3PFGM"
    type: number
    sql: ${TABLE}.opp_FGM3 ;;
  }

  dimension: opp_fgp {
   # hidden: yes
    label: "Opposing FGP"
    description: "The opposing team field goal percentage"
    type: number
    sql: ${opp_fgm}/nullif(${opp_fga}, 0) ;;
    value_format_name: percent_1
  }

  dimension: opp_3pfgp {
   # hidden: yes
    label: "Opposing 3PFGP"
    description: "The opposing team three point field goal percentage"
    type: number
    sql: ${opp_fgm3}/nullif(${opp_fga3}, 0) ;;
    value_format_name: percent_1
  }

  dimension: opp_fta {
   # hidden: yes
    description: "The number of free throw attempts by the opposing team"
    label: "Opposing FTA"
    type: number
    sql: ${TABLE}.opp_FTA ;;
  }

  dimension: opp_ftm {
   # hidden: yes
    description: "The number of free throws made by the opposing team"
    label: "Opposing FTM"
    type: number
    sql: ${TABLE}.opp_FTM ;;
  }

  dimension: opp_ftp {
   # hidden: yes
    label: "Opposing FTP"
    description: "The opposing team free throw percentage"
    type: number
    sql: ${opp_ftm}/nullif(${opp_fta}, 0) ;;
    value_format_name: percent_1
  }


  dimension: opp_offr {
   # hidden: yes
    description: "The number of offensive rebounds by the opposing opposing team"
    label: "Opposing Off. Reb."
    type: number
    sql: ${TABLE}.opp_offR ;;
  }

  dimension: opp_total_reb {
    #hidden: yes
    description: "The total number of rebounds for the opposing team"
    label: "Opposing Total Reb"
    type: number
    sql: ${opp_defr} + ${opp_offr} ;;
  }

  dimension: opp_pf {
   # hidden: yes
    description: "The number of personal fouls committed by the opposing team"
    label: "Opposing Personal Fouls"
    type: number
    sql: ${TABLE}.opp_PF ;;
  }


  dimension: opp_stl {
   # hidden: yes
    description: "The number of steals by the opposing team"
    label: "Opposing STLs"
    type: number
    sql: ${TABLE}.opp_Stl ;;
  }


  dimension: opp_turnover {
   # hidden: yes
    description: "The number of turnovers committed by the opposing team"
    label: "Opposing Turnovers"
    type: number
    sql: ${TABLE}.opp_turnover ;;
  }

  dimension: city_id {
   # description: "City id"
    type: number
    sql: ${TABLE}.city_id ;;
  }

  dimension: points_from_2 {
   # hidden: yes
    label: "Points from 2-pointers"
    type: number
    sql: 2*(${fgm} - ${fgm3}) ;;
  }

  dimension: points_from_3 {
   # hidden: yes
    label: "Points from 3-pointers"
    type: number
    sql: 3*${fgm3} ;;
  }

  ####I think these are wrong
  #0.5 * (FGA + 0.475 * FTA - ORB + TOV) + 0.5 * (Opp FGA + 0.475 * Opp FTA - Opp ORB + Opp TOV)
  dimension: possesions {
   # hidden: yes
    label: "Number of possessions"
    type: number
    sql: 0.5*(${fga} + 0.475*${fta} - ${offr} +${turnover}) +
          0.5 * (${opp_fga} + 0.475*${opp_fta} - ${opp_offr} + ${opp_turnover});;
  }

  ##Try this.
 # Team Stats = (Team Field Goals + 0.4 * Team Free Throw Attempts –
#1.07 * (Team Offensive Rebounds / (Team Offensive Rebounds + Opponent Defensive Rebounds))
#* (Team Field Goal Attempts – Team Field Goals) + Team Turnovers)

  dimension: primary_poss {
    type: number
    sql: (${fga} + 0.4 * ${fta} - 1.07*(${offr}/(${offr}+${opp_defr}))*(${fga}-${fgm})+${opp_turnover}) ;;
    value_format_name: decimal_0
  }

  #Opponent Stats = (Opponent Field Goal Attempts + 0.4 * Opponent Free Throw Attempts – 1.07
  #* (Opponent Offensive Rebounds / (Opponent Offensive Rebounds + Team Defensive Rebounds))
  #* (Opponent Field Goal Attempts – Opponent Field Goals) + Opponent Turnovers)

  dimension: opp_poss {
    type: number
    sql: (${opp_fga} + 0.4*${opp_fta}-1.07*(${opp_offr}/(${opp_offr}+${defr}))*(${opp_fga}-${opp_fgm})+${turnover}) ;;
    value_format_name: decimal_0
  }


  #this too
  #100 x Pts / (0.5 * ((Tm FGA + 0.4 * Tm FTA - 1.07 * (Tm ORB / (Tm ORB + Opp DRB))
  #* (Tm FGA - Tm FG) + Tm TOV) + (Opp FGA + 0.4 * Opp FTA - 1.07 * (Opp ORB / (Opp ORB + Tm DRB))
  #* (Opp FGA - Opp FG) + Opp TOV)))
  dimension: offensive_rtg {
   # hidden: yes
    label: "Offensive Rating"
    type: number
    sql: 100*(${score}/${primary_poss});;
    value_format_name: decimal_1
  }


  dimension:defensive_rtg {
   # hidden: yes
    label: "Defensive Rating"
    type: number
    sql: 100*(${opponent_score}/${primary_poss}) ;;
    value_format_name: decimal_1
  }

  dimension: opp_off_rtg {
    type: number
    sql: 100*(${opponent_score}/${opp_poss}) ;;
    value_format_name: decimal_1
  }

  dimension: opp_def_rtg {
    type: number
    sql: 100*(${score}/${opp_poss}) ;;
    value_format_name: decimal_1
  }


  #(FG + 0.5 * 3P) / FGA
  dimension: efg {
   # hidden: yes
    label: "Effective Shooting %"
    type: number
    sql: (${fgm}+0.5*${fgm3})/${fga} ;;
    value_format_name: percent_1
  }

  dimension: opp_efg {
   # hidden: yes
    label: "Opponent Effective Shooting %"
    type: number
    sql: (${opp_fgm}+0.5*${opp_fgm3})/${opp_fga} ;;
    value_format_name: percent_1
  }

  #PTS / (2 * (FGA + 0.475 * FTA)).
  dimension: true_sp {
   # hidden: yes
    label: "True Shooting %"
    type: number
    sql: ${score}/(2*(${fga} + 0.475*${fta})) ;;
    value_format_name: percent_1
  }

  dimension: opp_true_sp {
   # hidden: yes
    label: "Opponent True Shooting %"
    type: number
    sql: ${opponent_score}/(2*(${opp_fga} + 0.475*${fta})) ;;
    value_format_name: percent_1
  }

  dimension: pace {
    type: number
    sql: 40*((${primary_poss}+${opp_poss})/(80)) ;;
  }




measure: count {
  type: count
}

####################################################################################################
###      This is the section where I am going to make measures of the dimensions
####################################################################################################

measure: team_score1 {
  type: max
  sql: ${score} ;;
}

measure: opp_score1 {
  type: max
  sql: ${opponent_score} ;;
}

measure: avg_score_diff {
  label: "Score Differential"
  type: average
  sql: ${score_diff} ;;
  link: {
    label: "Game Dashboard"
    url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
    icon_url: "{{primary_team.team_logo._value}}"
  }
}

measure: win1 {
  type: sum
  sql: ${win} ;;
}

measure: win_record {
  type: running_total
  sql:${win1} ;;
}

measure: lose1 {
  type: sum
  sql: ${lose};;
}

measure: lose_record {
  description: "Use only when looking at one team to get the losing record through out the season"
  type: running_total
  sql: ${lose1} ;;
}

measure: assists {
  type: sum
  sql: ${ast} ;;
  drill_fields: [player_stats*]
  link: {
    label: "Game Dashboard"
    url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
    icon_url: "{{primary_team.team_logo._value}}"
    }
}


measure: blocks {
  type: sum
  sql: ${blk} ;;
  link: {
    label: "Game Dashboard"
    url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
    icon_url: "{{primary_team.team_logo._value}}"
    }
}


measure: defensive_rebounds {
  type: sum
  sql: ${defr} ;;
}

measure: offensive_rebounds {
  type: sum
  sql: ${offr} ;;
}

measure: total_rebounds {
  type: sum
  sql: ${total_reb} ;;
  link: {
    label: "Game Dashboard"
    url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
    icon_url: "{{primary_team.team_logo._value}}"
    }
}

measure: field_goal_attempts {
  type: sum
  sql: ${fga} ;;
}

measure: field_goal_makes {
  type: sum
  sql: ${fgm} ;;
}

measure: field_goal_percentage {
  type: average
  sql: ${FGP} ;;
  value_format_name: percent_1
  drill_fields: [primary_team.team_name, game_date, fgm, fga]
}

measure: free_throw_attempts {
  type: sum
  sql: ${fta} ;;
}

measure: free_throw_makes {
  type: sum
  sql: ${ftm} ;;
}

measure: free_throw_percentage {
  type: average
  sql: ${FTP} ;;
  value_format_name: percent_1
  drill_fields: [primary_team.team_name,game_date, ftm, fta]
}

measure: 3_point_field_goal_attempts {
  type: sum
  sql: ${fga3} ;;
}

measure: 3_point_field_goal_makes {
  type: sum
  sql: ${fgm3} ;;
}

measure: 3_point_field_goal_percentage {
  type: average
  sql: ${3PFGP} ;;
  value_format_name: percent_1
  drill_fields: [primary_team.team_name, game_date, fgm3, fga3]
}

measure: steals {
  type: sum
  sql: ${stl} ;;
  link: {
    label: "Game Dashboard"
    url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
    icon_url: "{{primary_team.team_logo._value}}"
    }
}

measure: personal_fouls {
  type: sum
  sql: ${pf} ;;
}

measure: turnovers {
  type: sum
  sql: ${turnover} ;;
  link: {
    label: "Game Dashboard"
    url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
    icon_url: "{{primary_team.team_logo._value}}"
    }
}

  measure: opp_assists {
    type: sum
    sql: ${opp_ast} ;;
    drill_fields: [player_stats*]
    link: {
      label: "Game Dashboard"
      url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
      icon_url: "{{primary_team.team_logo._value}}"
      }
  }


  measure: opp_blocks {
    type: sum
    sql: ${opp_blk} ;;
    link: {
      label: "Game Dashboard"
      url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
      icon_url: "{{primary_team.team_logo._value}}"
      }
  }


  measure: opp_defensive_rebounds {
    type: sum
    sql: ${opp_defr} ;;
  }

  measure: opp_offensive_rebounds {
    type: sum
    sql: ${opp_offr} ;;
  }

  measure: opp_total_rebounds {
    type: sum
    sql: ${opp_total_reb} ;;
    link: {
      label: "Game Dashboard"
      url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
      icon_url: "{{primary_team.team_logo._value}}"
      }
  }

  measure: opp_field_goal_attempts {
    type: sum
    sql: ${opp_fga} ;;
  }

  measure: opp_field_goal_makes {
    type: sum
    sql: ${opp_fgm} ;;
  }

  measure: opp_field_goal_percentage {
    type: average
    sql: ${opp_fgp} ;;
    value_format_name: percent_1
    drill_fields: [opposing_team.team_name, game_date, opp_fgm, opp_fga]
  }

  measure: opp_free_throw_attempts {
    type: sum
    sql: ${opp_fta} ;;
  }

  measure: opp_free_throw_makes {
    type: sum
    sql: ${opp_ftm} ;;
  }

  measure: opp_free_throw_percentage {
    type: average
    sql: ${opp_ftp} ;;
    value_format_name: percent_1
    drill_fields: [opposing_team.team_name, game_date, opp_ftm, opp_fta]
  }

  measure: opp_3_point_field_goal_attempts {
    type: sum
    sql: ${opp_fga3} ;;
  }

  measure: opp_3_point_field_goal_makes {
    type: sum
    sql: ${opp_fgm3} ;;
  }

  measure: opp_3_point_field_goal_percentage {
    type: average
    sql: ${opp_3pfgp} ;;
    value_format_name: percent_1
    drill_fields: [opposing_team.team_name, game_date, opp_fgm3, opp_fga3]

  }

  measure: opp_steals {
    type: sum
    sql: ${opp_stl} ;;
    link: {
      label: "Game Dashboard"
      url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
      icon_url: "{{primary_team.team_logo._value}}"
      }
  }

  measure: opp_personal_fouls {
    type: sum
    sql: ${opp_pf} ;;
  }

  measure: opp_turnovers {
    type: sum
    sql: ${opp_turnover} ;;
    link: {
      label: "Game Dashboard"
      url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
      icon_url: "{{primary_team.team_logo._value}}"
      }
  }

  measure: pts_from_2 {
    type: sum
    sql: ${points_from_2} ;;
  }

  measure: pts_from_3 {
    type: sum
    sql: ${points_from_3} ;;
  }

  measure: game_possesions {
    type: sum
    sql: ${primary_poss} ;;
    value_format_name: decimal_0
  }

  measure: opp_possesion {
    type: sum
    sql: ${opp_poss} ;;
    value_format_name: decimal_0
  }

  measure: offensive_rating {
    type: average
    sql: ${offensive_rtg} ;;
    value_format_name: decimal_1
    html:
    {% if value >= 120 %}
    <p style="color: DARKGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 110 %}
    <p style="color: SEAGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 105 %}
    <p style="color: MEDIUMSEAGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 100 %}
    <p style="color: PALEGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 95 %}
    <p style="color: CORAL; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 90 %}
    <p style="color: INDIANRED; font-size:100%">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black;  font-size:100%">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }

  measure: defensive_rating {
    type: average
    sql: ${defensive_rtg} ;;
    value_format_name: decimal_1
    html:
    {% if value >= 110 %}
    <p style="color: INDIANRED; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 105 %}
    <p style="color: CORAL; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 100 %}
    <p style="color: PALEGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 95 %}
    <p style="color: MEDIUMSEAGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 90 %}
    <p style="color: SEAGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 85 %}
    <p style="color: DARKGREEN; font-size:100%">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black;  font-size:100%">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }

  measure: opp_offensive_rating {
    type: average
    sql: ${opp_off_rtg} ;;
    value_format_name: decimal_1
    html:
    {% if value >= 120 %}
    <p style="color: DARKGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 110 %}
    <p style="color: SEAGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 105 %}
    <p style="color: MEDIUMSEAGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 100 %}
    <p style="color: PALEGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 95 %}
    <p style="color: CORAL; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 90 %}
    <p style="color: INDIANRED; font-size:100%">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black;  font-size:100%">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }

  measure: opp_defensive_rating {
    type: average
    sql: ${opp_def_rtg} ;;
    value_format_name: decimal_1
    html:
    {% if value >= 110 %}
    <p style="color: INDIANRED; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 105 %}
    <p style="color: CORAL; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 100 %}
    <p style="color: PALEGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 95 %}
    <p style="color: MEDIUMSEAGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 90 %}
    <p style="color: SEAGREEN; font-size:100%">{{ rendered_value }}</p>
    {% elsif value >= 85 %}
    <p style="color: DARKGREEN; font-size:100%">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black;  font-size:100%">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }

  measure: effective_shooting_percentage {
    label: "Effective Shooting %"
    type: average
    sql: ${efg} ;;
    value_format_name: percent_1
    drill_fields: [primary_team.team_name, fgm, fga, fgm3, fga3]
  }

  measure: opp_effective_shooting_percentage {
    label: "Opp Effective Shooting %"
    type: average
    sql: ${opp_efg} ;;
    value_format_name: percent_1
    drill_fields: [opposing_team.team_name, opp_fgm, opp_fga, opp_fgm3, opp_fga3]
  }

  measure: true_shooting_percentage {
    label: "True Shooting %"
    type: average
    sql: ${true_sp} ;;
    value_format_name: percent_1
    drill_fields: [primary_team.team_name, fgm, fga, ftm, fta]
  }

  measure: opp_true_shooting_percentage {
    label: "Opp True Shooting %"
    type: average
    sql: ${opp_true_sp} ;;
    value_format_name: percent_1
    drill_fields: [opposing_team.team_name, opp_fgm, opp_fga, opp_ftm, opp_fta]
  }


####################################################################################################
###     This is the per game measures
####################################################################################################
measure: PPG {
  label: "PPG"
  description: "Points per game"
  type: average
  sql: ${score} ;;
  value_format_name: decimal_1
  drill_fields: [game_date, final_score, opposing_team.team_name, assists ]

}

measure: allowed_PPG {
  label: "Allowed PPG"
  description: "Defensive stat: PPG from your opponents"
  type: average
  sql: ${opponent_score} ;;
  value_format_name: decimal_1
}

measure: APG {
  label: "APG"
  description: "Assists per game"
  type: average
  sql: ${ast} ;;
  value_format_name: decimal_1
  drill_fields: [game_date, final_score, opposing_team.team_name, assists ]
}

measure: allowed_APG {
  label: "Allowed APG"
  description: "Defensive stat: APG from your opponents"
  type: average
  sql: ${opp_ast} ;;
  value_format_name: decimal_1
  drill_fields: [game_date, final_score, opposing_team.team_name, opp_assists ]
}

measure: RPG {
  label: "RPG"
  description: "Rebounds per game"
  type: average
  sql: ${total_reb} ;;
  value_format_name: decimal_1
  drill_fields: [game_date, final_score, opposing_team.team_name, total_rebounds ]
}

measure: allowed_RPG {
  label: "Allowed RPG"
  description: "Defensive stat: RPG from your opponents"
  type: average
  sql: ${opp_total_reb} ;;
  value_format_name: decimal_1
  drill_fields: [game_date, final_score, opposing_team.team_name, opp_total_rebounds ]
}

measure: offensive_RPG {
  label: "Offensive RPG"
  description: "Offensive rebounds per game"
  type: average
  sql: ${offr} ;;
  value_format_name: decimal_1
}

measure: allowed_offensive_RPG {
  label: "Allowed Offensive RPG"
  description: "Defensive stat: Offensive RPG from your opponents"
  type: average
  sql: ${opp_offr} ;;
  value_format_name: decimal_1
}

measure: defensive_RPG {
  label: "Defensive RPG"
  description: "Defensive rebounds per game"
  type: average
  sql: ${defr} ;;
  value_format_name: decimal_1
}

measure: allowed_defensive_RPG {
  label: "Allowed Defensive RPG"
  description: "Defensive stat: Defensive RPG from your opponents"
  type: average
  sql: ${opp_defr} ;;
  value_format_name: decimal_1
}

measure: STLPG {
  label: "STLPG"
  description: "Steals per game"
  type: average
  sql: ${stl} ;;
  value_format_name: decimal_1
  drill_fields: [game_date, final_score, opposing_team.team_name, steals ]
}

measure: allowed_STLPG {
  label: "Allowed STLPG"
  description: "The amount of times the ball was stolen"
  type: average
  sql: ${opp_stl} ;;
  value_format_name: decimal_1
  drill_fields: [game_date, final_score, opposing_team.team_name, opp_steals ]
}

measure: BLKPG {
  label: "BLKPG"
  description: "Blocks per game"
  type: average
  sql: ${blk} ;;
  value_format_name: decimal_1
  drill_fields: [game_date, final_score, opposing_team.team_name, blocks ]
}

measure: allowed_BLKPG {
  label: "Allowed BLKPG"
  description: "The amount of times the ball was blocked"
  type: average
  sql: ${opp_blk} ;;
  value_format_name: decimal_1
  drill_fields: [game_date, final_score, opposing_team.team_name, opp_blocks ]
}

measure: TOPG {
  label: "TOPG"
  description: "Turnovers per game"
  type: average
  sql: ${turnover} ;;
  value_format_name: decimal_1
  drill_fields: [game_date, final_score, opposing_team.team_name, turnovers ]
}

measure: Forced_TOPG {
  label: "Forced TOPG"
  description: "The number of turnovers forced"
  type: average
  sql: ${opp_turnover} ;;
  value_format_name: decimal_1
  drill_fields: [game_date, final_score, opposing_team.team_name, opp_turnovers ]
}

###### Advanced metrics try

measure: pace_metric {
  type: average
  sql: ${pace} ;;
  value_format_name: decimal_0
  link: {
    label: "Game Dashboard"
    url: "/dashboards/101?Game%20ID={{team_game_log.game_id._value}}&Winning%20Team={{team_game_log.win_id._value}}&Losing%20Team={{team_game_log.lose_id._value}}"
    icon_url: "{{primary_team.team_logo._value}}"
  }
  html: <a href="https://productday.dev.looker.com/explore/march_madness/team_game_log?fields=opposing_rankings.ordinal_rank,team_game_log.game_date,team_game_log.pace_metric,team_game_log.avg_score_diff&f[team_game_log.season]=2017&f[primary_rankings.system_name]=POM&f[opposing_rankings.system_name]=POM&f[team_game_log.day_num]=%3C134&f[primary_team.team_name]=UCLA&sorts=team_game_log.game_date+desc&limit=500&column_limit=50&query_timezone=America%2FLos_Angeles&vis=%7B%22stacking%22%3A%22%22%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22legend_position%22%3A%22center%22%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Atrue%2C%22limit_displayed_rows%22%3Afalse%2C%22y_axis_combined%22%3Atrue%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22x_axis_scale%22%3A%22ordinal%22%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Atrue%2C%22y_axis_reversed%22%3Afalse%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23e61212%22%2C%22value_labels%22%3A%22legend%22%2C%22label_type%22%3A%22labPer%22%2C%22type%22%3A%22looker_column%22%2C%22hidden_fields%22%3A%5B%22opposing_rankings.ordinal_rank%22%2C%22team_game_log.avg_score_diff%22%5D%2C%22colors%22%3A%5B%22palette%3A+Looker+Classic%22%5D%2C%22series_colors%22%3A%7B%22team_game_log.pace_metric%22%3A%22%23F2A900%22%2C%22team_game_log.avg_score_diff%22%3A%22%233284BF%22%2C%22lose%22%3A%22%230d0c0c%22%2C%22win%22%3A%22%233284BF%22%7D%2C%22limit_displayed_rows_values%22%3A%7B%22show_hide%22%3A%22hide%22%2C%22first_last%22%3A%22first%22%2C%22num_rows%22%3A0%7D%2C%22x_axis_datetime_tick_count%22%3A0%2C%22series_types%22%3A%7B%22team_game_log.pace_metric%22%3A%22line%22%7D%2C%22show_dropoff%22%3Afalse%2C%22hide_legend%22%3Afalse%2C%22y_axes%22%3A%5B%7B%22label%22%3Anull%2C%22maxValue%22%3Anull%2C%22minValue%22%3Anull%2C%22orientation%22%3A%22left%22%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Atrue%2C%22tickDensity%22%3A%22default%22%2C%22tickDensityCustom%22%3Anull%2C%22type%22%3A%22linear%22%2C%22unpinAxis%22%3Afalse%2C%22valueFormat%22%3Anull%2C%22series%22%3A%5B%7B%22id%22%3A%22lose%22%2C%22name%22%3A%22Lose%22%2C%22axisId%22%3A%22lose%22%7D%2C%7B%22id%22%3A%22win%22%2C%22name%22%3A%22Win%22%2C%22axisId%22%3A%22win%22%7D%5D%7D%2C%7B%22label%22%3A%22Pace%22%2C%22maxValue%22%3Anull%2C%22minValue%22%3A50%2C%22orientation%22%3A%22right%22%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Atrue%2C%22tickDensity%22%3A%22default%22%2C%22tickDensityCustom%22%3Anull%2C%22type%22%3A%22linear%22%2C%22unpinAxis%22%3Afalse%2C%22valueFormat%22%3Anull%2C%22series%22%3A%5B%7B%22id%22%3A%22team_game_log.pace_metric%22%2C%22name%22%3A%22Pace%22%2C%22axisId%22%3A%22team_game_log.pace_metric%22%7D%5D%7D%5D%2C%22x_axis_label%22%3A%22Game+Date%22%2C%22series_labels%22%3A%7B%22team_game_log.pace_metric%22%3A%22Pace%22%7D%2C%22x_axis_datetime_label%22%3A%22%25d+%25b+%25y%22%7D&filter_config=%7B%22team_game_log.season%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%222017%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%2C%22primary_rankings.system_name%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22POM%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%2C%22opposing_rankings.system_name%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22POM%22%7D%2C%7B%7D%5D%2C%22id%22%3A2%2C%22error%22%3Afalse%7D%5D%2C%22team_game_log.day_num%22%3A%5B%7B%22type%22%3A%22%5Cu003c%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22134%22%7D%2C%7B%7D%5D%2C%22id%22%3A3%2C%22error%22%3Afalse%7D%5D%2C%22primary_team.team_name%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22UCLA%22%7D%2C%7B%7D%5D%2C%22id%22%3A2%2C%22error%22%3Afalse%7D%5D%7D&dynamic_fields=%5B%7B%22table_calculation%22%3A%22lose%22%2C%22label%22%3A%22Lose%22%2C%22expression%22%3A%22if%28%24%7Bteam_game_log.avg_score_diff%7D%3C0%2C+%24%7Bteam_game_log.avg_score_diff%7D%2C+null%29%22%2C%22value_format%22%3Anull%2C%22value_format_name%22%3Anull%2C%22_kind_hint%22%3A%22measure%22%2C%22_type_hint%22%3A%22number%22%7D%2C%7B%22table_calculation%22%3A%22win%22%2C%22label%22%3A%22Win%22%2C%22expression%22%3A%22if%28%24%7Bteam_game_log.avg_score_diff%7D%3E0%2C+%24%7Bteam_game_log.avg_score_diff%7D%2C+null%29%22%2C%22value_format%22%3Anull%2C%22value_format_name%22%3Anull%2C%22_kind_hint%22%3A%22measure%22%2C%22_type_hint%22%3A%22number%22%7D%5D&origin=share-expanded">Opponent Graph</a> ;;

}


set: player_stats {
  fields: [teams1.team_name, players2017.full_name]
}



}
