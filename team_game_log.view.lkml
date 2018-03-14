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
    }

    dimension: win {
      description: "If the team won the game"
      type: yesno
      sql: ${score_diff} > 0 ;;
    }

  dimension: ast {
    description: "The number of assists by the team"
    label: "ASTs"
    type: number
    sql: ${TABLE}.ast ;;
  }

  dimension: blk {
    description: "The number of blocks by the team"
    label: "BLKs"
    type: number
    sql: ${TABLE}.blk ;;
  }

  dimension: defr {
    description: "The number of defensive rebounds by the team"
    label: "Def. Reb."
    type: number
    sql: ${TABLE}.defr ;;
  }

  dimension: fga {
    description: "The number of field goal attempts by the team"
    label: "FGA"
    type: number
    sql: ${TABLE}.FGA ;;
  }

  dimension: fga3 {
    description: "The number of three point field goal attempts by the team"
    label: "3PFGA "
    type: number
    sql: ${TABLE}.FGA3 ;;
  }

  dimension: fgm {
    description: "The number of field goals made by the team"
    label: "FGM"
    type: number
    sql: ${TABLE}.FGM ;;
  }

  dimension: FGP {
    label: "FGP"
    description: "Field goal percentage"
    type:number
    sql: ${fgm}/${fga} ;;
    value_format_name: percent_1
  }

  dimension: fgm3 {
    description: "The number of three point field goals made by the team"
    label: "3PFGM"
    type: number
    sql: ${TABLE}.FGM3 ;;
  }

  dimension: 3PFGP {
    label: "3PFGP"
    description: "3 point field goal percentage"
    type: number
    sql: ${fgm3}/${fga3} ;;
    value_format_name: percent_1
  }

  dimension: fta {
    description: "The number of free throw attempts by the team"
    label: "FTA"
    type: number
    sql: ${TABLE}.FTA ;;
  }

  dimension: ftm {
    description: "The number of free throws made by the team"
    label: "FTM"
    type: number
    sql: ${TABLE}.FTM ;;
  }

  dimension: FTP {
    label: "FTP"
    description: "Free throw percentage"
    type: number
    sql: ${ftm}/${fta} ;;
    value_format_name: percent_1
  }

  dimension: loc {
    description: "The location of the team, home or away"
    label: "Location"
    type: string
    sql: ${TABLE}.Loc ;;
  }

  dimension: offr {
    description: "The number of offensive rebounds by the team"
    label: "Off. Reb."
    type: number
    sql: ${TABLE}.offR ;;
  }

  dimension: total_reb {
    description: "Total rebounds"
    type: number
    sql: ${offr} + ${defr} ;;
  }

  dimension: pf {
    description: "The number of personal fouls committed by the team"
    label: "Personal Fouls"
    type: number
    sql: ${TABLE}.PF ;;
  }


  dimension: stl {
    description: "The number of steals by the team"
    label: "STLs"
    type: number
    sql: ${TABLE}.Stl ;;
  }


  dimension: turnover {
    description: "The number of turnovers committed by the team"
    label: "Turnovers"
    type: number
    sql: ${TABLE}.turnover ;;
  }

  dimension: opp_ast {
    description: "The number of assists by the opposing team"
    label: "Opposing ASTs"
    type: number
    sql: ${TABLE}.opp_ast ;;
  }

  dimension: opp_blk {
    description: "The number of blocks by the opposing team"
    label: "Opposing BLKs"
    type: number
    sql: ${TABLE}.opp_blk ;;
  }

  dimension: opp_defr {
    description: "The number of defensive rebounds by the opposing team"
    label: "Opposing Def. Reb."
    type: number
    sql: ${TABLE}.opp_defr ;;
  }

  dimension: opp_fga {
    description: "The number of field goal attempts by the opposing team"
    label: "Opposing FGA"
    type: number
    sql: ${TABLE}.opp_FGA ;;
  }

  dimension: opp_fga3 {
    description: "The number of three point field goal attempts by the opposing team"
    label: "Opposing 3PFGA "
    type: number
    sql: ${TABLE}.opp_FGA3 ;;
  }

  dimension: opp_fgm {
    description: "The number of field goals made by the opposing team"
    label: "Opposing FGM"
    type: number
    sql: ${TABLE}.opp_FGM ;;
  }

  dimension: opp_fgm3 {
    description: "The number of three point field goals made by the opposing team"
    label: "Opposing 3PFGM"
    type: number
    sql: ${TABLE}.opp_FGM3 ;;
  }

  dimension: opp_fgp {
    label: "Opposing FGP"
    description: "The opposing team field goal percentage"
    type: number
    sql: ${opp_fgm}/${opp_fga} ;;
    value_format_name: percent_1
  }

  dimension: opp_3pfgp {
    label: "Opposing 3PFGP"
    description: "The opposing team three point field goal percentage"
    type: number
    sql: ${opp_fgm3}/${opp_fga3} ;;
    value_format_name: percent_1
  }

  dimension: opp_fta {
    description: "The number of free throw attempts by the opposing team"
    label: "Opposing FTA"
    type: number
    sql: ${TABLE}.opp_FTA ;;
  }

  dimension: opp_ftm {
    description: "The number of free throws made by the opposing team"
    label: "Opposing FTM"
    type: number
    sql: ${TABLE}.opp_FTM ;;
  }

  dimension: opp_ftp {
    label: "Opposing FTP"
    description: "The opposing team free throw percentage"
    type: number
    sql: ${opp_ftm}/${opp_fta} ;;
    value_format_name: percent_1
  }


  dimension: opp_offr {
    description: "The number of offensive rebounds by the opposing opposing team"
    label: "Opposing Off. Reb."
    type: number
    sql: ${TABLE}.opp_offR ;;
  }

  dimension: opp_total_reb {
    description: "The total number of rebounds for the opposing team"
    label: "Opposing Total Reb"
    type: number
    sql: ${opp_defr} + ${opp_offr} ;;
  }

  dimension: opp_pf {
    description: "The number of personal fouls committed by the opposing team"
    label: "Opposing Personal Fouls"
    type: number
    sql: ${TABLE}.opp_PF ;;
  }


  dimension: opp_stl {
    description: "The number of steals by the opposing team"
    label: "Opposing STLs"
    type: number
    sql: ${TABLE}.opp_Stl ;;
  }


  dimension: opp_turnover {
    description: "The number of turnovers committed by the opposing team"
    label: "Opposing Turnovers"
    type: number
    sql: ${TABLE}.opp_turnover ;;
  }

  dimension: city_id {
    description: "City id"
    type: number
    sql: ${TABLE}.city_id ;;
  }

  dimension: points_from_2 {
    label: "Points from 2-pointers"
    type: number
    sql: 2*(${fgm} - ${fgm3}) ;;
  }

  dimension: points_from_3 {
    label: "Points from 3-pointers"
    type: number
    sql: 3*${fgm3} ;;
  }

  ####I think these are wrong
  #0.5 * (FGA + 0.475 * FTA - ORB + TOV) + 0.5 * (Opp FGA + 0.475 * Opp FTA - Opp ORB + Opp TOV)
  dimension: possesions {
    label: "Number of possessions"
    type: number
    sql: 0.5*(${fga} + 0.475*${fta} - ${offr} +${turnover}) +
          0.5 * (${opp_fga} + 0.475*${opp_fta} - ${opp_offr} + ${opp_turnover});;
  }
  #this too
  #100 x Pts / (0.5 * ((Tm FGA + 0.4 * Tm FTA - 1.07 * (Tm ORB / (Tm ORB + Opp DRB))
  #* (Tm FGA - Tm FG) + Tm TOV) + (Opp FGA + 0.4 * Opp FTA - 1.07 * (Opp ORB / (Opp ORB + Tm DRB))
  #* (Opp FGA - Opp FG) + Opp TOV)))
  dimension: offensive_rtg {
    label: "Offensive Rating"
    type: number
    sql: 100*(${score}/${possesions});;
    value_format_name: decimal_1
  }

  dimension:defensive_rtg {
    label: "Defensive Rating"
    type: number
    sql: 100*(${opponent_score}/${possesions}) ;;
    value_format_name: decimal_1
  }

  #(FG + 0.5 * 3P) / FGA
  dimension: efg {
    label: "Effective Shooting %"
    type: number
    sql: (${fgm}+0.5*${fgm3})/${fga} ;;
    value_format_name: percent_1
  }

  dimension: opp_efg {
    label: "Opponent Effective Shooting %"
    type: number
    sql: (${opp_fgm}+0.5*${opp_fgm3})/${opp_fga} ;;
    value_format_name: percent_1
  }

  #PTS / (2 * (FGA + 0.475 * FTA)).
  dimension: true_sp {
    label: "True Shooting %"
    type: number
    sql: ${score}/(2*(${fga} + 0.475*${fta})) ;;
    value_format_name: percent_1
  }

  dimension: opp_true_sp {
    label: "Opponent True Shooting %"
    type: number
    sql: ${opponent_score}/(2*(${opp_fga} + 0.475*${fta})) ;;
    value_format_name: percent_1
  }


measure: count {
  type: count
}

measure: team_score1 {
  type: max
  sql: ${score} ;;
}

measure: opp_score1 {
  type: max
  sql: ${opponent_score} ;;
}


measure: PPG {
  label: "PPG"
  description: "Points per game"
  type: average
  sql: ${score} ;;
  value_format_name: decimal_1
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
}

measure: allowed_APG {
  label: "Allowed APG"
  description: "Defensive stat: APG from your opponents"
  type: average
  sql: ${opp_ast} ;;
  value_format_name: decimal_1
}

measure: RPG {
  label: "RPG"
  description: "Rebounds per game"
  type: average
  sql: ${total_reb} ;;
  value_format_name: decimal_1
}

measure: allowed_RPG {
  label: "Allowed RPG"
  description: "Defensive stat: RPG from your opponents"
  type: average
  sql: ${opp_total_reb} ;;
  value_format_name: decimal_1
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
}

measure: allowed_STLPG {
  label: "Allowed STLPG"
  description: "The amount of times the ball was stolen"
  type: average
  sql: ${opp_stl} ;;
  value_format_name: decimal_1
}

measure: BLKPG {
  label: "BLKPG"
  description: "Blocks per game"
  type: average
  sql: ${blk} ;;
  value_format_name: decimal_1
}

measure: allowed_BLKPG {
  label: "Allowed BLKPG"
  description: "The amount of times the ball was blocked"
  type: average
  sql: ${opp_blk} ;;
  value_format_name: decimal_1
}

measure: TOPG {
  label: "TOPG"
  description: "Turnovers per game"
  type: average
  sql: ${turnover} ;;
  value_format_name: decimal_1
}

measure: Forced_TOPG {
  label: "Forced TOPG"
  description: "The number of turnovers forced"
  type: average
  sql: ${opp_turnover} ;;
  value_format_name: decimal_1
}

###### Advanced metrics try








}
