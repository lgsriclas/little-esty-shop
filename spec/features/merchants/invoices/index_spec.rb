require 'rails_helper'

RSpec.describe 'merchant invoices index page' do
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

  it 'shows invoices with my merchant items' do
    visit merchant_invoices_path(@merchant_1)

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
    expect(page).to_not have_content(@merchant_2.name)
  end

  it 'has link to merchant invoice show page' do
    visit merchant_invoices_path(@merchant_2)

    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_link(@invoice_3.id)
    expect(page).to have_link(@invoice_4.id)
    expect(page).to_not have_content(@merchant_1.name)
    expect(page).to_not have_link(@invoice_1.id)
    expect(page).to_not have_link(@invoice_2.id)
  end
end