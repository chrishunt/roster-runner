class AddUriToLeague < ActiveRecord::Migration
  def self.up
    add_column :leagues, :uri, :string
  end

  def self.down
    remove_column :leagues, :uri
  end
end
