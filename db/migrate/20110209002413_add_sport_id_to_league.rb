class AddSportIdToLeague < ActiveRecord::Migration
  def self.up
    add_column :leagues, :sport_id, :integer
  end

  def self.down
    remove_column :leagues, :sport_id
  end
end
