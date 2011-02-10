class AddGenderToTeam < ActiveRecord::Migration
  def self.up
    add_column :teams, :gender, :string
  end

  def self.down
    remove_column :teams, :gender
  end
end
