require 'scrapi'

scraper = Scraper.define do
  array :players_odd
  process ".oddrow", :players_odd => Scraper.define {
    array :rows
    process "td", :rows => :text
    result :rows
  }
  array :players_even
  process ".evenrow", :players_even => Scraper.define {
    array :rows
    process "td", :rows => :text
    result :rows
  }
  result :players_odd, :players_even
end

uri = URI.parse("http://espn.go.com/nfl/team/roster/_/name/wsh/washington-redskins")

results = scraper.scrape(uri)
players = results.players_even << results.players_odd
players.each do |player|
  puts "Number: #{player[0]}"
  name = player[1].split 
  puts "First Name: #{name[0]}"
  puts "Last Name: #{name[1..(name.size-1)].join(" ")}"
  puts "Position: #{player[2]}"
end
