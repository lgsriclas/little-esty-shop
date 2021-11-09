require 'rails_helper'

RSpec.describe 'create new item page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Larry's Lucky Ladles")
  end

  it 'attributes' do
    visit "/merchants/#{@merchant_1.id}/items/new"

    expect(page).to have_content("Name")
  end

  it 'creates a new item' do
    visit merchant_items_path(@merchant_1)

    click_link "Create New Item"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")

    fill_in 'Name', with: 'Thor Ladle'
    fill_in 'Description', with: 'Perfectly Balanced'
    fill_in 'Unit price', with: 20
    click_on 'Create Item'

    expect(current_path).to eq(merchant_items_path(@merchant_1))
    expect(page).to have_content("Thor Ladle")
  end
end