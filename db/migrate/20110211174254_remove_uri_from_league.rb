class RemoveUriFromLeague < ActiveRecord::Migration
  def self.up
    remove_column :leagues, :uri
  end

  def self.down
    add_column :leagues, :uri, :string
  end
end
