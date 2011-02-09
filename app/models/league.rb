class League < ActiveRecord::Base
    attr_accessible :name
    has_many :teams, :order => :name, :dependent => :destroy
    belongs_to :sport
    validates_presence_of :name, :short_name, :sport
end
