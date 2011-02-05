class RemoveRosterFromTeam < ActiveRecord::Migration
  def self.up
    remove_column :teams, :roster
  end

  def self.down
    add_column :teams, :roster, :text
  end
end
