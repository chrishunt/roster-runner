class Sport < ActiveRecord::Base
  has_many :leagues, :dependent => :destroy
  validates_presence_of :name
end
