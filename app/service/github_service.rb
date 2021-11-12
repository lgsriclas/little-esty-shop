class GithubService
  def self.repo
    response = get_url('https://api.github.com/repos/lgsriclas/').get("little-esty-shop")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.contributors
    response = get_url('https://api.github.com/repos/lgsriclas/').get("little-esty-shop/contributors")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.pulls
    response = get_url('https://api.github.com/repos/lgsriclas/').get("little-esty-shop/pulls?state=closed")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_url(url)
    Faraday.new(url)
  end
end