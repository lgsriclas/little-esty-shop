class Holiday
  attr_reader :name

  def initialize
    @name = HolidayService.holiday
  end
end