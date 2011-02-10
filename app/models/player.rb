class Player < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :number, :position
    validates_presence_of :first_name, :last_name, :number, :position, :team
    belongs_to :team

    def name
      "#{first_name}#{" " if !last_name.nil? && last_name != ""}#{last_name}"
    end

    def position_expanded
      ret = ""
      sport = team.league.sport.name.downcase
      positions = position.split("/")
      i = 1
      positions.each do |p|
        case sport
        when "baseball"
          case p
          when "OF"
            ret << "outfielder"
          when "1B"
            ret << "first baseman"
          when "2B"
            ret << "second baseman"
          when "3B"
            ret << "third baseman"
          when "SP"
            ret << "setup pitcher"
          when "SS"
            ret << "shortstop"
          when "C"
            ret << "catcher"
          when "CF"
            ret << "center fielder"
          when "LF"
            ret << "left fielder"
          when "RP"
            ret << "relief pitcher"
          when "RF"
            ret << "right fielder"
          else
            ret << p 
          end
        when "basketball"
          case p
          when "SG"
            ret << "shooting guard"
          when "PG"
            ret << "point guard"
          when "PF"
            ret << "point forward"
          when "C"
            ret << "center"
          when "F"
            ret << "forward"
          when "SF"
            ret << "small forward"
          when "G"
            ret << "guard"
          else
            ret << p
          end
        when "soccer"
          case p
          when "M"
            ret << "midfielder"
          when "D"
            ret << "defender"
          when "GK"
            ret << "goalkeeper"
          when "G"
            ret << "goalkeeper"
          when "F"
            ret << "forward"
          else
            ret << p
          end
        when "football"
          case p
          when "QB"
            ret << "quarterback"
          when "RB"
            ret << "running back"
          when "FB"
            ret << "fullback"
          when "DB"
            ret << "defensive back"
          when "WR"
            ret << "wide receiver"
          when "TE"
            ret << "tight end"
          when "C"
            ret << "center"
          when "G"
            ret << "guard"
          when "OT"
            ret << "offensive tackle"
          when "DE"
            ret << "defensive end"
          when "DT"
            ret << "defensive tackle"
          when "LB"
            ret << "linebacker"
          when "CB"
            ret << "cornerback"
          when "S"
            ret << "safety"
          when "PK"
            ret << "placekicker"
          when "P"
            ret << "punter"
          when "K"
            ret << "kicker"
          when "DL"
            ret << "defensive line"
          when "OL"
            ret << "offensive line"
          when "NT"
            ret << "nose tackle"
          when "LS"
            ret << "long snapper"
          else
            ret << p
          end
        else
          ret << p
        end
        if positions.size > 1 && i < positions.size
          ret << "/"
        end
        i = i + 1
      end
      return ret
    end
end
