CSV_DIR = "csv"

# Create leagues
league = League.new
league.name = "MLS"
league.save

# Load teams for each league from csv
League.all.each do |league|
  Dir.foreach("#{CSV_DIR}/#{league.name.upcase}") do |file|
    next if file == "." || file == ".."
    # Create this team
    team_name = file.split('.')[0]
    team = Team.new
    team.name = team_name
    team.league = league
    team.save
    # Load player list from csv
    players = CsvMapper.import("#{CSV_DIR}/#{league.name.upcase}/#{file}") do
      [number, position, first_name, last_name]
    end
    # Create each player on this team
    players.each do |p|
      player = Player.new
      player.team = team
      player.number = p[:number]
      player.position = p[:position]
      player.first_name = p[:first_name]
      player.last_name = p[:last_name]
      player.save
    end
  end
end
