class League < ActiveRecord::Base
    attr_accessible :name
    has_many :teams, :order => :name, :dependent => :destroy
    validates_presence_of :name, :short_name
end
