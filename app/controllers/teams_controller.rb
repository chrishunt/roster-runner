class TeamsController < ApplicationController
  before_filter :redirect_to_root, :except => [:show, :code, :custom]

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @players = Player.where("team_id = ?", @team.id).order(:last_name).paginate(:per_page => 10, :page => params[:page])
    @league = @team.league
    # Cache results for 5 minutes
    response.headers['Cache-Control'] = 'public, max-age=300'
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
      team_name = params[:team_name]
      format = params[:form]
      prefix = params[:prefix]
      if prefix.nil? || prefix == ""
        prefix = @team.prefix
      end
      if team_name.nil? || team_name == ""
        team_name = @team.name
      end
      # Cache results for 5 minutes
      response.headers['Cache-Control'] = 'public, max-age=300'
      # Prompt download
      response.headers['Content-Type'] = 'text/plain'
      response.headers['Content-Disposition'] = "attachment; filename=#{@team.filename}"
      render :text => @team.code(prefix,team_name,format)
    end
  end

  def custom
    # Load all sports for sport select box
    @sports = Sport.all
    # Load data passed to form
    team_id = params[:team_id]
    @sport = params[:sport]
    if !@sport.nil?
      @sport = Sport.find(@sport[:id])
    end
    @csv = params[:csv_text_area]
    @team_name = params[:custom_team_name]
    if !team_id.nil?
      # We are customizing an existing team
      team = Team.find(team_id)
      @sport = team.league.sport
      @csv = team.to_csv
      @team_name = team.name
    elsif @csv.nil? || @team_name.nil? || @sport.nil?
      # We have not submitted the form yet
    elsif @team_name == "" && @csv == ""
      # Form was submitted, but missing all data
      flash[:error] = "Team name and team roster cannot be empty."
    elsif @team_name == ""
      # Form was submitted, but missing team name
      flash[:error] = "Team name cannot be empty."
    elsif @csv == ""
      # Form was submitted, but missing team roster
      flash[:error] = "Team roster cannot be empty."
    else
      # We have all our data, lets create a custom team
      @league = League.new
      @league.is_custom = true
      @league.sport = @sport
      @league.name = "Custom League"
      @league.short_name = "CUSTOM"
      @league.save
      @team = Team.new
      @team.league = @league
      @team.is_custom = true
      @team.gender = "male"
      @team.uri = "http://rosterrunner.com"
      @team.name = @team_name
      @team.save
      @team.scrape(@csv)
      @league = @team.league
      redirect_to @team
    end
  end
end
