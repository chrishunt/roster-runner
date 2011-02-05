CSV_DIR = "csv"
Dir.foreach(CSV_DIR) do |file|
  next if file == "." || file == ".."
  # Create this team
  team_name = file.split('.')[0]
  team = Team.new
  team.name = team_name
  team.save
  # Load player list from csv
  players = CsvMapper.import("#{CSV_DIR}/#{file}") do
    [number, position, last_name, first_name]
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
