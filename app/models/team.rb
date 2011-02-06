class Team < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name, :league, :uri
  has_many :players, :order => "number"
  belongs_to :league

  def filename
    split = name.split
    file = "#{league.name.downcase}_#{split[0].downcase}"
    split[1..(split.size)].each do |s|
      file << "_#{s.downcase}"
    end
    file << ".txt"
  end

  def prefix
    name.split[0][0..2].strip.downcase
  end

  def code(prefix = prefix)
    ret = ""
    i = 0
    while(i < players.size)
      group = []
      group << players[i]
      # gather all the players the same number
      while ((i+1 < players.size) && (players[i+1].number == players[i].number))
        i = i+1
        group << players[i]
      end
      i = i + 1

      # save prefix
      number = group[0].number
      sea1 = "#{prefix}#{number}" << "\t"
      sea1p = "#{prefix}#{number}p" << "\t"
      sea1tp = "#{prefix}#{number}tp" << "\t"
      sea1tpn = "#{prefix}#{number}tpn" << "\t"
      sea1n = "#{prefix}#{number}n" << "\t" 
      sea1tn = "#{prefix}#{number}tn" << "\t"
      sea1pn = "#{prefix}#{number}pn" << "\t"
      sea1s = "#{prefix}#{number}s" << "\t"

      if group.size == 1
        # save expansion for single player
        p = group[0] 
        sea1 << "#{p.name}" 
        sea1p << "#{p.position} #{p.name}"
        sea1tp << "#{p.team.name} #{p.position} #{p.name}"
        sea1tpn << "#{p.team.name} #{p.position} #{p.name} (#{p.number})"
        sea1n << "#{p.name} (#{p.number})"
        sea1tn << "#{p.team.name} #{p.name} (#{p.number})"
        sea1pn << "#{p.position} #{p.name} (#{p.number})"
        sea1s << "[#{p.last_name},#{p.first_name}],"
      else
        group.each do |p|
          # save expansion for multiple players
          sea1 << "# #{p.name} #" 
          sea1p << "# #{p.position} #{p.name} #"
          sea1tp << "# #{p.team.name} #{p.position} #{p.name} #"
          sea1tpn << "# #{p.team.name} #{p.position} #{p.name} (#{p.number}) #"
          sea1n << "# #{p.name} (#{p.number}) #"
          sea1tn << "# #{p.team.name} #{p.name} (#{p.number}) #"
          sea1pn << "# #{p.position} #{p.name} (#{p.number}) #"
          sea1s << "# [#{p.last_name},#{p.first_name}], #"
        end
      end

      # add new line at end of expansion
      sea1 << "\n"
      sea1p << "\n"
      sea1tp << "\n"
      sea1tpn << "\n"
      sea1n << "\n"
      sea1tn << "\n"
      sea1pn << "\n"
      sea1s << "\n"

      # update return string
      ret << sea1 << sea1p 
      ret << sea1tp << sea1tpn 
      ret << sea1n << sea1tn
      ret << sea1pn << sea1s
    end
    ret
  end

  #def code(prefix = prefix)
  #  ret = ""
  #  players.each do |p|
  #    # sea1 doug funny
  #    ret << "#{prefix}#{p.number}" << "\t" << "#{p.name}" << "\n"
  #    # sea1p wr doug funny
  #    ret << "#{prefix}#{p.number}p" << "\t" << "#{p.position} #{p.name}" << "\n"
  #    # sea1tp seattle seahawks wr doug funny
  #    ret << "#{prefix}#{p.number}tp" << "\t" << "#{p.team.name} #{p.position} #{p.name}" << "\n"
  #    # sea1tpn seattle seahawks wr doug funny (2)
  #    ret << "#{prefix}#{p.number}tpn" << "\t" << "#{p.team.name} #{p.position} #{p.name} (#{p.number})" << "\n"
  #    # sea1n doug funny (2)
  #    ret << "#{prefix}#{p.number}n" << "\t" << "#{p.name} (#{p.number})" << "\n"
  #    # sea1tn seattle seahawks doug funny (2)
  #    ret << "#{prefix}#{p.number}tn" << "\t" << "#{p.team.name} #{p.name} (#{p.number})" << "\n"
  #    # sea1pn wr doug funny (2)
  #    ret << "#{prefix}#{p.number}pn" << "\t" << "#{p.position} #{p.name} (#{p.number})" << "\n"
  #    # sea1s [funny, doug], 
  #    ret << "#{prefix}#{p.number}s" << "\t" << "[#{p.last_name},#{p.first_name}]," << "\n"
  #  end
  #  ret
  #end

  def scrape
    # Delete all players on this team
    players.destroy_all 
    if league.name.upcase == "MLS"
      scrape_mls
    elsif league.name.upcase == "NFL"
      scrape_nfl
    end
  end

  def scrape_mls
    scraper = Scraper.define do
      process "#mpl-team-name", :name => :text
      array :players
      process ".mpl-tbody-row", :players => Scraper.define {
        process ".mpl-number", :number => :text
        process ".mpl-position", :position => :text
        process ".mpl-player.active>a", :name => :text
        result :number, :position, :name
      }
      result :name, :players
    end
    results = scraper.scrape(URI.parse(uri))
    results.players.each do |p|
      next if p[:number].nil? || p[:name].nil? || p[:position].nil?
      player = Player.new
      player.team_id = id
      player.number = p[:number]
      player.position = p[:position]
      player.first_name = p[:name].split[0]
      player.last_name = p[:name].split[1..(p[:name].size)].join(" ")
      player.save
    end
  end

  def scrape_nfl
    scraper = Scraper.define do
      array :players_even
      process ".loop-even", :players_even => Scraper.define {
        process ".col-jersey", :number => :text
        process ".player-card-tooltip>span", :name => :text
        process ".col-position", :position => :text
        result :number, :name, :position
      }
      array :players_odd
      process ".loop-odd", :players_odd => Scraper.define {
        process ".col-jersey", :number => :text
        process ".player-card-tooltip>span", :name => :text
        process ".col-position", :position => :text
        result :number, :name, :position
      }
      result :players_even, :players_odd
    end
    results = scraper.scrape(URI.parse(uri))
    results.players_even.each do |p|
      next if p[:number].nil? || p[:name].nil? || p[:position].nil?
      player = Player.new
      player.team_id = id
      player.number = p[:number]
      player.position = p[:position]
      player.last_name = p[:name].split(',')[0].strip
      player.first_name = p[:name].split(',')[1].strip
      player.save
    end
    results.players_odd.each do |p|
      next if p[:number].nil? || p[:name].nil? || p[:position].nil?
      player = Player.new
      player.team_id = id
      player.number = p[:number]
      player.position = p[:position]
      player.last_name = p[:name].split(',')[0].strip
      player.first_name = p[:name].split(',')[1].strip
      player.save
    end
  end
end

