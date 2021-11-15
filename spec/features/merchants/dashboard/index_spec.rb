require 'rails_helper'

RSpec.describe 'merchant dashboard page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Larry's Lucky Ladles")

    @item_1 = Item.create!(name: "Star Wars Ladle", description: "May the soup be with you", unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Sparkle Ladle", description: "Serve in style", unit_price: 12, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Green Ladle", description: "It is green", unit_price: 15, merchant_id: @merchant_1.id)
    @item_4 = Item.create!(name: "Purple Ladle", description: "It is purple", unit_price: 17, merchant_id: @merchant_1.id)
    @item_5 = Item.create!(name: "Yellow Ladle", description: "It is yellow", unit_price: 14, merchant_id: @merchant_1.id)
    @item_6 = Item.create!(name: "Orange Ladle", description: "It is orange", unit_price: 20, merchant_id: @merchant_1.id)
    @item_7 = Item.create!(name: "Black Ladle", description: "It is black", unit_price: 5, merchant_id: @merchant_1.id)

    @customer_1 = Customer.create!(first_name: "Sally", last_name: "Brown")
    @customer_2 = Customer.create!(first_name: "Morgan", last_name: "Freeman")

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_3 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_4 = Invoice.create!(status: 1, customer_id: @customer_2.id)

    @ii_1 = InvoiceItem.create!(quantity: 5, unit_price: 10, status: 0, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @ii_2 = InvoiceItem.create!(quantity: 5, unit_price: 12, status: 2, item_id: @item_2.id, invoice_id: @invoice_1.id)
    @ii_3 = InvoiceItem.create!(quantity: 5, unit_price: 15, status: 0, item_id: @item_3.id, invoice_id: @invoice_2.id)
    @ii_4 = InvoiceItem.create!(quantity: 5, unit_price: 17, status: 2, item_id: @item_4.id, invoice_id: @invoice_2.id)
    @ii_5 = InvoiceItem.create!(quantity: 5, unit_price: 14, status: 0, item_id: @item_5.id, invoice_id: @invoice_1.id)
    @ii_6 = InvoiceItem.create!(quantity: 5, unit_price: 20, status: 2, item_id: @item_6.id, invoice_id: @invoice_1.id)
    @ii_7 = InvoiceItem.create!(quantity: 5, unit_price: 5, status: 0, item_id: @item_7.id, invoice_id: @invoice_2.id)

    @transaction_1 = Transaction.create!(credit_card_number: "5522 3344 8811 7777", credit_card_expiration_date: "2025-05-17", result: 0, invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: "5555 4444 3333 2222", credit_card_expiration_date: "2023-02-11", result: 0, invoice_id: @invoice_1.id)
    @transaction_3 = Transaction.create!(credit_card_number: "5551 4244 3133 2622", credit_card_expiration_date: "2027-01-01", result: 0, invoice_id: @invoice_1.id)
    @transaction_4 = Transaction.create!(credit_card_number: "5775 4774 3373 2722", credit_card_expiration_date: "2030-07-22", result: 0, invoice_id: @invoice_2.id)
    @transaction_5 = Transaction.create!(credit_card_number: "5773 4374 4373 2622", credit_card_expiration_date: "2027-11-24", result: 0, invoice_id: @invoice_2.id)
    @transaction_6 = Transaction.create!(credit_card_number: "5235 2374 3233 2322", credit_card_expiration_date: "2023-03-23", result: 0, invoice_id: @invoice_2.id)
    @transaction_7 = Transaction.create!(credit_card_number: "5233 2322 3211 2300", credit_card_expiration_date: "2021-12-23", result: 1, invoice_id: @invoice_2.id)
  end

  it 'shows the name of my merchant' do
    merchant1 = Merchant.create!(name: "Larry's Lucky Ladles")

    visit merchant_dashboard_index_path(merchant1)

    expect(page).to have_content(merchant1.name)
  end

  it 'shows link for merchant item index' do
    merchant1 = Merchant.create!(name: "Larry's Lucky Ladles")

    visit merchant_dashboard_index_path(merchant1)

    expect(page).to have_link('Items')
  end

  it 'shows link for merchant invoices index' do
    merchant1 = Merchant.create!(name: "Larry's Lucky Ladles")

    visit merchant_dashboard_index_path(merchant1)

    expect(page).to have_link('Invoices')
  end

  it 'shows favorite_customers' do
    visit merchant_dashboard_index_path(@merchant_1)

    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
    expect(page).to have_content(@merchant_1.favorite_customers.first.transaction_count)
  end

  it 'shows names of items that are ready to ship' do
    visit merchant_dashboard_index_path(@merchant_1)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_3.name)
    expect(page).to have_content(@item_5.name)
    expect(page).to have_content(@item_7.name)
    expect(page).to_not have_content(@item_2.name)
  end

  it 'shows items by created date asc' do
    visit merchant_dashboard_index_path(@merchant_1)

    expect(@item_1.name).to appear_before(@item_3.name)
  end

  it 'shows invoice id link for each item' do
    visit merchant_dashboard_index_path(@merchant_1)

    expect(page).to have_link(@invoice_1.id)
  end

  describe 'bulk discounts' do
    it 'has a link to view all discounts' do
      visit merchant_dashboard_index_path(@merchant_1)

      expect(page).to have_link('Discounts')
    end
  end
end