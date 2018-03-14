view: season_details_2017 {

# Or, you could make this view a derived table, like this:
   derived_table: {
      sql: SELECT
         * FROM march_madness.reg_season_detailed_results
            WHERE Season = 2017
       ;;
      persist_for: "360 hours"
  }

  dimension: game_id {
    primary_key: yes
   sql: CONCAT(cast(${TABLE}.daynum as string), "Y", cast(${TABLE}.Season as string), "W", cast(${TABLE}.wteamid as string), "L", cast(${TABLE}.lteamid as string));;
  }

  dimension: day_num {
    description: "The actual day number of the game"
    type: number
    sql: ${TABLE}.DayNum ;;
  }

  dimension: last {
    description: "The number of assists for the losing team"
    type: number
    sql: ${TABLE}.LAst ;;
  }

  dimension: lblk {
    description: "The number of blocks for the losing team"
    type: number
    sql: ${TABLE}.LBlk ;;
  }

  dimension: ldr {
    description: "The number of defensive rebounds for the losing team"
    type: number
    sql: ${TABLE}.LDR ;;
  }

  dimension: lfga {
    description: "The number of field goal attempts by the losing team"
    type: number
    sql: ${TABLE}.LFGA ;;
  }

  dimension: lfga3 {
    description: "The number of three point field goal attempts by the losing team"
    type: number
    sql: ${TABLE}.LFGA3 ;;
  }

  dimension: lfgm {
    description: "The number of field goals made by the losing team"
    type: number
    sql: ${TABLE}.LFGM ;;
  }

  dimension: lfgm3 {
    description: "The number of three point field goals made by the losing team"
    type: number
    sql: ${TABLE}.LFGM3 ;;
  }

  dimension: lfta {
    description: "The number of free throw attempts by the losing team"
    type: number
    sql: ${TABLE}.LFTA ;;
  }

  dimension: lftm {
    description: "The number of free throws made by the losing team"
    type: number
    sql: ${TABLE}.LFTM ;;
  }

  dimension: lor {
    description: "The number of offensive rebounds by the losing team"
    type: number
    sql: ${TABLE}.LOR ;;
  }

  dimension: lpf {
    description: "The number of personal fouls committed by the losing team"
    type: number
    sql: ${TABLE}.LPF ;;
  }

  dimension: lscore {
    description: "The amount of points scored by the losing team"
    type: number
    sql: ${TABLE}.LScore ;;
  }

  dimension: lstl {
    description: "The number of steals by the losing team"
    type: number
    sql: ${TABLE}.LStl ;;
  }

  dimension: lteam_id {
    description: "The team id for the losing team"
    type: number
    sql: ${TABLE}.LTeamID ;;
  }

  dimension: lto {
    description: "The number of turnovers committed by the losing team"
    type: number
    sql: ${TABLE}.LTO ;;
  }

  dimension: num_ot {
    description: "The number of overtime periods in the game"
    type: number
    sql: ${TABLE}.NumOT ;;
  }

  dimension: season {
    description: "The year the tournament was played in"
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: wast {
    description: "The number of assists by the winning team"
    type: number
    sql: ${TABLE}.WAst ;;
  }

  dimension: wblk {
    description: "The number of blocks by the winning team"
    type: number
    sql: ${TABLE}.WBlk ;;
  }

  dimension: wdr {
    description: "The number of defensive rebounds by the winning team"
    type: number
    sql: ${TABLE}.WDR ;;
  }

  dimension: wfga {
    description: "The number of field goal attempts by the winning team"
    type: number
    sql: ${TABLE}.WFGA ;;
  }

  dimension: wfga3 {
    description: "The number of three point field goal attempts by the winning team"
    type: number
    sql: ${TABLE}.WFGA3 ;;
  }

  dimension: wfgm {
    description: "The number of field goals made by the winning team"
    type: number
    sql: ${TABLE}.WFGM ;;
  }

  dimension: wfgm3 {
    description: "The number of three point field goals made by the winning team"
    type: number
    sql: ${TABLE}.WFGM3 ;;
  }

  dimension: wfta {
    description: "The number of free throw attempts by the winning team"
    type: number
    sql: ${TABLE}.WFTA ;;
  }

  dimension: wftm {
    description: "The number of free throws made by the winning team"
    type: number
    sql: ${TABLE}.WFTM ;;
  }

  dimension: wloc {
    description: "The location of the winning team, home or away"
    type: string
    sql: ${TABLE}.WLoc ;;
  }

  dimension: wor {
    description: "The number of offensive rebounds by the winning team"
    type: number
    sql: ${TABLE}.WOR ;;
  }

  dimension: wpf {
    description: "The number of personal fouls committed by the winning team"
    type: number
    sql: ${TABLE}.WPF ;;
  }

  dimension: wscore {
    description: "The amount of points scored by the winning team"
    type: number
    sql: ${TABLE}.WScore ;;
  }

  dimension: wstl {
    description: "The number of steals by the winning team"
    type: number
    sql: ${TABLE}.WStl ;;
  }

  dimension: wteam_id {
    description: "The team id for the winning team"
    type: number
    sql: ${TABLE}.WTeamID ;;
  }

  dimension: wto {
    description: "The number of turnovers committed by the winning team"
    type: number
    sql: ${TABLE}.WTO ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

}
