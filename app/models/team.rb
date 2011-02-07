class Team < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name, :league, :uri
  has_many :players, :order => :number
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
      i = i+1

      # save expansion prefix
      number = group[0].number
      sea1 = "#{prefix}#{number}" << "\t"
      sea1p = "#{prefix}#{number}p" << "\t"
      sea1tp = "#{prefix}#{number}tp" << "\t"
      sea1tpn = "#{prefix}#{number}tpn" << "\t"
      sea1n = "#{prefix}#{number}n" << "\t" 
      sea1tn = "#{prefix}#{number}tn" << "\t"
      sea1pn = "#{prefix}#{number}pn" << "\t"
      sea1s = "#{prefix}#{number}s" << "\t"

      group.each do |p|
        # tag for flagging duplicates
        duplicate_tag = "#"
        # append duplicate tag if multiple players have this number
        if group.size > 1
          sea1 << duplicate_tag << " "
          sea1p << duplicate_tag << " "
          sea1tp << duplicate_tag << " "
          sea1tpn << duplicate_tag << " "
          sea1n << duplicate_tag << " "
          sea1tn << duplicate_tag << " "
          sea1pn << duplicate_tag << " "
          sea1s << duplicate_tag << " "
        end
        # save expansion for multiple players
        sea1 << "#{p.name}"
        sea1p << "#{p.position} #{p.name}"
        sea1tp << "#{p.team.name} #{p.position} #{p.name}"
        sea1tpn << "#{p.team.name} #{p.position} #{p.name} (#{p.number})"
        sea1n << "#{p.name} (#{p.number})"
        sea1tn << "#{p.team.name} #{p.name} (#{p.number})"
        sea1pn << "#{p.position} #{p.name} (#{p.number})"
        sea1s << "[#{p.last_name},#{p.first_name}],"
        # append duplicate tag if multiple players have this number
        if group.size > 1
          sea1 << " " << duplicate_tag
          sea1p << " " << duplicate_tag
          sea1tp << " " << duplicate_tag
          sea1tpn << " " << duplicate_tag
          sea1n << " " << duplicate_tag
          sea1tn << " " << duplicate_tag
          sea1pn << " " << duplicate_tag
          sea1s << " " << duplicate_tag
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

  def scrape_roster
    # Delete all players on this team
    players.destroy_all 
    # Scrape according to league
    if league.name.upcase == "MLS"
      scrape_mls_roster
    elsif league.name.upcase == "NFL" ||
          league.name.upcase == "NBA"
      scrape_espn_roster
    end
  end

  def scrape_mls_roster
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

  def scrape_espn_roster
    scraper = Scraper.define do
      array :players_odd
      process ".oddrow", :players_odd => Scraper.define {
        array :rows
        process "td", :rows => :text
        result :rows
      }
      array :players_even
      process ".evenrow", :players_even => Scraper.define {
        array :rows
        process "td", :rows => :text
        result :rows
      }
      result :players_odd, :players_even
    end
    results = scraper.scrape(URI.parse(uri))
    players = results.players_even + results.players_odd
    players.each do |p|
      next if p[0].nil? || p[1].nil? || p[2].nil?
      player = Player.new
      player.team_id = id
      player.number = p[0]
      full_name = p[1].split 
      player.first_name = full_name[0]
      player.last_name = full_name[1..(full_name.size-1)].join(" ")
      player.position = p[2]
      player.save
    end
  end
end

