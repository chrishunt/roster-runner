class ScrapersController < ApplicationController
  def mls
    render :text => Scraper.mls
  end
end
