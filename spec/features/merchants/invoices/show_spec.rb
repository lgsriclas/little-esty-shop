require 'rails_helper'

RSpec.describe 'merchant invoices show page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Larry's Lucky Ladles")
    @merchant_2 = Merchant.create!(name: "Bob's Burgers")

    @item_1 = Item.create!(name: "Star Wars Ladle", description: "May the soup be with you", unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Sparkle Ladle", description: "Serve in style", unit_price: 12, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Burger Bun Bookends", description: "Books between buns", unit_price: 40, merchant_id: @merchant_2.id)
    @item_4 = Item.create!(name: "Burger Bun Slippers", description: "Buns for your feet", unit_price: 30, merchant_id: @merchant_2.id)
    @item_5 = Item.create!(name: "Football Ladle", description: "Tackle that soup serving.", unit_price: 10, merchant_id: @merchant_1.id)
    @item_6 = Item.create!(name: "Baseball Ladle", description: "Help your stew be a home run!", unit_price: 10, merchant_id: @merchant_1.id)
    @item_7 = Item.create!(name: "Basketball Ladle", description: "Score some three pointers!", unit_price: 10, merchant_id: @merchant_1.id)
    @item_8 = Item.create!(name: "Soccer Ladle", description: "Kick of your next party with some soup.", unit_price: 10, merchant_id: @merchant_1.id)

    @customer_1 = Customer.create!(first_name: "Sally", last_name: "Brown")
    @customer_2 = Customer.create!(first_name: "Morgan", last_name: "Freeman")

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_3 = Invoice.create!(status: 0, customer_id: @customer_2.id)
    @invoice_4 = Invoice.create!(status: 2, customer_id: @customer_2.id)

    @ii_1 = InvoiceItem.create!(quantity: 10, unit_price: 10, status: 1, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @ii_2 = InvoiceItem.create!(quantity: 1, unit_price: 12, status: 2, item_id: @item_2.id, invoice_id: @invoice_2.id)
    @ii_3 = InvoiceItem.create!(quantity: 1, unit_price: 40, status: 0, item_id: @item_3.id, invoice_id: @invoice_3.id)
    @ii_4 = InvoiceItem.create!(quantity: 3, unit_price: 30, status: 2, item_id: @item_4.id, invoice_id: @invoice_4.id)

    @bd_1 = BulkDiscount.create!(quantity_threshold: 10, percent_discount: 20, merchant_id: @merchant_1.id)
    @bd_2 = BulkDiscount.create!(quantity_threshold: 15, percent_discount: 30, merchant_id: @merchant_1.id)
  end

  it 'shows the inovice id' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to have_content(@invoice_1.id)
  end

  it 'shows the invoice status' do
    visit merchant_invoice_path(@merchant_2, @invoice_3)

    expect(page).to have_content(@invoice_3.status)
    expect(page).to_not have_content(@invoice_1.status)
  end

  it 'shows created at date' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to have_content(@invoice_1.created_at.strftime('%A, %B %d, %Y'))
  end

  it 'shows customer first and last name' do
    visit merchant_invoice_path(@merchant_2, @invoice_4)

    expect(page).to have_content(@customer_2.first_name)
    expect(page).to have_content(@customer_2.last_name)
    expect(page).to_not have_content(@customer_1.first_name)
    expect(page).to_not have_content(@customer_1.last_name)
  end

  it 'shows item names' do
    visit merchant_invoice_path(@merchant_1, @invoice_2)

    expect(page).to have_content(@item_2.name)
    expect(page).to_not have_content(@item_3.name)
  end

  it 'shows item quantities' do
    visit merchant_invoice_path(@merchant_1, @invoice_2)

    expect(page).to have_content(@ii_2.quantity)
  end

  it 'shows item price' do
    visit merchant_invoice_path(@merchant_2, @invoice_3)

    expect(page).to have_content(@item_3.unit_price)
  end

  it 'shows invoice item status' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to have_content(@invoice_1.status)
    expect(page).to_not have_content(@invoice_3.status)
  end

  it 'shows total revenue for invoice' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to have_content(@ii_1.item_revenue)
  end

  it 'allows user to update item status' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to have_field(:status)
    expect(page).to have_button("Update Item Status")
  end

  it 'returns a user to the show page after updating invoice item status' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    select 'packaged', from: :status
    click_button "Update Item Status"

    expect(current_path).to eq(merchant_invoice_path(@merchant_1, @invoice_1)
)
  end

  describe 'bulk discounts' do
    it 'shows the total revenue for a merchant' do
      visit merchant_invoice_path(@merchant_1, @invoice_2)

      expect(page).to have_content("Total Revenue: $12")
    end

    it 'shows the total discounted revenue for a merchant' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      expect(page).to have_content("Total Revenue After Discounts: $80.0")
    end

    it 'has a link for each bulk discount applied' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      expect(page).to have_link("#{@bd_1.id}")
    end
  end
end