class Player < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :number, :position
    validates_presence_of :first_name, :number, :position, :team
    belongs_to :team
    default_scope order(:number)

    def name
      "#{first_name}#{" " if !last_name.nil? && last_name != ""}#{last_name}"
    end
end
