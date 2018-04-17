view: teams1 {
  sql_table_name: march_madness.teams1 ;;

  dimension: first_d1_season {
    type: number
    sql: ${TABLE}.FirstD1Season ;;
  }

  dimension: last_d1_season {
    type: number
    sql: ${TABLE}.LastD1Season ;;
  }

  dimension: logo_url {
    type: string
    sql: ${TABLE}.Logo ;;
  }

  dimension: team_id {
    type: number
    sql: ${TABLE}.TeamID ;;
  }

  dimension: team_name {
    type: string
    sql: ${TABLE}.TeamName ;;
    link: {
      label: "Team Dashboard"
      url: "/dashboards/97?Team%20Name={{value}}"
      icon_url: "{{ team_logo._value}}"
    }
  }

  parameter: testparam {
    type: string
    suggestions: ["Villanova",
                  "Mt St Mary's",
"Wisconsin",
"Virginia Tech",
"Virginia",
"UNC Wilmington",
"Florida",
"ETSU",
"SMU",
"USC",
"Baylor",
"New Mexico St",
"South Carolina",
"Marquette",
"Duke",
"Troy",
"Gonzaga",
"S Dakota St",
"Northwestern",
"Vanderbilt",
"Notre Dame",
"Princeton",
"West Virginia",
"Bucknell",
"Maryland",
"Xavier",
"Florida St",
"FL Gulf Coast",
"St Mary's CA",
"VCU",
"Arizona",
"North Dakota",
"Kansas",
"UC Davis",
"Miami FL",
"Michigan St",
"Iowa St",
"Nevada",
"Purdue",
"Vermont",
"Creighton",
"Rhode Island",
"Oregon",
"Iona",
"Michigan",
"Oklahoma St",
"Louisville",
"Jacksonville St",
"North Carolina",
"TX Southern",
"Arkansas",
"Seton Hall",
"Minnesota",
"MTSU",
"Butler",
"Winthrop",
"Cincinnati",
"Kansas St",
"UCLA",
"Kent",
"Dayton",
"Wichita St",
"Kentucky",
"N Kentucky"]
  }

  parameter: testparam1 {
    type: string
    suggestions: ["Villanova",
      "Mt St Mary's",
      "Wisconsin",
      "Virginia Tech",
      "Virginia",
      "UNC Wilmington",
      "Florida",
      "ETSU",
      "SMU",
      "USC",
      "Baylor",
      "New Mexico St",
      "South Carolina",
      "Marquette",
      "Duke",
      "Troy",
      "Gonzaga",
      "S Dakota St",
      "Northwestern",
      "Vanderbilt",
      "Notre Dame",
      "Princeton",
      "West Virginia",
      "Bucknell",
      "Maryland",
      "Xavier",
      "Florida St",
      "FL Gulf Coast",
      "St Mary's CA",
      "VCU",
      "Arizona",
      "North Dakota",
      "Kansas",
      "UC Davis",
      "Miami FL",
      "Michigan St",
      "Iowa St",
      "Nevada",
      "Purdue",
      "Vermont",
      "Creighton",
      "Rhode Island",
      "Oregon",
      "Iona",
      "Michigan",
      "Oklahoma St",
      "Louisville",
      "Jacksonville St",
      "North Carolina",
      "TX Southern",
      "Arkansas",
      "Seton Hall",
      "Minnesota",
      "MTSU",
      "Butler",
      "Winthrop",
      "Cincinnati",
      "Kansas St",
      "UCLA",
      "Kent",
      "Dayton",
      "Wichita St",
      "Kentucky",
      "N Kentucky"]
  }

  dimension: team_highlight1 {
    type: string
    sql: case
          when {% parameter testparam %} = 'Villanova' then 'Villanova'
          when {% parameter testparam %} = "Mt St Mary's" then "Mt St Mary's"
          when {% parameter testparam %} = 'Wisconsin' then 'Wisconsin'
          when {% parameter testparam %} = 'Virginia Tech' then 'Virginia Tech'
          when {% parameter testparam %} = 'Virginia' then 'Virginia'
          when {% parameter testparam %} = 'UNC Wilmington' then 'UNC Wilmington'
          when {% parameter testparam %} = 'Florida' then 'Florida'
          when {% parameter testparam %} = 'ETSU' then 'ETSU'
          when {% parameter testparam %} = 'SMU' then 'SMU'
          when {% parameter testparam %} = 'USC' then 'USC'
          when {% parameter testparam %} = 'Baylor' then 'Baylor'
          when {% parameter testparam %} = 'New Mexico St' then 'New Mexico St'
          when {% parameter testparam %} = 'South Carolina' then 'South Carolina'
          when {% parameter testparam %} = 'Marquette' then 'Marquette'
          when {% parameter testparam %} = 'Duke ' then 'Duke '
          when {% parameter testparam %} = 'Troy' then 'Troy'
          when {% parameter testparam %} = 'Gonzaga' then 'Gonzaga'
          when {% parameter testparam %} = 'S Dakota St' then 'S Dakota St'
          when {% parameter testparam %} = 'Northwestern' then 'Northwestern'
          when {% parameter testparam %} = 'Vanderbilt' then 'Vanderbilt'
          when {% parameter testparam %} = 'Notre Dame' then 'Notre Dame'
          when {% parameter testparam %} = 'Princeton' then 'Princeton'
          when {% parameter testparam %} = 'West Virginia' then 'West Virginia'
          when {% parameter testparam %} = 'Bucknell' then 'Bucknell'
          when {% parameter testparam %} = 'Maryland' then 'Maryland'
          when {% parameter testparam %} = 'Xavier' then 'Xavier'
          when {% parameter testparam %} = 'Florida St' then 'Florida St'
          when {% parameter testparam %} = 'FL Gulf Coast' then 'FL Gulf Coast'
          when {% parameter testparam %} = "St Mary's CA" then "St Mary's CA"
          when {% parameter testparam %} = 'VCU' then 'VCU'
          when {% parameter testparam %} = 'Arizona' then 'Arizona'
          when {% parameter testparam %} = 'North Dakota' then 'North Dakota'
          when {% parameter testparam %} = 'Kansas' then 'Kansas'
          when {% parameter testparam %} = 'UC Davis' then 'UC Davis'
          when {% parameter testparam %} = 'Miami FL' then 'Miami FL'
          when {% parameter testparam %} = 'Michigan St' then 'Michigan St'
          when {% parameter testparam %} = 'Iowa St' then 'Iowa St'
          when {% parameter testparam %} = 'Nevada' then 'Nevada'
          when {% parameter testparam %} = 'Purdue' then 'Purdue'
          when {% parameter testparam %} = 'Vermont' then 'Vermont'
          when {% parameter testparam %} = 'Creighton' then 'Creighton'
          when {% parameter testparam %} = 'Rhode Island' then 'Rhode Island'
          when {% parameter testparam %} = 'Oregon' then 'Oregon'
          when {% parameter testparam %} = 'Iona' then 'Iona'
          when {% parameter testparam %} = 'Michigan' then 'Michigan'
          when {% parameter testparam %} = 'Oklahoma St' then 'Oklahoma St'
          when {% parameter testparam %} = 'Louisville' then 'Louisville'
          when {% parameter testparam %} = 'Jacksonville St' then 'Jacksonville St'
          when {% parameter testparam %} = 'North Carolina ' then 'North Carolina '
          when {% parameter testparam %} = 'TX Southern' then 'TX Southern'
          when {% parameter testparam %} = 'Arkansas' then 'Arkansas'
          when {% parameter testparam %} = 'Seton Hall' then 'Seton Hall'
          when {% parameter testparam %} = 'Minnesota' then 'Minnesota'
          when {% parameter testparam %} = 'MTSU' then 'MTSU'
          when {% parameter testparam %} = 'Butler' then 'Butler'
          when {% parameter testparam %} = 'Winthrop' then 'Winthrop'
          when {% parameter testparam %} = 'Cincinnati' then 'Cincinnati'
          when {% parameter testparam %} = 'Kansas St' then 'Kansas St'
          when {% parameter testparam %} = 'UCLA' then 'UCLA'
          when {% parameter testparam %} = 'Kent' then 'Kent'
          when {% parameter testparam %} = 'Dayton' then 'Dayton'
          when {% parameter testparam %} = 'Wichita St' then 'Wichita St'
          when {% parameter testparam %} = 'Kentucky' then 'Kentucky'
          when {% parameter testparam %} = 'N Kentucky' then 'N Kentucky'
          end ;;
  }

  dimension: team_highlight2 {
    type: string
    sql: case
          when {% parameter testparam1 %} = 'Villanova' then 'Villanova'
          when {% parameter testparam1 %} = "Mt St Mary's" then "Mt St Mary's"
          when {% parameter testparam1 %} = 'Wisconsin' then 'Wisconsin'
          when {% parameter testparam1 %} = 'Virginia Tech' then 'Virginia Tech'
          when {% parameter testparam1 %} = 'Virginia' then 'Virginia'
          when {% parameter testparam1 %} = 'UNC Wilmington' then 'UNC Wilmington'
          when {% parameter testparam1 %} = 'Florida' then 'Florida'
          when {% parameter testparam1 %} = 'ETSU' then 'ETSU'
          when {% parameter testparam1 %} = 'SMU' then 'SMU'
          when {% parameter testparam1 %} = 'USC' then 'USC'
          when {% parameter testparam1 %} = 'Baylor' then 'Baylor'
          when {% parameter testparam1 %} = 'New Mexico St' then 'New Mexico St'
          when {% parameter testparam1 %} = 'South Carolina' then 'South Carolina'
          when {% parameter testparam1 %} = 'Marquette' then 'Marquette'
          when {% parameter testparam1 %} = 'Duke' then 'Duke'
          when {% parameter testparam1 %} = 'Troy' then 'Troy'
          when {% parameter testparam1 %} = 'Gonzaga' then 'Gonzaga'
          when {% parameter testparam1 %} = 'S Dakota St' then 'S Dakota St'
          when {% parameter testparam1 %} = 'Northwestern' then 'Northwestern'
          when {% parameter testparam1 %} = 'Vanderbilt' then 'Vanderbilt'
          when {% parameter testparam1 %} = 'Notre Dame' then 'Notre Dame'
          when {% parameter testparam1 %} = 'Princeton' then 'Princeton'
          when {% parameter testparam1 %} = 'West Virginia' then 'West Virginia'
          when {% parameter testparam1 %} = 'Bucknell' then 'Bucknell'
          when {% parameter testparam1 %} = 'Maryland' then 'Maryland'
          when {% parameter testparam1 %} = 'Xavier' then 'Xavier'
          when {% parameter testparam1 %} = 'Florida St' then 'Florida St'
          when {% parameter testparam1 %} = 'FL Gulf Coast' then 'FL Gulf Coast'
          when {% parameter testparam1 %} = "St Mary's CA" then "St Mary's CA"
          when {% parameter testparam1 %} = 'VCU' then 'VCU'
          when {% parameter testparam1 %} = 'Arizona' then 'Arizona'
          when {% parameter testparam1 %} = 'North Dakota' then 'North Dakota'
          when {% parameter testparam1 %} = 'Kansas' then 'Kansas'
          when {% parameter testparam1 %} = 'UC Davis' then 'UC Davis'
          when {% parameter testparam1 %} = 'Miami FL' then 'Miami FL'
          when {% parameter testparam1 %} = 'Michigan St' then 'Michigan St'
          when {% parameter testparam1 %} = 'Iowa St' then 'Iowa St'
          when {% parameter testparam1 %} = 'Nevada' then 'Nevada'
          when {% parameter testparam1 %} = 'Purdue' then 'Purdue'
          when {% parameter testparam1 %} = 'Vermont' then 'Vermont'
          when {% parameter testparam1 %} = 'Creighton' then 'Creighton'
          when {% parameter testparam1 %} = 'Rhode Island' then 'Rhode Island'
          when {% parameter testparam1 %} = 'Oregon' then 'Oregon'
          when {% parameter testparam1 %} = 'Iona' then 'Iona'
          when {% parameter testparam1 %} = 'Michigan' then 'Michigan'
          when {% parameter testparam1 %} = 'Oklahoma St' then 'Oklahoma St'
          when {% parameter testparam1 %} = 'Louisville' then 'Louisville'
          when {% parameter testparam1 %} = 'Jacksonville St' then 'Jacksonville St'
          when {% parameter testparam1 %} = 'North Carolina ' then 'North Carolina '
          when {% parameter testparam1 %} = 'TX Southern' then 'TX Southern'
          when {% parameter testparam1 %} = 'Arkansas' then 'Arkansas'
          when {% parameter testparam1 %} = 'Seton Hall' then 'Seton Hall'
          when {% parameter testparam1 %} = 'Minnesota' then 'Minnesota'
          when {% parameter testparam1 %} = 'MTSU' then 'MTSU'
          when {% parameter testparam1 %} = 'Butler' then 'Butler'
          when {% parameter testparam1 %} = 'Winthrop' then 'Winthrop'
          when {% parameter testparam1 %} = 'Cincinnati' then 'Cincinnati'
          when {% parameter testparam1 %} = 'Kansas St' then 'Kansas St'
          when {% parameter testparam1 %} = 'UCLA' then 'UCLA'
          when {% parameter testparam1 %} = 'Kent' then 'Kent'
          when {% parameter testparam1 %} = 'Dayton' then 'Dayton'
          when {% parameter testparam1 %} = 'Wichita St' then 'Wichita St'
          when {% parameter testparam1 %} = 'Kentucky' then 'Kentucky'
          when {% parameter testparam1 %} = 'N Kentucky' then 'N Kentucky'
          end ;;
  }


  dimension: team_logo {
    sql: ${logo_url} ;;
    html: <img src="{{value}}"  /> ;;
  }

  measure: count {
    type: count
    drill_fields: [team_name]
  }
}
