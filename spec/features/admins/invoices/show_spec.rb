require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page' do
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
    @invoice_5 = Invoice.create!(status: 1, customer_id: @customer_1.id)

    @ii_1 = InvoiceItem.create!(quantity: 1, unit_price: 10, status: 1, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @ii_2 = InvoiceItem.create!(quantity: 1, unit_price: 12, status: 2, item_id: @item_2.id, invoice_id: @invoice_2.id)
    @ii_3 = InvoiceItem.create!(quantity: 1, unit_price: 40, status: 0, item_id: @item_3.id, invoice_id: @invoice_3.id)
    @ii_4 = InvoiceItem.create!(quantity: 1, unit_price: 30, status: 2, item_id: @item_4.id, invoice_id: @invoice_4.id)
    @ii_5 = InvoiceItem.create!(quantity: 10, unit_price: 10, status: 0, item_id: @item_1.id, invoice_id: @invoice_5.id)

    @bd_1 = BulkDiscount.create!(quantity_threshold: 10, percent_discount: 20, merchant_id: @merchant_1.id)
    @bd_2 = BulkDiscount.create!(quantity_threshold: 15, percent_discount: 30, merchant_id: @merchant_1.id)
  end

  it 'displays an invoices attributes' do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_field(:status)
    expect(page).to have_content(@invoice_1.created_at.strftime('%A, %B %d, %Y'))
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
  end

  it 'displays the items and their attributes' do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@ii_1.quantity)
    expect(page).to have_content(@ii_1.status)
    expect(page).to have_content(@item_1.unit_price)
  end

  it 'lets users select a new invoice status' do
    visit "/admin/invoices/#{@invoice_2.id}"

    expect(page).to have_field(:status)
    expect(page).to have_button("Update Invoice Status")
  end

  it 'returns a user to the show page after updating invoice status' do
    visit "/admin/invoices/#{@invoice_2.id}"
    expect(@invoice_2.status).to eq("cancelled")

    select 'completed', from: :status
    click_button "Update Invoice Status"

    expect(current_path).to eq("/admin/invoices/#{@invoice_2.id}")
  end

  describe 'bulk discounts' do
    it 'shows the total revenue for a merchant' do
      visit "/admin/invoices/#{@invoice_5.id}"

      expect(page).to have_content("Total Revenue: $100")
    end

    xit 'shows the total discounted revenue for a merchant' do
      visit "/admin/invoices/#{@invoice_5.id}"

      expect(page).to have_content("Total Revenue After Discounts: $80.0")
    end
  end
end
