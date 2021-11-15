require 'rails_helper'

RSpec.describe 'create new bulk discount page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Larry's Lucky Ladles")
  end

  it 'attributes' do
    visit new_merchant_bulk_discount_path(@merchant_1.id)

    expect(page).to have_content("New Discount")
  end

  it 'creates a new discount' do
    visit merchant_bulk_discounts_path(@merchant_1)

    click_link "Create New Discount"

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))

    fill_in :quantity_threshold, with: '12'
    fill_in :percent_discount, with: '25'
    click_on 'Create Discount'

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
    expect(page).to have_content(12)
  end
end