require 'rails_helper'

RSpec.describe 'merchant dashboard page' do
  it 'shows the name of my merchant' do
    merchant1 = Merchant.create!(name: "Larry's Lucky Ladles")

    visit merchant_dashboard_path(merchant1.id)

    expect(page).to have_content(merchant1.name)
  end

  it 'shows link for merchant item show' do
    merchant1 = Merchant.create!(name: "Larry's Lucky Ladles")

    visit merchant_dashboard_path(merchant1.id)

    expect(page).to have_link('Items')
  end

  it 'shows link for merchant invoices show' do
    merchant1 = Merchant.create!(name: "Larry's Lucky Ladles")

    visit merchant_dashboard_path(merchant1.id)

    expect(page).to have_link('Invoices')
  end

  it 'shows the items names on the show page that are ready to ship page and an invoice ID next to each one' do
    merchant_1 = Merchant.create!(name: "Larry's Lucky Ladles")

    item_1 = Item.create!(name: "Star Wars Ladle", description: "May the soup be with you", unit_price: 10, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: "Sparkle Ladle", description: "Serve in style", unit_price: 12, merchant_id: merchant_1.id)
    item_3 = Item.create!(name: "Green Ladle", description: "It is green", unit_price: 15, merchant_id: merchant_1.id)
    item_4 = Item.create!(name: "Purple Ladle", description: "It is purple", unit_price: 17, merchant_id: merchant_1.id)
    item_5 = Item.create!(name: "Yellow Ladle", description: "It is yellow", unit_price: 14, merchant_id: merchant_1.id)
    item_6 = Item.create!(name: "Orange Ladle", description: "It is orange", unit_price: 20, merchant_id: merchant_1.id)
    item_7 = Item.create!(name: "Black Ladle", description: "It is black", unit_price: 5, merchant_id: merchant_1.id)

    customer_1 = Customer.create!(first_name: "Sally", last_name: "Brown")
    customer_2 = Customer.create!(first_name: "Morgan", last_name: "Freeman")

    invoice_1 = Invoice.create!(status: 1, customer_id: customer_1.id)
    invoice_2 = Invoice.create!(status: 1, customer_id: customer_1.id)
    invoice_3 = Invoice.create!(status: 1, customer_id: customer_2.id)
    invoice_4 = Invoice.create!(status: 1, customer_id: customer_2.id)

    ii_1 = InvoiceItem.create!(quantity: 5, unit_price: 10, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
    ii_2 = InvoiceItem.create!(quantity: 5, unit_price: 12, status: 2, item_id: item_2.id, invoice_id: invoice_1.id)
    ii_3 = InvoiceItem.create!(quantity: 5, unit_price: 15, status: 0, item_id: item_3.id, invoice_id: invoice_2.id)
    ii_4 = InvoiceItem.create!(quantity: 5, unit_price: 17, status: 2, item_id: item_4.id, invoice_id: invoice_2.id)
    ii_5 = InvoiceItem.create!(quantity: 5, unit_price: 14, status: 0, item_id: item_5.id, invoice_id: invoice_1.id)
    ii_6 = InvoiceItem.create!(quantity: 5, unit_price: 20, status: 2, item_id: item_6.id, invoice_id: invoice_1.id)
    ii_7 = InvoiceItem.create!(quantity: 5, unit_price: 5, status: 0, item_id: item_7.id, invoice_id: invoice_2.id)

    visit merchant_dashboard_path(merchant_1.id)

    expect(page).to have_content("Items Ready to Ship")
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_3.name)
    expect(page).to have_content(item_5.name)
    expect(page).to have_content(item_7.name)
  end
end
