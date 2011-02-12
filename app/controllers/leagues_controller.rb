class LeaguesController < ApplicationController
  before_filter :redirect_to_root, :except => [:index,:show]

  def index
    @league = League.where("is_custom = ?",false).first
    redirect_to @league if !@league.nil?
  end

  def show
    @gender = params[:gender].nil? ? "male" : params[:gender]
    @search = params[:search]
    @league = League.find(params[:id])
    @teams = Team.search(@search).where("league_id = ? AND gender LIKE ?", @league.id, @gender).order(:name).paginate(:per_page => 10, :page => params[:page])
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
