namespace :destroy do
  namespace :custom do
    desc "Destroy all custom Leagues, Teams, and Players"
    task :all => :environment do
      leagues = League.where("is_custom = ?", true)
      i = 1
      leagues.each do |league|
        league.destroy
        puts "(#{i}/#{leagues.size}) #{league.short_name}: #{league.name}"
        i = i + 1
      end
    end

    desc "Destroy old (24 hours) custom Leagues, Teams, and Players"
    task :old => :environment do
      yesterday = Time.new - 1.day
      leagues = League.where("is_custom = ? AND created_at < ?", true, yesterday)
      i = 1
      leagues.each do |league|
        league.destroy
        puts "(#{i}/#{leagues.size}) #{league.short_name}: #{league.name}"
        i = i + 1
      end
    end
  end
end
