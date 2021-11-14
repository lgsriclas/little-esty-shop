class HolidayService
  def self.holiday
    response = get_url('https://date.nager.at/').get('api/v2/NextPublicHolidays/us')
    JSON.parse(response.body, symbolize_names: true)[0..2]
  end

  def self.get_url(url)
    Faraday.new(url)
  end
end