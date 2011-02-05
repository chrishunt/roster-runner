class Team < ActiveRecord::Base
  attr_accessible :name, :roster
  validates_presence_of :name, :roster
end
