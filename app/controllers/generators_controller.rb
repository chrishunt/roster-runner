class GeneratorsController < ApplicationController
  def index
    @team = Team.new
  end
end
