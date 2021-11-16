require './app/service/holiday_service'
require 'rails_helper'

RSpec.describe HolidayService do
  it 'exists' do
    holiday = HolidayService.new

    expect(holiday).to be_an_instance_of(HolidayService)
  end

  it 'returns the next three US holidays' do
    # VCR.use_cassette('holidays') do
    #   hs = HolidayService.holiday
    #
    #   expect(hs[0][:name]).to eq("Thanksgiving Day")
    #   expect(hs[1][:name]).to eq("Christmas Day")
    #   expect(hs[2][:name]).to eq("New Year's Day")
    #   expect(hs[0][:countryCode]).to eq("US")
    #   expect(hs.count).to eq(3)
    # end
  end
end