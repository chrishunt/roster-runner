require 'scrapi'

scraper = Scraper.define do
  array :divisions
  process ".mod-container.mod-open-list.mod-teams-list-medium.mod-no-footer", :divisions => Scraper.define {
    array :teams
    process "li", :teams => Scraper.define {
      array :links_href
      process 'a', :links_href => "@href"
      array :links_text
      process 'a', :links_text => :text
      result :links_text, :links_href
    }
    result :teams
  }
  result :divisions
end

uri = URI.parse("http://espn.go.com/mens-college-basketball/teams");

divisions = scraper.scrape(uri)
divisions.each do |division|
  puts "************************"
  division.each do |team|
    puts "------------"
    espn_home = 'http://espn.go.com'
    i = 0
    team.links_href.each do |href|
      puts "[#{i}] #{team.links_text[i]}: #{href}"
      i = i+1
    end
    puts "------------"
  end
  puts "************************"
end
