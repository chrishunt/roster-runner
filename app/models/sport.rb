class Sport < ActiveRecord::Base
  has_many :leagues, :order => :short_name, :dependent => :destroy
  validates_presence_of :name
end
