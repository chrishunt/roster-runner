class League < ActiveRecord::Base
    attr_accessible :name
    has_many :teams, :order => :name
    validates_presence_of :name
    default_scope order('name')
end
