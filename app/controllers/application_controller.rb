class ApplicationController < ActionController::Base
  before_action :api_call
  def api_call
    @repo = GithubFacade.create_repo
    @contributors = GithubFacade.create_contributor
    @pulls = GithubFacade.create_pull
  end
end
