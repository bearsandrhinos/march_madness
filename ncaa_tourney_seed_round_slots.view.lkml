view: ncaa_tourney_seed_round_slots {
  sql_table_name: march_madness.ncaa_tourney_seed_round_slots ;;

  dimension: early_day_num {
    description: "Earliest day the game can occur on"
    type: number
    sql: ${TABLE}.EarlyDayNum ;;
  }

  dimension: game_round {
    description: "This is the round of the tournament the game happens on"
    type: number
    sql: ${TABLE}.GameRound ;;
  }

  dimension: game_slot {
    description: "This is the slot of the game, region and the higher ranked team"
    type: string
    sql: ${TABLE}.GameSlot ;;
  }

  dimension: late_day_num {
    description: "The latest day this game can occur"
    type: number
    sql: ${TABLE}.LateDayNum ;;
  }

  dimension: seed {
    description: "Tournament seed of the corresponding team"
    type: string
    sql: ${TABLE}.Seed ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
