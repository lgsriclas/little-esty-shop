require './app/service/github_service'

RSpec.describe GithubService do
  before :each do
    mock_response =
    '{
      "id": 423605271,
      "node_id": "R_kgDOGT-0Fw",
      "name": "little-esty-shop",
      "full_name": "lgsriclas/little-esty-shop",
      "private": false,
      "owner": {
        "login": "lgsriclas",
        "id": 423605271,
        "node_id": "R_kgDOGT-0Fw",
        "avatar_url": "https://avatars.githubusercontent.com/u/87659229?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/lgsriclas",
        "html_url": "https://github.com/lgsriclas",
        "type": "User",
        "site_admin": false,
        "name": "Lesley Sanders",
        "created_at": "2014-09-29T18:05:53Z",
        "updated_at": "2021-06-07T21:28:42Z"
      },
      "contributer_1": {
        "login": "chazsimons",
        "id": 85699215,
        "node_id": "MDQ6VXNlcjg1Njk5MjE1",
        "avatar_url": "https://avatars.githubusercontent.com/u/85699215?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/chazsimons",
        "html_url": "https://github.com/chazsimons",
        "type": "User",
        "site_admin": false,
        "name": "Chaz Simons",
        "created_at": "2021-06-10T16:51:29Z",
        "updated_at": "2021-09-01T16:45:40Z"
      },
      "contributer_2": {
        "login": "tstaros23",
        "id": 81131454,
        "node_id": "MDQ6VXNlcjgxMTMxNDU0",
        "avatar_url": "https://avatars.githubusercontent.com/u/81131454?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/tstaros23",
        "html_url": "https://github.com/tstaros23",
        "type": "User",
        "site_admin": false,
        "name": "Ted Staros",
        "created_at": "2021-03-22T02:46:59Z",
        "updated_at": "2021-10-14T05:15:56Z"
      },
      "contributer_3": {
        "login": "bfrey08",
        "id": 87046098,
        "node_id": "MDQ6VXNlcjg3MDQ2MDk4",
        "avatar_url": "https://avatars.githubusercontent.com/u/87046098?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/bfrey08",
        "html_url": "https://github.com/bfrey08",
        "type": "User",
        "site_admin": false,
        "name": "Billy Frey",
        "created_at": "2021-07-06T23:19:34Z",
        "updated_at": "2021-09-28T16:05:40Z"
      }
    }'

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)
  end

  it 'returns the repository name' do
    json = GithubService.repo

    expect(json).to be_a(Hash)
    expect(json).to have_key(:name)
  end

  it 'returns the contributers names' do
    json = GithubService.contributers

    expect(json[:owner][:login]).to eq('lgsriclas')
    expect(json[:contributer_1][:login]).to eq('chazsimons')
    expect(json[:contributer_2][:login]).to eq('tstaros23')
    expect(json[:contributer_3][:login]).to eq('bfrey08')
  end

  xit 'returns the contributers names' do
    json = GithubService.commits

    expect(json[:owner]).to eq('lgsriclas')
    expect(json).to have_key(:contributer_1)
    expect(json).to have_key(:contributer_2)
    expect(json).to have_key(:contributer_3)
  end
end