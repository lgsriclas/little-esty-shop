require 'rails_helper'

RSpec.describe 'merchant items index page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Larry's Lucky Ladles")
    @merchant_2 = Merchant.create!(name: "Sally's Silly Spoons")

    @item_1 = Item.create!(name: "Star Wars Ladle", description: "May the soup be with you", unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Sparkle Ladle", description: "Serve in style", unit_price: 12, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Green Ladle", description: "It is green", unit_price: 15, merchant_id: @merchant_1.id)
    @item_4 = Item.create!(name: "Purple Ladle", description: "It is purple", unit_price: 17, merchant_id: @merchant_1.id)
    @item_5 = Item.create!(name: "Yellow Ladle", description: "It is yellow", unit_price: 14, merchant_id: @merchant_1.id)
    @item_6 = Item.create!(name: "Orange Ladle", description: "It is orange", unit_price: 20, merchant_id: @merchant_2.id, status: 1)
    @item_7 = Item.create!(name: "Black Ladle", description: "It is black", unit_price: 5, merchant_id: @merchant_2.id)
    @item_8 = Item.create!(name: "Blue Ladle", description: "It is blue", unit_price: 5, merchant_id: @merchant_1.id)

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
    @ii_8 = InvoiceItem.create!(quantity: 5, unit_price: 5, status: 0, item_id: @item_8.id, invoice_id: @invoice_3.id)

    @transaction_1 = Transaction.create!(credit_card_number: "5522 3344 8811 7777", credit_card_expiration_date: "2025-05-17", result: 0, invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: "5555 4444 3333 2222", credit_card_expiration_date: "2023-02-11", result: 0, invoice_id: @invoice_1.id)
    @transaction_3 = Transaction.create!(credit_card_number: "5551 4244 3133 2622", credit_card_expiration_date: "2027-01-01", result: 0, invoice_id: @invoice_1.id)
    @transaction_4 = Transaction.create!(credit_card_number: "5775 4774 3373 2722", credit_card_expiration_date: "2030-07-22", result: 0, invoice_id: @invoice_2.id)
    @transaction_5 = Transaction.create!(credit_card_number: "5773 4374 4373 2622", credit_card_expiration_date: "2027-11-24", result: 0, invoice_id: @invoice_2.id)
    @transaction_6 = Transaction.create!(credit_card_number: "5235 2374 3233 2322", credit_card_expiration_date: "2023-03-23", result: 0, invoice_id: @invoice_2.id)
    @transaction_7 = Transaction.create!(credit_card_number: "5233 2322 3211 2300", credit_card_expiration_date: "2021-12-23", result: 1, invoice_id: @invoice_2.id)
  end

  it 'only shows the names of the merchant items' do
    visit merchant_items_path(@merchant_1)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)

    expect(page).not_to have_content(@item_6.name)
    expect(page).not_to have_content(@item_7.name)
  end

  it 'has item links that take the merchant to the item show page' do
    visit merchant_items_path(@merchant_2)

    expect(page).to have_link(@item_6.name)
    expect(page).to have_link(@item_7.name)

    within("#disable_status") do
      click_on("#{@item_6.name}")

      expect(current_path).to eq(merchant_item_path(@merchant_2, @item_6))
    end
  end

  it 'has a link to create a new item' do
    visit merchant_items_path(@merchant_1)

    expect(page).to have_link "Create New Item"
  end

  it 'returns user to merchant items index after creating new item' do
    visit merchant_items_path(@merchant_1)

    click_link "Create New Item"

    fill_in 'Name', with: 'Thor Ladle'
    fill_in 'Description', with: 'Perfectly Balanced'
    fill_in 'Unit price', with: 20
    click_on 'Create Item'

    expect(current_path).to eq(merchant_items_path(@merchant_1))
    expect(page).to have_content("Thor Ladle")
  end

  it 'has a button to disable or enable each item' do
    visit merchant_items_path(@merchant_2)

    within "#item-#{@item_6.id}" do
      click_on "Disable"

      item = Item.find(@item_6.id)
      expect(item.status).to eq("disabled")
    end

    within "#item-#{@item_7.id}" do
      click_button "Enable"

      item = Item.find(@item_7.id)
      expect(item.status).to eq("enabled")
    end

    expect(current_path).to eq(merchant_items_path(@merchant_2))
  end

  it 'has an enabled items section' do
    visit merchant_items_path(@merchant_2)

    within("#disable_status") do
      expect(page).to have_content(@item_6.name)
    end
  end

  it 'has a disabled items section' do
    visit merchant_items_path(@merchant_2)

    within("#enable_status") do
      expect(page).to have_content(@item_7.name)
    end
  end

  it "shows the top 5 items on the page" do
    visit merchant_items_path(@merchant_1)

    within("#top-5-#{@item_2.id}") do
      expect(page).to have_link(@item_2.name)
      expect(page).to have_content(@item_2.revenue)
      expect(page).not_to have_link(@item_1.name)
      expect(page).not_to have_link(@item_7.name)
    end

    within("#top-5-#{@item_3.id}") do
      expect(page).to have_link(@item_3.name)
      expect(page).to have_content(@item_3.revenue)
      expect(page).not_to have_link(@item_1.name)
      expect(page).not_to have_link(@item_7.name)
    end

    within("#top-5-#{@item_4.id}") do
      expect(page).to have_link(@item_4.name)
      expect(page).to have_content(@item_4.revenue)
      expect(page).not_to have_link(@item_1.name)
      expect(page).not_to have_link(@item_7.name)
    end

    within("#top-5-#{@item_5.id}") do
      expect(page).to have_link(@item_5.name)
      expect(page).to have_content(@item_5.revenue)
      expect(page).not_to have_link(@item_1.name)
      expect(page).not_to have_link(@item_7.name)
    end

    within("#top-5-#{@item_1.id}") do
      expect(page).to have_link(@item_1.name)
      expect(page).to have_content(@item_1.revenue)
      expect(page).not_to have_link(@item_6.name)
      expect(page).not_to have_link(@item_7.name)
    end
  end
end