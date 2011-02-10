class League < ActiveRecord::Base
    attr_accessible :name
    has_many :teams, :order => :name, :dependent => :destroy
    belongs_to :sport
    validates_presence_of :name, :short_name, :sport

    def has_females?
      Team.where("league_id = ? AND gender LIKE ?", id, "female").size > 0 ? true : false
    end
end
