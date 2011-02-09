# Create CUSTOM sport for custom rosters
sport = Sport.new
sport.name = "Custom"
sport.save

# Create Basball sport
sport = Sport.new
sport.name = "Baseball"
sport.save

# Build MLB league
league = League.new
league.is_custom = false
league.sport = sport
league.short_name = "MLB"
league.name = "Major League Baseball"
league.save

team = Team.new
team.is_custom = false
team.league = league
team.name = "Baltimore Orioles"
team.uri = "http://espn.go.com/mlb/team/roster/_/name/bal/baltimore-orioles"
team.save

# Create Soccer sport
sport = Sport.new
sport.name = "Soccer"
sport.save

# Build MLS league
league = League.new
league.is_custom = false
league.sport = sport
league.short_name = "MLS"
league.name = "Major League Soccer"
league.save

team = Team.new
team.is_custom = false
team.league = league
team.name = "Chicago Fire"
team.uri = "http://www.mlssoccer.com/players/chicago-fire"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Chivas USA"
team.uri = "http://www.mlssoccer.com/players/chivas-usa"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Colorado Rapids"
team.uri = "http://www.mlssoccer.com/players/colorado-rapids"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Columbus Crew"
team.uri = "http://www.mlssoccer.com/players/columbus-crew"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "D.C. United"
team.uri = "http://www.mlssoccer.com/players/dc-united"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "FC Dallas"
team.uri = "http://www.mlssoccer.com/players/fc-dallas"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Houston Dynamo"
team.uri = "http://www.mlssoccer.com/players/houston-dynamo"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Sporting Kansas City"
team.uri = "http://www.mlssoccer.com/players/sporting-kansas-city"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Los Angeles Galaxy"
team.uri = "http://www.mlssoccer.com/players/los-angeles-galaxy"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "New England Revolution"
team.uri = "http://www.mlssoccer.com/players/new-england-revolution"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "New York Red Bulls"
team.uri = "http://www.mlssoccer.com/players/new-york-red-bulls"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Philadelphia Union"
team.uri = "http://www.mlssoccer.com/players/philadelphia-union"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Real Salt Lake"
team.uri = "http://www.mlssoccer.com/players/real-salt-lake"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "San Jose Earthquakes"
team.uri = "http://www.mlssoccer.com/players/san-jose-earthquakes"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Seattle Sounders FC"
team.uri = "http://www.mlssoccer.com/players/seattle-sounders-fc"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Toronto FC"
team.uri = "http://www.mlssoccer.com/players/toronto-fc"
team.save

# Create Basketball sport
sport = Sport.new
sport.name = "Basketball"
sport.save

# Build NBA league
league = League.new
league.is_custom = false
league.sport = sport
league.short_name = "NBA"
league.name = "National Basketball Association"
league.save

team = Team.new
team.is_custom = false
team.league = league
team.name = "Boston Celtics"
team.uri = "http://espn.go.com/nba/team/roster/_/name/bos/boston-celtics"
team.save

# Create Football sport
sport = Sport.new
sport.name = "Football"
sport.save

# Build NFL league
league = League.new
league.is_custom = false
league.sport = sport
league.short_name = "NFL"
league.name = "National Football League"
league.save

team = Team.new
team.is_custom = false
team.league = league
team.name = "Jacksonville Jaguars"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/jac/jacksonville-jaguars"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Indianapolis Colts"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/ind/indianapolis-colts"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Atlanta Falcons"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/atl/atlanta-falcons"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Baltimore Ravens"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/bal/baltimore-ravens"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Chicago Bears"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/chi/chicago-bears"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Dallas Cowboys"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/dal/dallas-cowboys"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "New York Jets"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/nyj/new-york-jets"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Cincinnati Bengals"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/cin/cincinnati-bengals"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Cleveland Browns"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/cle/cleveland-browns"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Pittsburgh Steelers"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/pit/pittsburgh-steelers"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Houston Texans"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/hou/houston-texans"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Tennessee Titans"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/ten/tennessee-titans"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Denver Broncos"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/den/denver-broncos"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Kansas City Chiefs"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/kc/kansas-city-chiefs"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Oakland Raiders"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/oak/oakland-raiders"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "San Diego Chargers"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/sd/san-diego-chargers"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Detriot Lions"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/det/detroit-lions"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Green Bay Packers"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/gb/green-bay-packers"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Minnesota Vikings"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/min/minnesota-vikings"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Carolina Panthers"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/car/carolina-panthers"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "New Orleans Saints"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/no/new-orleans-saints"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Tampa Bay Buccaneers"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/tb/tampa-bay-buccaneers"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Arizona Cardinals"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/ari/arizona-cardinals"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "St. Louis Rams"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/stl/st-louis-rams"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "San Francisco 49ers"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/sf/san-francisco-49ers"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Seattle Seahawks"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/sea/seattle-seahawks"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Buffalo Bills"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/buf/buffalo-bills"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "New York Giants"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/nyg/new-york-giants"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Miami Dolphins"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/mia/miami-dolphins"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Philadelphia Eagles"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/phi/philadelphia-eagles"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "New England Patriots"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/ne/new-england-patriots"
team.save
team = Team.new
team.is_custom = false
team.league = league
team.name = "Washington Redskins"
team.uri = "http://espn.go.com/nfl/team/roster/_/name/wsh/washington-redskins"
team.save

