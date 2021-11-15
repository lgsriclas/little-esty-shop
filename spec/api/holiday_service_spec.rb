require './app/service/holiday_service'
require 'rails_helper'

RSpec.describe HolidayService do
  before :each do
    mock_response =
    '{
      "holiday_1": {
        "date": "2021-11-25",
        "name": "Thanksgiving Day",
        "countryCode": "US"
      },
      "holiday_2": {
        "date": "2021-12-24",
        "name": "Christmas Day",
        "countryCode": "US"
      },
      "holiday_3": {
        "date": "2021-12-31",
        "name": "New Years Day",
        "countryCode": "US"
      }
    }'

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)
  end

  it 'returns the next three US holidays' do
    json = HolidayService.holiday

    expect(json[:holiday_2][:name]).to eq('Christmas Day')
  end
end