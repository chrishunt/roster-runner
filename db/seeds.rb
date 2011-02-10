def build_league(short_name, name, sport, teams)
  league = League.new
  league.is_custom = false
  league.sport = sport
  league.short_name = short_name
  league.name = name
  league.save
  teams.each do |t|
    name = t[:name]
    uri = t[:url]
    gender = t[:gender].nil? ? "male" : t[:gender]
    team = Team.new
    team.league = league
    team.is_custom = false
    team.gender = gender
    team.name = name
    team.uri = uri
    team.save
  end
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
teams = [
  {
    :name => "Baltimore Orioles",
    :url => "http://espn.go.com/mlb/team/roster/_/name/bal/baltimore-orioles"
  },
  {
    :name => "Boston Red Sox",
    :url => "http://espn.go.com/mlb/team/roster/_/name/bos/boston-red-sox"
  },
  {
    :name => "New York Yankees",
    :url => "http://espn.go.com/mlb/team/roster/_/name/nyy/new-york-yankees"
  },
  {
    :name => "Tampa Bay Rays",
    :url => "http://espn.go.com/mlb/team/roster/_/name/tb/tampa-bay-rays"
  }
]
build_league("MLB", "Major League Baseball", sport, teams)

########################################
# BASKETBALL SPORT
########################################
sport = Sport.new
sport.name = "Basketball"
sport.save

################
# NCAA BB LEAGUE
################
teams = [
  {
    :name => "Washington Huskies",
    :url => "http://espn.go.com/mens-college-basketball/team/roster/_/id/264/washington-huskies"
  }
]
build_league("NCAA BB", "NCAA Basketball", sport, teams)

################
# NBA LEAGUE
################
teams = [
  {
    :name => "Boston Celtics",
    :url => "http://espn.go.com/nba/team/roster/_/name/bos/boston-celtics"
  },
  {
    :name => "New Jersey Nets",
    :url => "http://espn.go.com/nba/team/roster/_/name/nj/new-jersey-nets"
  },
  {
    :name => "New York Knicks",
    :url => "http://espn.go.com/nba/team/roster/_/name/ny/new-york-knicks"
  },
  {
    :name => "Philadelphia 76ers",
    :url => "http://espn.go.com/nba/team/roster/_/name/phi/philadelphia-76ers"
  }
]
build_league("NBA", "National Basketball Association", sport, teams)

########################################
# FOOTBALL SPORT
########################################
sport = Sport.new
sport.name = "Football"
sport.save

################
# NCAA FB LEAGUE
################
teams = [
  {
    :name => "Boston College Eagles",
    :url => "http://espn.go.com/college-football/team/roster/_/id/103/boston-college-eagles"
  },
  {
    :name => "Washington Huskies",
    :url => "http://espn.go.com/college-football/team/roster/_/id/264/washington-huskies"
  }
]
build_league("NCAA FB", "NCAA Football", sport, teams)

################
# NFL LEAGUE
################
teams = [
  {
    :name => "Jacksonville Jaguars",
    :url => "http://espn.go.com/nfl/team/roster/_/name/jac/jacksonville-jaguars"
  },
  {
    :name => "Indianapolis Colts",
    :url => "http://espn.go.com/nfl/team/roster/_/name/ind/indianapolis-colts"
  },
  {
    :name => "Atlanta Falcons",
    :url => "http://espn.go.com/nfl/team/roster/_/name/atl/atlanta-falcons"
  },
  {
    :name => "Baltimore Ravens",
    :url => "http://espn.go.com/nfl/team/roster/_/name/bal/baltimore-ravens"
  },
  {
    :name => "Chicago Bears",
    :url => "http://espn.go.com/nfl/team/roster/_/name/chi/chicago-bears"
  },
  {
    :name => "Dallas Cowboys",
    :url => "http://espn.go.com/nfl/team/roster/_/name/dal/dallas-cowboys"
  },
  {
    :name => "New York Jets",
    :url => "http://espn.go.com/nfl/team/roster/_/name/nyj/new-york-jets"
  },
  {
    :name => "Cincinnati Bengals",
    :url => "http://espn.go.com/nfl/team/roster/_/name/cin/cincinnati-bengals"
  },
  {
    :name => "Cleveland Browns",
    :url => "http://espn.go.com/nfl/team/roster/_/name/cle/cleveland-browns"
  },
  {
    :name => "Pittsburgh Steelers",
    :url => "http://espn.go.com/nfl/team/roster/_/name/pit/pittsburgh-steelers"
  },
  {
    :name => "Houston Texans",
    :url => "http://espn.go.com/nfl/team/roster/_/name/hou/houston-texans"
  },
  {
    :name => "Tennessee Titans",
    :url => "http://espn.go.com/nfl/team/roster/_/name/ten/tennessee-titans"
  },
  {
    :name => "Denver Broncos",
    :url => "http://espn.go.com/nfl/team/roster/_/name/den/denver-broncos"
  },
  {
    :name => "Kansas City Chiefs",
    :url => "http://espn.go.com/nfl/team/roster/_/name/kc/kansas-city-chiefs"
  },
  {
    :name => "Oakland Raiders",
    :url => "http://espn.go.com/nfl/team/roster/_/name/oak/oakland-raiders"
  },
  {
    :name => "San Diego Chargers",
    :url => "http://espn.go.com/nfl/team/roster/_/name/sd/san-diego-chargers"
  },
  {
    :name => "Detriot Lions",
    :url => "http://espn.go.com/nfl/team/roster/_/name/det/detroit-lions"
  },
  {
    :name => "Green Bay Packers",
    :url => "http://espn.go.com/nfl/team/roster/_/name/gb/green-bay-packers"
  },
  {
    :name => "Minnesota Vikings",
    :url => "http://espn.go.com/nfl/team/roster/_/name/min/minnesota-vikings"
  },
  {
    :name => "Carolina Panthers",
    :url => "http://espn.go.com/nfl/team/roster/_/name/car/carolina-panthers"
  },
  {
    :name => "New Orleans Saints",
    :url => "http://espn.go.com/nfl/team/roster/_/name/no/new-orleans-saints"
  },
  {
    :name => "Tampa Bay Buccaneers",
    :url => "http://espn.go.com/nfl/team/roster/_/name/tb/tampa-bay-buccaneers"
  },
  {
    :name => "Arizona Cardinals",
    :url => "http://espn.go.com/nfl/team/roster/_/name/ari/arizona-cardinals"
  },
  {
    :name => "St. Louis Rams",
    :url => "http://espn.go.com/nfl/team/roster/_/name/stl/st-louis-rams"
  },
  {
    :name => "San Francisco 49ers",
    :url => "http://espn.go.com/nfl/team/roster/_/name/sf/san-francisco-49ers"
  },
  {
    :name => "Seattle Seahawks",
    :url => "http://espn.go.com/nfl/team/roster/_/name/sea/seattle-seahawks"
  },
  {
    :name => "Buffalo Bills",
    :url => "http://espn.go.com/nfl/team/roster/_/name/buf/buffalo-bills"
  },
  {
    :name => "New York Giants",
    :url => "http://espn.go.com/nfl/team/roster/_/name/nyg/new-york-giants"
  },
  {
    :name => "Miami Dolphins",
    :url => "http://espn.go.com/nfl/team/roster/_/name/mia/miami-dolphins"
  },
  {
    :name => "Philadelphia Eagles",
    :url => "http://espn.go.com/nfl/team/roster/_/name/phi/philadelphia-eagles"
  },
  {
    :name => "New England Patriots",
    :url => "http://espn.go.com/nfl/team/roster/_/name/ne/new-england-patriots"
  },
  {
    :name => "Washington Redskins",
    :url => "http://espn.go.com/nfl/team/roster/_/name/wsh/washington-redskins"
  }
]
build_league("NFL", "National Football League", sport, teams)


########################################
# SOCCER SPORT
########################################
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
build_league("MLS", "Major League Soccer", sport, teams)

