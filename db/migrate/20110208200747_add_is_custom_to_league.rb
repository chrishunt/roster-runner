class AddIsCustomToLeague < ActiveRecord::Migration
  def self.up
    add_column :leagues, :is_custom, :boolean
  end

  def self.down
    remove_column :leagues, :is_custom
  end
end
