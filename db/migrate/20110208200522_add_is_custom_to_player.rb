class AddIsCustomToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :is_custom, :boolean
  end

  def self.down
    remove_column :players, :is_custom
  end
end
