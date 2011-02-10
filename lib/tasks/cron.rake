desc "Daily cron task for Heroku server"
task :cron => :environment do
  puts "Destroying custom leagues older than 24 hours..."
  Rake::Task['team:destroy:custom'].execute
end
