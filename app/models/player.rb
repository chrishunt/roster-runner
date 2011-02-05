class Player < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :number, :position
    validates_presence_of :first_name, :number, :position
    belongs_to :team
end
