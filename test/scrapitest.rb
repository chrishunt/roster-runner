require 'scrapi'

mls_scraper = Scraper.define do
  process ".mpl-player.active>a", :page_name => :text
  result :page_name
end

uri = URI.parse "http://www.mlssoccer.com/players/chicago-fire"
puts mls_scraper.scrape uri
