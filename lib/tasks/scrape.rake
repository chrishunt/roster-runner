namespace :scrape do
  desc "Scrape all teams and players for every sport"
  task :all => [:environment, 'teams:all', 'players:all']

  desc "Scrape all teams and players for MLS league"
  task :mls => [:environment, 'teams:mls', 'players:mls']

  desc "Scrape all teams and players for MLB league"
  task :mlb => [:environment, 'teams:mlb', 'players:mlb']

  desc "Scrape all teams and players for NCAA FB league"
  task :ncaa_fb => [:environment, 'teams:ncaa_fb', 'players:ncaa_fb']

  desc "Scrape all teams and players for NFL league"
  task :nfl => [:environment, 'teams:nfl', 'players:nfl']

  namespace :teams do
    desc "Scrape all teams for every sport"
    task :all => :environment do
      i = 1
      leagues = League.where("is_custom = ?", false)
      leagues.each do |league|
        league.scrape
        teams_size = Team.where("league_id = ?", league.id).size
        puts "********** NO TEAMS IN SCRAPE **********" if teams_size == 0
        puts "(#{i}/#{leagues.size}) [#{league.id}] #{league.short_name}: #{league.name} (#{teams_size} teams)"
        puts "********** NO TEAMS IN SCRAPE **********" if teams_size == 0
        i = i + 1
      end
    end
    desc "Scrape all teams for MLS league"
    task :mls => :environment do scrape_league_teams("MLS") end
    desc "Scrape all teams for MLB league"
    task :mlb => :environment do scrape_league_teams("MLB") end
    desc "Scrape all teams for NCAA FB league"
    task :ncaa_fb => :environment do scrape_league_teams("NCAA_FB") end
    desc "Scrape all teams for NFL league"
    task :nfl => :environment do scrape_league_teams("NFL") end
  end

  namespace :players do
    desc "Scrape all players for every sport"
    task :all => :environment do
      i = 1
      teams = Team.where("is_custom = ?", false)
      teams.each do |team|
        team.scrape
        players_size = Player.where("team_id = ?", team.id).size
        puts "********** NO PLAYERS IN SCRAPE **********" if players_size == 0
        puts "(#{i}/#{teams.size}) [#{team.id}] #{team.name} (#{players_size} players)"
        puts "********** NO PLAYERS IN SCRAPE **********" if players_size == 0
        i = i + 1
      end
    end
    desc "Scrape all players for MLS league"
    task :mls => :environment do scrape_league_players("MLS") end
    desc "Scrape all players for MLB league"
    task :mlb => :environment do scrape_league_players("MLB") end
    desc "Scrape all players for NCAA FB league"
    task :ncaa_fb => :environment do scrape_league_players("NCAA FB") end
    desc "Scrape all players for NFL league"
    task :nfl => :environment do scrape_league_players("NFL") end
  end
end

def scrape_league_teams(league_name)
  league = League.where("upper(short_name) LIKE ?", league_name).first
  league.scrape
  teams_size = Team.where("league_id = ?", league.id).size
  puts "********** NO TEAMS IN SCRAPE **********" if teams_size == 0
  puts "#{league.short_name}: #{league.name} (#{teams_size} teams)"
  puts "********** NO TEAMS IN SCRAPE **********" if teams_size == 0
end

def scrape_league_players(league_name)
  i = 1
  league = League.where("upper(short_name) LIKE ?", league_name).first
  teams = Team.where("is_custom = ? AND league_id = ?", false, league)
  teams.each do |team|
    team.scrape
    players_size = Player.where("team_id = ?", team.id).size
    puts "********** NO PLAYERS IN SCRAPE **********" if players_size == 0
    puts "(#{i}/#{teams.size}) [#{team.id}] #{team.name} (#{players_size} players)"
    puts "********** NO PLAYERS IN SCRAPE **********" if players_size == 0
    i = i + 1
  end
end
