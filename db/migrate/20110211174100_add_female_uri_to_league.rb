class AddFemaleUriToLeague < ActiveRecord::Migration
  def self.up
    add_column :leagues, :female_uri, :string
  end

  def self.down
    remove_column :leagues, :female_uri
  end
end
