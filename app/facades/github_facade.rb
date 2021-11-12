class GithubFacade
  def self.create_repo
    Rails.cache.fetch('repo', :expires => 1.hour) do
      json = GithubService.repo
      Repo.new(json)
    end
  end

  def self.create_contributor
    Rails.cache.fetch('contributor', :expires => 1.hour) do
      json = GithubService.contributors
      json.map do |data|
        Contributor.new(data)
      end
    end
  end

  def self.create_pull
    Rails.cache.fetch('pull', :expires => 1.hour) do
      json = GithubService.pulls
      json.count
    end
  end
end