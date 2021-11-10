require 'rails_helper'

RSpec.describe 'merchant dashboard page' do
  it 'shows the name of my merchant' do
    merchant1 = Merchant.create!(name: "Larry's Lucky Ladles")

    visit merchant_dashboard_path(merchant1.id)

    expect(page).to have_content(merchant1.name)
  end

  it 'shows link for merchant item index' do
    merchant1 = Merchant.create!(name: "Larry's Lucky Ladles")

    visit merchant_dashboard_path(merchant1.id)

    expect(page).to have_link('Items')
  end

  it 'shows link for merchant invoices index' do
    merchant1 = Merchant.create!(name: "Larry's Lucky Ladles")

    visit merchant_dashboard_path(merchant1.id)

    expect(page).to have_link('Invoices')
  end
end
