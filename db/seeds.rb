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
build_league(sport,
             "MLS", 
             "Major League Soccer",
             "http://rosterrunner.com")
