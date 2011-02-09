class Player < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :number, :position
    validates_presence_of :first_name, :last_name, :number, :position, :team
    belongs_to :team

    def name
      "#{first_name}#{" " if !last_name.nil? && last_name != ""}#{last_name}"
    end
end
