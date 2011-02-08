class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :leagues

  def leagues
    @leagues = League.all
  end

  def redirect_to_root
    redirect_to '/'
  end
end
