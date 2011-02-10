class League < ActiveRecord::Base
  attr_accessible :name
  has_many :teams, :order => :name, :dependent => :destroy
  belongs_to :sport
  validates_presence_of :name, :short_name, :sport, :uri

  def has_females?
    female_teams.size > 0 ? true : false
  end

  def female_teams
    gendered_teams("female")
  end

  def male_teams
    gendered_teams("male")
  end

  def scrape
    if short_name == "NFL" ||
       short_name == "NBA" ||
       short_name == "NCAA FB" ||
       short_name == "NCAA BB" ||
       short_name == "MLB"
      teams.destroy_all
      scrape_espn
    else
      puts "#{shot_name} not a recognized league."
    end
  end

  def scrape_espn
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
    divisions = scraper.scrape(URI.parse(uri))
    divisions.each do |division|
      division.each do |t|
        espn_home = "http://espn.go.com"
        roster_link_id = short_name.upcase.include?("NCAA") ? 3 : 5
        team_uri = "#{espn_home}#{t.links[roster_link_id]}"
        team_name = t.name
        team = Team.new 
        team.league_id = id
        team.is_custom = false
        team.gender = "male"
        team.name = team_name
        team.uri = team_uri
        team.save
      end
    end
  end

  private

  def gendered_teams(gender)
    Team.where("league_id = ? AND gender LIKE ?", id, gender)
  end
end
