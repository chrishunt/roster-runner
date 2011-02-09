class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_leagues

  def get_leagues
    @leagues = League.where("NOT is_custom").order(:name)
  end

  def redirect_to_root
    redirect_to '/'
  end
end
