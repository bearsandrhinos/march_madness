explore: bracket {}

view: bracket {
  sql_table_name: march_madness.bracket ;;

  dimension: rows {
    type: number
    sql: ${TABLE}.int64_field_1 ;;
  }

  dimension: MWS {
    type: string
    sql: ${TABLE}.string_field_0 ;;
  }

  dimension: SW {
    type: string
    sql: ${TABLE}.string_field_2 ;;
  }

  dimension: seed {
    type: number
    sql: case when ${rows} = 1 then 1
              when ${rows} = 2 then  16
              when ${rows} = 3 then  8
              when ${rows} = 4 then  9
              when ${rows} = 5 then  5
              when ${rows} = 6 then  12
              when ${rows} = 7 then  4
              when ${rows} = 8 then  13
              when ${rows} = 9 then  6
              when ${rows} = 10 then  11
              when ${rows} = 11 then  3
              when ${rows} = 12 then  14
              when ${rows} = 13 then  7
              when ${rows} = 14 then  10
              when ${rows} = 15 then  2
              when ${rows} = 16 then  15
              when ${rows} = 17 then  1
              when ${rows} = 18 then  16
              when ${rows} = 19 then  8
              when ${rows} = 20 then  9
              when ${rows} = 21 then 5
              when ${rows} = 22 then 12
              when ${rows} = 23 then 4
              when ${rows} = 24 then  13
              when ${rows} = 25 then  6
              when ${rows} = 26 then  11
              when ${rows} = 27 then 3
              when ${rows} = 28 then  14
              when ${rows} = 29 then  7
              when ${rows} = 30 then  10
              when ${rows} = 31 then  2
              when ${rows} = 32 then 15
              end;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
