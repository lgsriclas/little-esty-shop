class ApplicationController < ActionController::Base
  def api_call
    @repo = GithubFacade.create_repo
    @contributers = GithubFacade.create_contributers
    @commits = GithubFacade.create_commits
  end
end
