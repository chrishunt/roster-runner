require 'scrapi'

scraper = Scraper.define do
  array :divisions
  process ".mod-container.mod-open-list.mod-teams-list-medium.mod-no-footer", :divisions => Scraper.define {
    array :teams
    process "li", :teams => Scraper.define {
      process "h5 a", :name => :text
      array :links
      process 'a', :links => "@href"
      result :name, :links
    }
    result :teams
  }
  result :divisions
end

uri = URI.parse("http://espn.go.com/mens-college-basketball/teams")

divisions = scraper.scrape(uri)
divisions.each do |division|
  puts "************************"
  division.each do |team|
    puts "------------"
    puts "Team Name: #{team.name}"
    espn_home = 'http://espn.go.com'
    puts "Roster URL: #{espn_home}#{team.links[5]}"
    i = 0
    team.links.each do |link|
      puts "[#{i}] #{link}"
      i = i+1
    end
    puts "------------"
  end
  puts "************************"
end
