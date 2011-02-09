desc "Daily cron task for Heroku server"
task :cron => :environment do
  puts "Destroying custom teams older than 24 hours..."
  Rake::Task['roster:destroy:custom'].execute
end
