class Pulls
  attr_reader :pulls_count

  def initialize(data)
    @pulls_count = data[:pulls_count]
  end
end