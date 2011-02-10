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

    private

    def gendered_teams(gender)
      Team.where("league_id = ? AND gender LIKE ?", id, gender)
    end
end
