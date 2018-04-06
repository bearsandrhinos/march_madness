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

# explore: season_details_2017 {
#   view_name: season_details_2017
#   from: season_details_2017
#   label: "2017 Detailed Season Stats"
#
#   join: game_cities {
#     type: left_outer
#     sql_on: ${season_details_2017.day_num} = ${game_cities.day_num} AND
#             ${season_details_2017.lteam_id} = ${game_cities.lteam_id} AND
#             ${season_details_2017.wteam_id} = ${game_cities.wteam_id};;
#
#     relationship: many_to_one
#   }
#
#   join: cities {
#     type: left_outer
#     sql_on: ${game_cities.city_id} = ${cities.city_id} ;;
#     relationship: many_to_one
#   }
#
#
# }



explore: play_by_play2017 {
  always_filter: {
    filters: {
      field: season
      value: "2017"
    }

    filters: {
      field: winning_rankings.system_name
      value: "POM"
    }

    filters: {
      field: losing_rankings.system_name
      value: "POM"
    }
  }

  join: winning_team {
    from: teams1
    type: left_outer
    sql_on: ${play_by_play2017.wteam_id} = ${winning_team.team_id};;
    relationship: one_to_many
  }

  join: losing_team {
    from: teams1
    type: left_outer
    sql_on: ${play_by_play2017.lteam_id} = ${losing_team.team_id} ;;
    relationship: one_to_many
  }

  join: event_team {
    from: teams1
    type: left_outer
    sql_on: ${play_by_play2017.event_team_id} = ${event_team.team_id} ;;
    relationship: one_to_many
  }

  join: opposing_event_team {
    from: teams1
    type: left_outer
    sql_on: ${play_by_play2017.opposing_team_id} = ${opposing_event_team.team_id} ;;
    relationship: one_to_many
  }

  join: winning_rankings {
    from: rankings
    type: left_outer
    sql_on: ${play_by_play2017.wteam_id} = ${winning_rankings.team_id} AND
             ${play_by_play2017.day_num} BETWEEN ${winning_rankings.ranking_day_num} AND (${winning_rankings.ranking_day_num} + 6)
          AND ${play_by_play2017.season} = ${winning_rankings.season} ;;
          relationship: one_to_one
  }

  join: losing_rankings {
    from: rankings
    type: left_outer
    sql_on: ${play_by_play2017.lteam_id} = ${losing_rankings.team_id} AND
    ${play_by_play2017.day_num} BETWEEN ${losing_rankings.ranking_day_num} AND (${losing_rankings.ranking_day_num} + 6)
    AND ${play_by_play2017.season} = ${losing_rankings.season} ;;
    relationship: one_to_one
  }

  join: player_name {
    from: players2017
    type: left_outer
    sql_on: ${play_by_play2017.event_player_id} = ${player_name.player_id} ;;
    relationship: one_to_one
  }
}

explore: donut_view {
  join: teams1 {
    fields: [teams1.team_id, teams1.team_name]
    type: left_outer
    sql_on: ${donut_view.team_id} = ${teams1.team_id} ;;
    relationship: one_to_one
  }
}


explore: team_game_log {
  always_filter: {
   filters: {
      field: season
      value: "2017"
    }
    #filters: {
    #  field: coaches.season
    #  value: "2017"
    #}
    #filters: {
    #  field: primary_conf.season
    #  value: "2017"
    #}
    #filters: {
    #  field: opposing_conf.season
    #  value: "2017"
    #}
    #filters: {
    #  field: team_conferences.season
    #  value: "2017"
   # }
   #filters: {
    #  field: rankings.season
     #value: "2017"
    #}

    filters: {
      field: primary_rankings.system_name
      value: "POM"
    }

    filters: {
      field: opposing_rankings.system_name
      value: "POM"
    }
  }
  join: cities {
    type: left_outer
    sql_on: ${team_game_log.city_id} = ${cities.city_id} ;;
    relationship: one_to_many
  }

  join: min_location {
    type: inner
    sql_on: ${cities.city} = ${min_location.city} AND
            ${cities.state} = ${min_location.state};;
    relationship: one_to_one
  }

  join: coaches {
    type: left_outer
    sql_on: ${team_game_log.team_id} = ${coaches.team_id}
            AND ${team_game_log.season} = ${coaches.season};;
    relationship: one_to_one
  }


  join: primary_team {
    from: teams1
    type: left_outer
    sql_on: ${team_game_log.team_id} = ${primary_team.team_id};;
    relationship: one_to_many
  }

  join: opposing_team {
    from: teams1
    type: left_outer
    sql_on: ${team_game_log.opponent_id} = ${opposing_team.team_id} ;;
    relationship: one_to_many
  }

  join: primary_conf {
    from: team_conferences
    type: left_outer
    sql_on: ${primary_team.team_id} = ${primary_conf.team_id}
            AND ${team_game_log.season} = ${primary_conf.season};;
    relationship: many_to_one
  }

  join: opposing_conf {
    from: team_conferences
    type: left_outer
    sql_on: ${opposing_team.team_id} = ${opposing_conf.team_id}
            AND ${team_game_log.season} = ${opposing_conf.season};;
    relationship: many_to_one
  }

###This ranking is tough to deal with
  join: primary_rankings {
    from: rankings
    type: left_outer
    sql_on: ${primary_team.team_id} = ${primary_rankings.team_id}
          AND ${team_game_log.day_num} BETWEEN ${primary_rankings.ranking_day_num} AND (${primary_rankings.ranking_day_num} + 6)
          AND ${team_game_log.season} = ${primary_rankings.season};;
    relationship: one_to_many
  }

  join: opposing_rankings {
    from: rankings
    type: left_outer
    sql_on: ${opposing_team.team_id} = ${opposing_rankings.team_id}
          AND ${team_game_log.day_num} BETWEEN ${opposing_rankings.ranking_day_num} AND (${opposing_rankings.ranking_day_num} + 6)
          AND ${team_game_log.season} = ${opposing_rankings.season};;
    relationship: one_to_many
  }

  join: ncaa_tourney_seeds {
    type: left_outer
    sql_on: ${ncaa_tourney_seeds.team_id} = ${team_game_log.team_id}
            AND ${ncaa_tourney_seeds.season} = ${team_game_log.season};;
    relationship: one_to_one
  }
}
