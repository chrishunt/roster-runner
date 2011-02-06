# Build MLS league
league = League.new
league.name = "MLS"
league.save

team = Team.new
team.league = league
team.name = "Chicago Fire"
team.uri = "http://www.mlssoccer.com/players/chicago-fire"
team.save
team = Team.new
team.league = league
team.name = "Chivas USA"
team.uri = "http://www.mlssoccer.com/players/chivas-usa"
team.save
team = Team.new
team.league = league
team.name = "Colorado Rapids"
team.uri = "http://www.mlssoccer.com/players/colorado-rapids"
team.save
team = Team.new
team.league = league
team.name = "Columbus Crew"
team.uri = "http://www.mlssoccer.com/players/columbus-crew"
team.save
team = Team.new
team.league = league
team.name = "D.C. United"
team.uri = "http://www.mlssoccer.com/players/dc-united"
team.save
team = Team.new
team.league = league
team.name = "FC Dallas"
team.uri = "http://www.mlssoccer.com/players/fc-dallas"
team.save
team = Team.new
team.league = league
team.name = "Houston Dynamo"
team.uri = "http://www.mlssoccer.com/players/houston-dynamo"
team.save
team = Team.new
team.league = league
team.name = "Sporting Kansas City"
team.uri = "http://www.mlssoccer.com/players/sporting-kansas-city"
team.save
team = Team.new
team.league = league
team.name = "Los Angeles Galaxy"
team.uri = "http://www.mlssoccer.com/players/los-angeles-galaxy"
team.save
team = Team.new
team.league = league
team.name = "New England Revolution"
team.uri = "http://www.mlssoccer.com/players/new-england-revolution"
team.save
team = Team.new
team.league = league
team.name = "New York Red Bulls"
team.uri = "http://www.mlssoccer.com/players/new-york-red-bulls"
team.save
team = Team.new
team.league = league
team.name = "Philadelphia Union"
team.uri = "http://www.mlssoccer.com/players/philadelphia-union"
team.save
team = Team.new
team.league = league
team.name = "Real Salt Lake"
team.uri = "http://www.mlssoccer.com/players/real-salt-lake"
team.save
team = Team.new
team.league = league
team.name = "San Jose Earthquakes"
team.uri = "http://www.mlssoccer.com/players/san-jose-earthquakes"
team.save
team = Team.new
team.league = league
team.name = "Seattle Sounders FC"
team.uri = "http://www.mlssoccer.com/players/seattle-sounders-fc"
team.save
team = Team.new
team.league = league
team.name = "Toronto FC"
team.uri = "http://www.mlssoccer.com/players/toronto-fc"
team.save

# Build rosters for MLS teams
league.teams.each do |team|
  team.scrape
end

# Build NFL league
league = League.new
league.name = "NFL"
league.save

team = Team.new
team.league = league
team.name = "New York Jets"
team.uri = "http://www.newyorkjets.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Cincinnati Bengals"
team.uri = "http://www.bengals.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Cleveland Browns"
team.uri = "http://www.clevelandbrowns.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Pittsburgh Steelers"
team.uri = "http://www.steelers.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Houston Texans"
team.uri = "http://www.houstontexans.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Tennessee Titans"
team.uri = "http://www.titansonline.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Denver Broncos"
team.uri = "http://www.denverbroncos.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Kansas City Chiefs"
team.uri = "http://www.kcchiefs.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Oakland Raiders"
team.uri = "http://www.raiders.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "San Diego Chargers"
team.uri = "http://www.chargers.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Detriot Lions"
team.uri = "http://www.detroitlions.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Green Bay Packers"
team.uri = "http://www.packers.com/team/players.html"
team.save
team = Team.new
team.league = league
team.name = "Minnesota Vikings"
team.uri = "http://www.vikings.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Carolina Panthers"
team.uri = "http://www.panthers.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "New Orleans Saints"
team.uri = "http://www.neworleanssaints.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Tampa Bay Buccaneers"
team.uri = "http://www.buccaneers.com/team-and-stats/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Arizona Cardinals"
team.uri = "http://www.azcardinals.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "St. Louis Rams"
team.uri = "http://www.stlouisrams.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "San Francisco 49ers"
team.uri = "http://www.49ers.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Seattle Seahawks"
team.uri = "http://www.seahawks.com/team/roster.html"
team.save
team = Team.new
team.league = league
team.name = "Buffalo Bills"
team.uri = "http://www.buffalobills.com/team/roster.html"
team.save

# Build rosters for NFL teams
league.teams.each do |team|
  team.scrape
end

# Load from CSV
#CSV_DIR = "csv"
#
## Create leagues
#Dir.foreach("#{CSV_DIR}") do |file|
#  next if file == "." || file == ".."
#  league = League.new
#  league.name = file
#  league.save
#end
#
## Load teams for each league from csv
#League.all.each do |league|
#  Dir.foreach("#{CSV_DIR}/#{league.name.upcase}") do |file|
#    next if file == "." || file == ".."
#    # Create this team
#    team_name = file.split('.')[0]
#    team = Team.new
#    team.name = team_name
#    team.league = league
#    team.save
#    # Load player list from csv
#    players = CsvMapper.import("#{CSV_DIR}/#{league.name.upcase}/#{file}") do
#      [number, position, first_name, last_name]
#    end
#    # Create each player on this team
#    players.each do |p|
#      player = Player.new
#      player.team = team
#      player.number = p[:number]
#      player.position = p[:position]
#      player.first_name = p[:first_name]
#      player.last_name = p[:last_name]
#      player.save
#    end
#  end
#end
