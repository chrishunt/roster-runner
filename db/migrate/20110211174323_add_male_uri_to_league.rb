class AddMaleUriToLeague < ActiveRecord::Migration
  def self.up
    add_column :leagues, :male_uri, :string
  end

  def self.down
    remove_column :leagues, :male_uri
  end
end
