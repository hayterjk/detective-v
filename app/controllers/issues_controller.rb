require 'octokit'

class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.where(:user_id => current_user.id)
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def publish
    begin
      github = ApplicationHelper.github(current_user)
      if (github == nil)
        redirect_to :back, alert: 'Error with Access Token'
        return
      end
    
      @issue = Issue.find(params[:id])
      @publish_repo  = Repo.find(@issue.repo_id)

      if current_user.access_token == "" or current_user.access_token.nil?
        redirect_to :back, alert: 'Need valid GitHub Access Token in User Settings to Publish Issues' and return
      else
        begin
          user_github = Octokit::Client.new(:access_token => current_user.access_token)
          @result = user_github.create_issue("#{@publish_repo.owner}/#{@publish_repo.name}", @issue.description, render_to_string("github_issue"))
          redirect_to :back, notice: 'Issue Created' and return
        rescue Exception
          redirect_to :back, alert: 'There was an error. Please go to settings to add or update your access token.' and return
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:severity, :source, :description, :detail, :fingerprint, :scan_id, :user_id)
    end
end
