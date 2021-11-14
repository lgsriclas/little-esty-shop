class HolidayService
  def self.holiday
    response = get_url('https://date.nager.at/api/v2/NextPublicHolidays/{countryCode}')
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_url(url)
    Faraday.new(url)
  end
end