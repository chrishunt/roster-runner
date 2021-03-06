class Team < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name, :league, :gender, :uri
  has_many :players, :order => :number, :dependent => :destroy
  belongs_to :league

  def self.search(search)
    if !search.nil?
      where("upper(name) LIKE ?", "%#{search.upcase}%")
    else
      scoped
    end
  end

  def filename
    split = name.split
    file = "#{league.sport.name.downcase}_#{split[0].downcase}"
    split[1..(split.size)].each do |s|
      file << "_#{s.downcase}"
    end
    file << ".txt"
  end

  def prefix
    name.first.downcase
  end

  def code(prefix = prefix, team_name = name, format = "pm")
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
      expansions = {}
      expansions[:sea1] = "#{prefix}#{number}" << "\t"
      expansions[:sea1f] = "#{prefix}#{number}f" << "\t"
      expansions[:sea1l] = "#{prefix}#{number}l" << "\t"
      expansions[:sea1p] = "#{prefix}#{number}p" << "\t"
      expansions[:sea1t] = "#{prefix}#{number}t" << "\t"
      expansions[:sea1n] = "#{prefix}#{number}n" << "\t" 
      expansions[:sea1tp] = "#{prefix}#{number}tp" << "\t"
      expansions[:sea1tn] = "#{prefix}#{number}tn" << "\t"
      expansions[:sea1pn] = "#{prefix}#{number}pn" << "\t"
      expansions[:sea1tpn] = "#{prefix}#{number}tpn" << "\t"
      expansions[:sea1s] = "#{prefix}#{number}s" << "\t"

      group.each do |p|
        # tag for flagging duplicates
        duplicate_tag = "##"
        # append duplicate tag if multiple players have this number
        if group.size > 1
          expansions.each do |key, value|
            expansions[key] << duplicate_tag
          end
        end
        # save expansion each player
        expansions[:sea1] << "#{team_name} #{p.position_expanded} #{p.name} (#{p.number})"
        expansions[:sea1f] << "#{p.first_name}"
        expansions[:sea1l] << "#{p.last_name}"
        expansions[:sea1p] << "#{p.position_expanded} #{p.name}"
        expansions[:sea1t] << "#{team_name}'s #{p.name}"
        expansions[:sea1n] << "#{p.name} (#{p.number})"
        expansions[:sea1tp] << "#{team_name} #{p.position_expanded} #{p.name}"
        expansions[:sea1tn] << "#{team_name} #{p.name} (#{p.number})"
        expansions[:sea1pn] << "#{p.position_expanded} #{p.name} (#{p.number})"
        expansions[:sea1tpn] << "#{team_name} #{p.position_expanded} #{p.name} (#{p.number})"
        expansions[:sea1s] << "[#{p.last_name},#{p.first_name}],"
        # append duplicate tag if multiple players have this number
        if group.size > 1
          expansions.each do |key, value|
            expansions[key] << duplicate_tag
          end
        end
      end
      # add new line at end of expansion
      expansions.each do |key, value|
        expansions[key] << "\n"
      end
      # add players to return string
      expansions.each do |key, value|
        ret << value
      end
    end
    # add team to return string
    ret << prefix << "\t" << team_name << "\n"
    # return expansions
    ret
  end

  def scrape(csv = nil)
    return false if uri.nil?
    league_name = league.short_name.upcase
    if league_name == "MLS"
      players.destroy_all 
      scrape_mls
    elsif league_name == "NFL" ||
          league_name == "NBA" ||
          league_name == "NCAA FB" ||
          league_name == "NCAA BB" ||
          league_name == "MLB"
      players.destroy_all 
      scrape_espn
    elsif league_name == "CUSTOM" && !csv.nil?
      players.destroy_all 
      scrape_csv(csv)
    else
      puts "#{league_name} not a recognized league."
    end
  end

  def scrape_mls
    scraper = Scraper.define do
      array :even_rows
      process "tr.even", :even_rows => Scraper.define {
        process ".views-field-field-player-jersey-no-value", :number => :text
        process ".views-field-field-player-position-detail-value", :position => :text
        process ".views-field-field-player-lname-value>a", :name => :text
        result :number, :position, :name
      }
      array :odd_rows
      process "tr.odd", :odd_rows => Scraper.define {
        process ".views-field-field-player-jersey-no-value", :number => :text
        process ".views-field-field-player-position-detail-value", :position => :text
        process ".views-field-field-player-lname-value>a", :name => :text
        result :number, :position, :name
      }
      result :even_rows, :odd_rows
    end
    results = scraper.scrape(URI.parse(uri))
    (results.even_rows | results.odd_rows).each do |p|
      next if p[:number].nil? || p[:name].nil? || p[:position].nil?
      player = Player.new
      player.is_custom = false
      player.team_id = id
      player.number = p[:number].to_s.strip
      player.position = p[:position].to_s.strip
      player.first_name = p[:name].split[0].to_s.strip
      player.last_name = p[:name].split[1..(p[:name].size)].join(" ").to_s.strip
      player.save
    end
  end

  def scrape_espn
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
      # skip this row if we're missing data
      next if p[0].nil? || p[1].nil? || p[2].nil?

      number = p[0].to_s.strip
      number = nil if number == ""

      full_name = p[1].to_s.strip
      first_name = full_name.split[0].to_s.strip
      first_name = nil if first_name == ""
      last_name = full_name.split[1..(full_name.split.size - 1)].join(" ").to_s.strip
      last_name = nil if last_name == ""

      position = p[2].to_s.strip
      position = nil if position == ""
      
      # skip this row if our data was not as expected
      next if number.nil? || first_name.nil? || position.nil? || last_name.nil?

      # save this player to the roster
      player = Player.new
      player.is_custom = false
      player.team_id = id
      player.number = number
      player.first_name = first_name
      player.last_name = last_name
      player.position = position
      player.save
    end
  end

  def scrape_csv(csv)
    rows = CsvMapper.import(csv.to_s, :type => :io) do
      [number, position, first_name, last_name]
    end
    rows.each do |r|
      player = Player.new
      player.is_custom = true
      player.team_id = id
      player.number = r[:number].to_s.strip
      player.position = r[:position].to_s.strip
      player.first_name = r[:first_name].to_s.strip
      player.last_name = r[:last_name].to_s.strip
      player.save
    end
  end

  def to_csv
    csv = ""
    players.each do |player|
      csv << player.number.to_s << ","
      csv << player.position << ","
      csv << player.first_name << ","
      csv << player.last_name << "\n"
    end
    return csv
  end
end

