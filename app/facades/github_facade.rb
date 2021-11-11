class GithubFacade
  def create_repos
    json = GithubService.repo
    json.map do |data|
      Repo.new(data)
    end
  end

  def create_contributers
    json = GithubService.contributers
    json.map do |data|
      Contributers.new(data)
    end
  end

  def create_commits
    json = GithubService.commits
    json.map do |data|
      Commits.new(data)
    end
  end

  def create_pulls
    json = GithubService.pulls
    json.map do |data|
      Pulls.new(data)
    end
  end
end