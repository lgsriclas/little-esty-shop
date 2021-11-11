class GithubService
  def self.repo
    get_url("little-esty-shop")
  end

  def self.contributers
    get_url("little_esty_shop/contributers")
  end

  def self.commits
    get_url("little_esty_shop/commits")
  end

  def self.pulls
    get url("little_esty_shop/pulls")
  end

  def self.get_url(url)
    response = Faraday.get("api.github.com/repos/lgsriclas/#{url}")
    JSON.parse(response.body, symbolize_names: true)
  end
end