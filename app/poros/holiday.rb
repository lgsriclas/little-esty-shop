class Holiday
  attr_reader :holidays

  def initialize(data)
    @three = data[:holidays]
  end

  def upcoming_holidays(code)
    @three.next_holidays(country_code[0..2])
  end
end