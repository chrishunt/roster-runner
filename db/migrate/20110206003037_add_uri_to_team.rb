class AddUriToTeam < ActiveRecord::Migration
  def self.up
    add_column :teams, :uri, :string
  end

  def self.down
    remove_column :teams, :uri
  end
end
