require 'scrapi'

scraper = Scraper.define do
  array :players_even
  process ".loop-even", :players_even => Scraper.define {
    process ".col-jersey", :number => :text
    process ".player-card-tooltip>span", :name => :text
    process ".col-position", :position => :text
    result :number, :name, :position
  }
  array :players_odd
  process ".loop-odd", :players_odd => Scraper.define {
    process ".col-jersey", :number => :text
    process ".player-card-tooltip>span", :name => :text
    process ".col-position", :position => :text
    result :number, :name, :position
  }
  result :players_even, :players_odd
end

uri = URI.parse("http://www.packers.com/team/players.html")

results = scraper.scrape(uri)

puts "********** EVEN COUNT: #{results.players_even.size} **********"
results.players_even.each do |player|
  next if player[:number].nil? || player[:name].nil? || player[:position].nil?
  puts "Number: #{player[:number]}"
  puts "Name: #{player[:name]}"
  puts "Position: #{player[:position]}"
end
puts "********** ODD COUNT: #{results.players_odd.size} **********"
results.players_odd.each do |player|
  next if player[:number].nil? || player[:name].nil? || player[:position].nil?
  puts "Number: #{player[:number]}"
  puts "Name: #{player[:name]}"
  puts "Position: #{player[:position]}"
end
