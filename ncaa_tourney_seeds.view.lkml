view: ncaa_tourney_seeds {
  sql_table_name: march_madness.ncaa_tourney_seeds ;;

  dimension: season {
    description: "The year the tournament was played in"
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: seed {
    description: "This is a 3-4 letter/number identifier.  It is the conference followed by the seed, and then a or b if it was a play in tournament"
    type: string
    sql: ${TABLE}.Seed ;;
  }

  dimension: region_id {
    type: string
    sql: rtrim(${seed}, "0123456789ab") ;;
  }

  dimension: region {
    type: string
    sql: case when ${region_id} = 'W' then "East"
              when ${region_id} = 'X' then "West"
              when ${region_id} = 'Y' then "Midwest"
              else "South" end;;
  }

  dimension: tourney_seed {
    type: number
    sql: rtrim(ltrim(${seed}, "WXYZ"),"ab") ;;
  }

  dimension: team_id {
    description: "The id number of the team"
    type: number
    sql: ${TABLE}.TeamID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
