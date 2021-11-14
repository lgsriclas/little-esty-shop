class Holiday
  attr_reader :holidays

  def initialize(data)
    @holidays = data[:holidays]
  end

  def upcoming_holidays(code)
    @holidays.next_holidays(country_code[0..2])
  end
end