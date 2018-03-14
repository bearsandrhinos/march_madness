connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: march_madness_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: march_madness_default_datagroup

#Lets try this right now.  Lets do it just for the 2017 season.

explore: season_details_2017 {
  view_name: season_details_2017
  from: season_details_2017
  label: "2017 Detailed Season Stats"

  join: game_cities {
    type: left_outer
    sql_on: ${season_details_2017.day_num} = ${game_cities.day_num} AND
            ${season_details_2017.lteam_id} = ${game_cities.lteam_id} AND
            ${season_details_2017.wteam_id} = ${game_cities.wteam_id};;

    relationship: many_to_one
  }

  join: cities {
    type: left_outer
    sql_on: ${game_cities.city_id} = ${cities.city_id} ;;
    relationship: many_to_one
  }


}

explore: reg_season_detailed_results {

}

explore: play_by_play2017 {

}

explore: players2017 {

}

explore: team_game_log {
  always_filter: {
   filters: {
      field: season
      value: "2017"
    }
    filters: {
      field: coaches.season
      value: "2017"
    }
    filters: {
      field: primary_conf.season
      value: "2017"
    }
    filters: {
      field: opposing_conf.season
      value: "2017"
    }
    #filters: {
    #  field: team_conferences.season
    #  value: "2017"
   # }
   # filters: {
   #   field: rankings.season
   #   value: "2017"
    #}
  }
  join: cities {
    type: left_outer
    sql_on: ${team_game_log.city_id} = ${cities.city_id} ;;
    relationship: one_to_many
  }

  join: coaches {
    type: left_outer
    sql_on: ${team_game_log.team_id} = ${coaches.team_id} ;;
    relationship: many_to_one
  }


  join: primary_team {
    from: teams
    type: left_outer
    sql_on: ${team_game_log.team_id} = ${primary_team.team_id};;
    relationship: one_to_many
  }

  join: opposing_team {
    from: teams
    type: left_outer
    sql_on: ${team_game_log.opponent_id} = ${opposing_team.team_id} ;;
    relationship: one_to_many
  }

  join: primary_conf {
    from: team_conferences
    type: left_outer
    sql_on: ${team_game_log.team_id} = ${primary_conf.team_id} ;;
    relationship: many_to_one
  }

  join: opposing_conf {
    from: team_conferences
    type: left_outer
    sql_on: ${team_game_log.opponent_id} = ${opposing_conf.team_id} ;;
    relationship: many_to_one
  }

###This ranking is tough to deal with
  #join: rankings {
  #  type: left_outer
  #  sql_on: ${team_game_log.team_id} = ${rankings.team_id}
  #        AND (case when ;;
  #  relationship: one_to_many
  #}
}
