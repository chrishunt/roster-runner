class TeamsController < ApplicationController
  before_filter :redirect_to_root, :except => [:show, :code, :custom]

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @league = @team.league
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])
    if @team.save
      flash[:notice] = "Successfully created team."
      redirect_to @team
    else
      render :action => 'new'
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      flash[:notice] = "Successfully updated team."
      redirect_to team_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    flash[:notice] = "Successfully destroyed team."
    redirect_to teams_url
  end

  def code
    @team = Team.find params[:id]
    if !@team.nil?
      prefix = params[:prefix]
      if prefix.nil? || prefix == ""
        prefix = @team.prefix
      end
      response.headers['Content-Type'] = 'text/plain'
      response.headers['Content-Disposition'] = "attachment; filename=#{@team.filename}"
      render :text => @team.code(prefix)
    end
  end

  def custom
  end
end
