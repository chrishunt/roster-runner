class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :leagues

  def leagues
    @leagues = League.all
  end
end
