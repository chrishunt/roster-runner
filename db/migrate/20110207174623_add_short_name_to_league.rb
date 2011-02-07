class AddShortNameToLeague < ActiveRecord::Migration
  def self.up
    add_column :leagues, :short_name, :string
  end

  def self.down
    remove_column :leagues, :short_name
  end
end
