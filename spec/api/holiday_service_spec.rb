require './app/service/holiday_service'
require 'rails_helper'

RSpec.describe HolidayService do
  it 'exists' do
    holiday = HolidayService.new

    expect(holiday).to be_an_instance_of(HolidayService)
  end
end