namespace :team do
  namespace :scrape do
    desc "Scrape all teams for non-custom leagues"
    task :all => :environment do
      leagues = League.where("is_custom = ?", false)
      puts "#{leagues.size} leagues are going to be updated..."
      i = 1
      leagues.each do |league|
        league.scrape
        league = League.find(league.id)
        team_count = league.teams.size
        puts "(#{i}/#{leagues.size}) #{league.short_name}: #{league.name} (#{team_count} teams)"
        puts "***** WARNING!! EMPTY LEAGUE! (ID: #{league.id})" if team_count == 0
        i = i + 1
      end
    end

    desc "Scrape basketball teams for non-custom leagues"
    task :basketball => :environment do
      scrape_league("Basketball")
    end

    desc "Scrape football teams for non-custom leagues"
    task :football => :environment do
      scrape_league("Football")
    end

    desc "Scrape baseball teams for non-custom leagues"
    task :baseball => :environment do
      scrape_league("Baseball")
    end

    desc "Scrape soccer teams for non-custom leagues"
    task :soccer => :environment do
      scrape_league("Soccer")
    end

    def scrape_league(sport)
      puts "Updating all #{sport} leagues..."
      leagues = Sport.where("name LIKE ?", sport).first.leagues
      leagues.each do |league|
        if !league.is_custom
          league.scrape
          league = League.find(league.id)
          team_count = league.teams.size
          puts "#{league.short_name}: #{league.name} (#{team_count} teams)"
          puts "***** WARNING!! EMPTY LEAGUE! (ID: #{league.id})" if team_count == 0
        end
      end
    end
  end

  namespace :destroy do
    desc "Destroy custom leagues older than 24 hours"
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
