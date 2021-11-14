class HolidayService
  def self.holiday
    response = Faraday.get('https://date.nager.at/api/v2/NextPublicHolidays/us')
    JSON.parse(response.body, symbolize_names: true)[0..2]
  end
end