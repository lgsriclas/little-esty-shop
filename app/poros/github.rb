require './app/service/github_service'

class Github
  attr_reader :repo, :contributers, :commits, :pulls

  def initialize
    @repo = GithubService.repo(reponame)
    @contributers = GithubService.contributers
    @commits = GithubService.commits
    @pulls = GithubService.pulls
  end
end