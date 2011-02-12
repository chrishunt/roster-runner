def build_league(sport, short_name, name, male_uri, female_uri = nil)
  league = League.new
  league.is_custom = false
  league.sport = sport
  league.short_name = short_name
  league.name = name
  league.male_uri = male_uri
  league.female_uri = female_uri
  league.save
end

########################################
# CUSTOM SPORT
########################################
sport = Sport.new
sport.name = "Custom"
sport.save

########################################
# BASEBALL SPORT
########################################
sport = Sport.new
sport.name = "Baseball"
sport.save

################
# MLB LEAGUE
################
build_league(sport,
             "MLB", 
             "Major League Baseball",
             "http://espn.go.com/mlb/teams")

########################################
# BASKETBALL SPORT
########################################
sport = Sport.new
sport.name = "Basketball"
sport.save

#################
## NCAA BB LEAGUE
#################
build_league(sport,
             "NCAA BB", 
             "NCAA Basketball",
             "http://espn.go.com/mens-college-basketball/teams")

#################
## NBA LEAGUE
#################
build_league(sport,
             "NBA", 
             "National Basketball Association",
             "http://espn.go.com/nba/teams",
             "http://sports.espn.go.com/wnba/teams")

########################################
# FOOTBALL SPORT
########################################
sport = Sport.new
sport.name = "Football"
sport.save

################
# NCAA FB LEAGUE
################
build_league(sport,
             "NCAA FB", 
             "NCAA Football",
             "http://espn.go.com/college-football/teams")

################
# NFL LEAGUE
################
build_league(sport,
             "NFL", 
             "National Football League",
             "http://espn.go.com/nfl/teams")

#########################################
## SOCCER SPORT
#########################################
sport = Sport.new
sport.name = "Soccer"
sport.save

################
# MLS LEAGUE
################
teams = [
  {
    :name => "Chicago Fire",
    :url => "http://www.mlssoccer.com/players/chicago-fire"
  },
  {
    :name => "Chivas USA",
    :url => "http://www.mlssoccer.com/players/chivas-usa"
  },
  {
    :name => "Colorado Rapids",
    :url => "http://www.mlssoccer.com/players/colorado-rapids"
  },
  {
    :name => "Columbus Crew",
    :url => "http://www.mlssoccer.com/players/columbus-crew"
  },
  {
    :name => "D.C. United",
    :url => "http://www.mlssoccer.com/players/dc-united"
  },
  {
    :name => "FC Dallas",
    :url => "http://www.mlssoccer.com/players/fc-dallas"
  },
  {
    :name => "Houston Dynamo",
    :url => "http://www.mlssoccer.com/players/houston-dynamo"
  },
  {
    :name => "Sporting Kansas City",
    :url => "http://www.mlssoccer.com/players/sporting-kansas-city"
  },
  {
    :name => "Los Angeles Galaxy",
    :url => "http://www.mlssoccer.com/players/los-angeles-galaxy"
  },
  {
    :name => "New England Revolution",
    :url => "http://www.mlssoccer.com/players/new-england-revolution"
  },
  {
    :name => "New York Red Bulls",
    :url => "http://www.mlssoccer.com/players/new-york-red-bulls"
  },
  {
    :name => "Philadelphia Union",
    :url => "http://www.mlssoccer.com/players/philadelphia-union"
  },
  {
    :name => "Real Salt Lake",
    :url => "http://www.mlssoccer.com/players/real-salt-lake"
  },
  {
    :name => "San Jose Earthquakes",
    :url => "http://www.mlssoccer.com/players/san-jose-earthquakes"
  },
  {
    :name => "Seattle Sounders FC",
    :url => "http://www.mlssoccer.com/players/seattle-sounders-fc"
  },
  {
    :name => "Toronto FC",
    :url => "http://www.mlssoccer.com/players/toronto-fc"
  }
]

league = League.new
league.is_custom = false
league.sport = sport
league.short_name = "MLS"
league.name = "Major League Soccer"
league.male_uri = "http://rosterrunner.com"
league.female_uri = nil
league.save
teams.each do |t|
  team = Team.new 
  team.league = league
  team.is_custom = false
  team.gender = "male"
  team.name = t[:name]
  team.uri = t[:url]
  team.save
end
