class League < ActiveRecord::Base
    attr_accessible :name
    has_many :teams
    validates_presence_of :name
end
