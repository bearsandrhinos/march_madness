view: ncaa_tourney_slots {
  sql_table_name: march_madness.ncaa_tourney_slots ;;


###This one is pretty hard to use


  dimension: season {
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: slot {
    type: string
    sql: ${TABLE}.Slot ;;
  }

  dimension: strong_seed {
    type: string
    sql: ${TABLE}.StrongSeed ;;
  }

  dimension: weak_seed {
    type: string
    sql: ${TABLE}.WeakSeed ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
