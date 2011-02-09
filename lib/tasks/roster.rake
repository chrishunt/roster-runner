namespace :roster do
  desc "Scrape rosters for all non-custom teams"
  task :scrape => :environment do
    teams = Team.where("is_custom = ?", false)
    puts "#{teams.size} teams are going to be updated..."
    i = 1
    teams.each do |team|
      team.scrape_roster
      team = Team.find(team.id)
      puts "(#{i}/#{teams.size}) #{team.league.short_name}: #{team.name} (#{team.players.size} players)"
      i = i + 1
    end
  end

  namespace :destroy do
    desc "Destroy custom teams older than 24 hours"
    task :custom => :environment do
      leagues = League.where("is_custom = ?", true)
      puts "#{leagues.size} leagues are going to be destroyed..."
      i = 1
      leagues.each do |league|
        league.destroy
        puts "(#{i}/#{leagues.size})"
        i = i + 1
      end
    end
  end
end
