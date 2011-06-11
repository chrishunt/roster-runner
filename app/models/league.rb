class League < ActiveRecord::Base
  attr_accessible :name
  has_many :teams, :order => :name, :dependent => :destroy
  belongs_to :sport
  validates_presence_of :name, :short_name, :sport

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
      scrape_espn(male_uri, 'male') if !male_uri.nil?
      scrape_espn(female_uri, 'female') if !female_uri.nil?
    elsif short_name == "MLS"
      teams.destroy_all
      scrape_mls  
    else
      puts "***** #{short_name} not a recognized league."
    end
  end

  def scrape_espn(uri, gender = "male")
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
    divisions = scraper.scrape(URI.parse(uri))
    divisions.each do |division|
      division.each do |t|
        team_name_link_id = nil
        team_uri_link_id = nil
        # Pick link IDs based on league type
        if short_name.upcase.include?('NCAA')
          team_name_link_id = 0
          team_uri_link_id = 3
        elsif short_name.upcase == 'NBA' && gender == 'female'
          team_name_link_id = 1
          team_uri_link_id = 4
        else
          team_name_link_id = 0
          team_uri_link_id = 5
        end
        espn_home = "http://espn.go.com"
        team_uri = "#{espn_home}#{t.links_href[team_uri_link_id]}"
        team_name = t.links_text[team_name_link_id].gsub("&amp;","&")
        team = Team.new 
        team.league_id = id
        team.is_custom = false
        team.gender = gender
        team.name = team_name
        team.uri = team_uri
        team.save
      end
    end
  end

  def scrape_mls
    teams = [
      { :name => "Chicago Fire",           :id => "16" },
      { :name => "Chivas USA",             :id => "1"  },
      { :name => "Colorado Rapids",        :id => "2"  },
      { :name => "Columbus Crew",          :id => "15" },
      { :name => "D.C. United",            :id => "14" },
      { :name => "FC Dallas",              :id => "3"  },
      { :name => "Houston Dynamo",         :id => "4"  },
      { :name => "Los Angeles Galaxy",     :id => "8"  },
      { :name => "New England Revolution", :id => "12" },
      { :name => "New York Red Bulls",     :id => "11" },
      { :name => "Philadelphia Union",     :id => "10" },
      { :name => "Portland Timbers",       :id => "52" },
      { :name => "Real Salt Lake",         :id => "7"  },
      { :name => "San Jose Earthquakes",   :id => "6"  },
      { :name => "Seattle Sounders FC",    :id => "5"  },
      { :name => "Sporting Kansas City",   :id => "13" },
      { :name => "Toronto FC",             :id => "9"  },
      { :name => "Vancouver Whitecaps FC", :id => "21" }
    ]
    teams.each do |t|
      team = Team.new 
      team.league_id = id
      team.is_custom = false
      team.gender = "male"
      team.name = t[:name]
      team.uri = t[:url]
      team.uri = "http://www.mlssoccer.com/players?field_player_club_nid=#{t[:id]}"
      team.save
    end
  end

  private

  def gendered_teams(gender)
    Team.where("league_id = ? AND gender LIKE ?", id, gender)
  end
end
