class LeaguesController < ApplicationController
  before_filter :redirect_to_root, :except => [:show]

  def index
  end

  def show
    @gender = params[:gender].nil? ? "male" : params[:gender]
    @league = League.find(params[:id])
    @teams = @gender == "female" ? @league.female_teams : @league.male_teams
    # Cache results for 5 minutes
    #response.headers['Cache-Control'] = 'public, max-age=300'
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(params[:league])
    if @league.save
      flash[:notice] = "Successfully created league."
      redirect_to @league
    else
      render :action => 'new'
    end
  end

  def edit
    @league = League.find(params[:id])
  end

  def update
    @league = League.find(params[:id])
    if @league.update_attributes(params[:league])
      flash[:notice] = "Successfully updated league."
      redirect_to league_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @league = League.find(params[:id])
    @league.destroy
    flash[:notice] = "Successfully destroyed league."
    redirect_to leagues_url
  end
end
