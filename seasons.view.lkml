view: seasons {
  sql_table_name: march_madness.seasons ;;

##This is the actual date that corresponds with day number zero for the season.
##This will be useful when I need to create actual dates for each specific game.
  dimension_group: day_zero {
    description: "The date of day zero of the corresponding season"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DayZero ;;
  }

#Whichever region's name comes first alphabetically, that region will be Region W.
#And whichever Region plays against Region W in the national semifinals, that will be Region X.
#For the other two regions, whichever region's name comes first alphabetically,
#that region will be Region Y, and the other will be Region Z.

  dimension: region_w {
    type: string
    sql: ${TABLE}.RegionW ;;
  }

  dimension: region_x {
    type: string
    sql: ${TABLE}.RegionX ;;
  }

  dimension: region_y {
    type: string
    sql: ${TABLE}.RegionY ;;
  }

  dimension: region_z {
    type: string
    sql: ${TABLE}.RegionZ ;;
  }

  dimension: season {
    description: "This is the year of the season that the actual tournament was played in"
    type: number
    sql: ${TABLE}.Season ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
