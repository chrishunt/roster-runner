desc "Daily cron task for Heroku server"
task :cron => :environment do
  Rake::Task['destroy:custom:old'].execute
end
