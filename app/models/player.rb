class Player < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :number, :position
    validates_presence_of :first_name, :last_name, :number, :position, :team
    belongs_to :team

    def name
      "#{first_name}#{" " if !last_name.nil? && last_name != ""}#{last_name}"
    end

    def position_expanded
      sport = team.league.sport.name.downcase
      case sport
      when "football"
        case position.upcase
        when "QB"
          "quarterback"
        when "RB"
          "running back"
        when "FB"
          "fullback"
        when "DB"
          "defensive back"
        when "WR"
          "wide receiver"
        when "TE"
          "tight end"
        when "C"
          "center"
        when "G"
          "guard"
        when "OT"
          "offensive tackle"
        when "DE"
          "defensive end"
        when "DT"
          "defensive tackle"
        when "LB"
          "linebacker"
        when "CB"
          "cornerback"
        when "S"
          "safety"
        when "PK"
          "placekicker"
        when "P"
          "punter"
        when "K"
          "kicker"
        when "DL"
          "defensive line"
        when "OL"
          "offensive line"
        when "NT"
          "nose tackle"
        when "LS"
          "long snapper"
        else
          position
        end
      else
        position
      end
    end
end
