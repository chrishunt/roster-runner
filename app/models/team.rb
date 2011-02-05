class Team < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name, :league
  has_many :players
  belongs_to :league

  def filename
    split = name.split
    file = split[0].downcase
    split[1..(split.size)].each do |s|
      file << "_" << s.downcase
    end
    file << ".txt"
  end

  def prefix
    name.split[0][0..2].strip.downcase
  end

  def code(prefix = prefix)
    ret = ""
    players.each do |p|
      # sea1 doug funny
      ret << "#{prefix}#{p.number}" << "\t" << "#{p.name}" << "\n"
      # sea1p wr doug funny
      ret << "#{prefix}#{p.number}p" << "\t" << "#{p.position} #{p.name}" << "\n"
      # sea1tp seattle seahawks wr doug funny
      ret << "#{prefix}#{p.number}tp" << "\t" << "#{p.team.name} #{p.position} #{p.name}" << "\n"
      # sea1tpn seattle seahawks wr doug funny (2)
      ret << "#{prefix}#{p.number}tpn" << "\t" << "#{p.team.name} #{p.position} #{p.name} (#{p.number})" << "\n"
      # sea1n doug funny (2)
      ret << "#{prefix}#{p.number}n" << "\t" << "#{p.name} (#{p.number})" << "\n"
      # sea1tn seattle seahawks doug funny (2)
      ret << "#{prefix}#{p.number}tn" << "\t" << "#{p.team.name} #{p.name} (#{p.number})" << "\n"
      # sea1pn wr doug funny (2)
      ret << "#{prefix}#{p.number}pn" << "\t" << "#{p.position} #{p.name} (#{p.number})" << "\n"
      # sea1s [funny, doug], 
      ret << "#{prefix}#{p.number}s" << "\t" << "[#{p.last_name},#{p.first_name}]," << "\n"
    end
    ret
  end
end
