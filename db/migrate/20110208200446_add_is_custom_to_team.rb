class AddIsCustomToTeam < ActiveRecord::Migration
  def self.up
    add_column :teams, :is_custom, :boolean
  end

  def self.down
    remove_column :teams, :is_custom
  end
end
