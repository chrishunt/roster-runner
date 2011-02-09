namespace :roster do
  namespace :scrape do
    desc "Scrape all rosters for non-custom teams"
    task :all => :environment do
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

    desc "Scrape basketball rosters for non-custom teams"
    task :basketball => :environment do
      scrape_sport("basketball")
    end

    desc "Scrape football rosters for non-custom teams"
    task :football => :environment do
      scrape_sport("football")
    end

    desc "Scrape baseball rosters for non-custom teams"
    task :baseball => :environment do
      scrape_sport("baseball")
    end

    desc "Scrape soccer rosters for non-custom teams"
    task :soccer => :environment do
      scrape_sport("soccer")
    end

    def scrape_sport(sport)
      puts "Updating all #{sport} teams..."
      leagues = Sport.where("name LIKE ?", sport).first.leagues
      leagues.each do |league|
        league.teams.each do |team|
          if !team.is_custom
            team.scrape_roster 
            team = Team.find(team.id)
            puts "#{team.league.short_name}: #{team.name} (#{team.players.size} players)"
          end
        end
      end
    end

  end

  namespace :destroy do
    desc "Destroy custom teams older than 24 hours"
    task :custom => :environment do
      yesterday = Time.new - 1.day
      leagues = League.where("is_custom = ? AND created_at < ?", true, yesterday)
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
