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

one = [["1","2","3"],["4","5","6"]]
two = [["7","8","9"],["10","11","12"]]
together = one + two
puts together.inspect
