require 'rails_helper'

RSpec.describe 'Admin Merchant Index' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Larry's Lucky Ladles")
    @merchant_2 = Merchant.create!(name: "Bob's Burgers")
    @item_1 = Item.create!(name: "Star Wars Ladle", description: "May the soup be with you", unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Sparkle Ladle", description: "Serve in style", unit_price: 12, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Burger Bun Bookends", description: "Books between buns", unit_price: 40, merchant_id: @merchant_2.id)
    @item_4 = Item.create!(name: "Burger Bun Slippers", description: "Buns for your feet", unit_price: 30, merchant_id: @merchant_2.id)

    @customer_1 = Customer.create!(first_name: "Sally", last_name: "Brown")
    @customer_2 = Customer.create!(first_name: "Morgan", last_name: "Freeman")

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_3 = Invoice.create!(status: 0, customer_id: @customer_2.id)
    @invoice_4 = Invoice.create!(status: 2, customer_id: @customer_2.id)

    @ii_1 = InvoiceItem.create!(quantity: 1, unit_price: 10, status: 1, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @ii_2 = InvoiceItem.create!(quantity: 1, unit_price: 12, status: 2, item_id: @item_2.id, invoice_id: @invoice_2.id)
    @ii_3 = InvoiceItem.create!(quantity: 1, unit_price: 40, status: 0, item_id: @item_3.id, invoice_id: @invoice_3.id)
    @ii_4 = InvoiceItem.create!(quantity: 1, unit_price: 30, status: 2, item_id: @item_4.id, invoice_id: @invoice_4.id)
  end

  it 'displays the name of all merchants' do
    visit '/admin/merchants'

    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_1.name)
  end

  it 'links to each merchants show page' do
    visit '/admin/merchants'

    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_link(@merchant_1.name)
  end

  xit 'has a button to enable/disable a given merchant' do
    visit '/admin/merchants'

    expect(page).to have_button("Disable")
    expect(@merchant_1.status).to eq(true)

    within("#{@merchant_1.id}") do
      click_button "Disable"
    end

    expect(page).to have_button("Enable")
    expect(@merchant_1.status).to eq(false)
  end

  it 'provides a link to create a new merchant' do
    visit '/admin/merchants'

    click_link "Create New Merchant"
    expect(current_path).to eq("/admin/merchants/new")
  end

  it 'seperates merchants by status' do
    visit '/admin/merchants'

    expect(page).to have_content("Enabled Merchants")
    expect(page).to have_content("Disabled Merchants")

    expect(@merchant_1.name).to appear_before("Disabled Merchants")
  end

  it 'shows the top 5 merchants by revenue, with their revenue' do
    visit '/admin/merchants'

    expect(page).to have_content("Top 5 Merchants by Revenue:")

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(@merchant_1.name).to appear_before(@merchant_2.name)
  end
end
