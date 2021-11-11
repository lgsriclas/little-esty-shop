class Commits
  attr_reader :commits_count

  def initialize(data)
    @commits_count = data[:commits_count]
  end
end