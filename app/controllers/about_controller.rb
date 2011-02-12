class AboutController < ApplicationController
  before_filter :redirect_to_root
  def index
    # Cache results for one month 
    #response.headers['Cache-Control'] = 'public, max-age=2592000'
  end
end
