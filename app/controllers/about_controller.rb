class AboutController < ApplicationController
  def index
    # Cache results for one month 
    #response.headers['Cache-Control'] = 'public, max-age=2592000'
  end
end
