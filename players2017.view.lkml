view: players2017 {
  sql_table_name: march_madness.players2017 ;;

  dimension: player_id {
    description: "This is the unique identifier for the player"
    type: number
    sql: ${TABLE}.PlayerID ;;
  }

  #need to modify, move first name first and last name last and get the underscore out of there
  dimension: player_name {
    description: "Player name"
    type: string
    sql: ${TABLE}.PlayerName ;;

  }

  dimension: last_name {
    type: string
    sql: replace(REGEXP_EXTRACT(${player_name}, r'(.*)_'), "_", " ") ;;
  }

  dimension: first_name {
    type: string
    sql: case when REGEXP_EXTRACT(REGEXP_EXTRACT(${player_name}, r'_(.*)'), r'_(.*)') is null
                      then REGEXP_EXTRACT(${player_name}, r'_(.*)')
                      else REGEXP_EXTRACT(REGEXP_EXTRACT(${player_name}, r'_(.*)'), r'_(.*)') end ;;
  }

  dimension: full_name {
    type: string
    sql: concat(${first_name}, ' ', ${last_name}) ;;
    link: {
      label: "{{ value }} Season Stats"
      url: "/explore/march_madness/play_by_play2017?fields=play_by_play2017.game_date_date,play_by_play2017.total_points,play_by_play2017.FGP,play_by_play2017.3PFGP,play_by_play2017.FTP,play_by_play2017.assists,play_by_play2017.total_rebs,play_by_play2017.steals,play_by_play2017.blocks&f[play_by_play2017.day_num]=%3C134&f[player_name.full_name]={{ value }}&sorts=play_by_play2017.game_date_date&limit=500&column_limit=50&vis=%7B%22show_view_names%22%3Atrue%2C%22show_row_numbers%22%3Atrue%2C%22truncate_column_names%22%3Afalse%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22table_theme%22%3A%22editable%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22type%22%3A%22table%22%2C%22stacking%22%3A%22%22%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22legend_position%22%3A%22center%22%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22y_axis_combined%22%3Atrue%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22series_types%22%3A%7B%7D%2C%22series_labels%22%3A%7B%22play_by_play2017.game_date_date%22%3A%22Game+Date%22%2C%22play_by_play2017.total_points%22%3A%22Total+Points%22%2C%22play_by_play2017.FGP%22%3A%22FG%25%22%2C%22play_by_play2017.3PFGP%22%3A%223PFG%25%22%2C%22play_by_play2017.FTP%22%3A%22FT%25%22%2C%22play_by_play2017.assists%22%3A%22Assists%22%2C%22play_by_play2017.total_rebs%22%3A%22Rebounds%22%2C%22play_by_play2017.steals%22%3A%22Steals%22%2C%22play_by_play2017.blocks%22%3A%22Blocks%22%7D%7D&filter_config=%7B%22play_by_play2017.season%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%222017%22%7D%2C%7B%7D%5D%2C%22id%22%3A4%2C%22error%22%3Afalse%7D%5D%2C%22winning_rankings.system_name%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22POM%22%7D%2C%7B%7D%5D%2C%22id%22%3A5%2C%22error%22%3Afalse%7D%5D%2C%22losing_rankings.system_name%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22POM%22%7D%2C%7B%7D%5D%2C%22id%22%3A6%2C%22error%22%3Afalse%7D%5D%2C%22play_by_play2017.day_num%22%3A%5B%7B%22type%22%3A%22%5Cu003c%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22134%22%7D%2C%7B%7D%5D%2C%22id%22%3A7%2C%22error%22%3Afalse%7D%5D%2C%22player_name.full_name%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22LONZO+BALL%22%7D%2C%7B%7D%5D%2C%22id%22%3A8%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
      icon_url: "http://www.looker.com/favicon.ico"
    }

  }

  dimension: season {
    description: "Year the tournament is played in"
    type: number
    sql: ${TABLE}.Season ;;
  }

  dimension: team_id {
    description: "Team id for the player's team"
    type: number
    sql: ${TABLE}.TeamID ;;
  }

  measure: count {
    type: count
    drill_fields: [player_name]
  }
}
