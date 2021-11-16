require 'rails_helper'

RSpec.describe Invoice, type: :model do
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
    @invoice_5 = Invoice.create!(status: 1, customer_id: @customer_1.id)

    @ii_1 = InvoiceItem.create!(quantity: 5, unit_price: 10, status: 0, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @ii_2 = InvoiceItem.create!(quantity: 5, unit_price: 12, status: 2, item_id: @item_2.id, invoice_id: @invoice_1.id)
    @ii_3 = InvoiceItem.create!(quantity: 5, unit_price: 15, status: 0, item_id: @item_3.id, invoice_id: @invoice_2.id)
    @ii_4 = InvoiceItem.create!(quantity: 5, unit_price: 17, status: 2, item_id: @item_4.id, invoice_id: @invoice_2.id)
    @ii_5 = InvoiceItem.create!(quantity: 5, unit_price: 14, status: 0, item_id: @item_5.id, invoice_id: @invoice_1.id)
    @ii_6 = InvoiceItem.create!(quantity: 5, unit_price: 20, status: 2, item_id: @item_6.id, invoice_id: @invoice_1.id)
    @ii_7 = InvoiceItem.create!(quantity: 5, unit_price: 5, status: 0, item_id: @item_7.id, invoice_id: @invoice_2.id)
    @ii_8 = InvoiceItem.create!(quantity: 10, unit_price: 5, status: 2, item_id: @item_1.id, invoice_id: @invoice_5.id)
    @ii_9 = InvoiceItem.create!(quantity: 5, unit_price: 5, status: 2, item_id: @item_2.id, invoice_id: @invoice_5.id)

    @transaction_1 = Transaction.create!(credit_card_number: "5522 3344 8811 7777", credit_card_expiration_date: "2025-05-17", result: 0, invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: "5555 4444 3333 2222", credit_card_expiration_date: "2023-02-11", result: 0, invoice_id: @invoice_1.id)
    @transaction_3 = Transaction.create!(credit_card_number: "5551 4244 3133 2622", credit_card_expiration_date: "2027-01-01", result: 0, invoice_id: @invoice_1.id)
    @transaction_4 = Transaction.create!(credit_card_number: "5775 4774 3373 2722", credit_card_expiration_date: "2030-07-22", result: 0, invoice_id: @invoice_2.id)
    @transaction_5 = Transaction.create!(credit_card_number: "5773 4374 4373 2622", credit_card_expiration_date: "2027-11-24", result: 0, invoice_id: @invoice_2.id)
    @transaction_6 = Transaction.create!(credit_card_number: "5235 2374 3233 2322", credit_card_expiration_date: "2023-03-23", result: 0, invoice_id: @invoice_2.id)
    @transaction_7 = Transaction.create!(credit_card_number: "5233 2322 3211 2300", credit_card_expiration_date: "2021-12-23", result: 1, invoice_id: @invoice_2.id)

    @bd_1 = BulkDiscount.create!(quantity_threshold: 10, percent_discount: 20, merchant_id: @merchant_1.id)
    @bd_2 = BulkDiscount.create!(quantity_threshold: 15, percent_discount: 30, merchant_id: @merchant_1.id)
  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many :invoice_items}
    it {should have_many :transactions}
  end

  describe 'class methods' do
    it 'can return successful transactions' do
      expect(@invoice_1.successful_transactions).to eq([@transaction_1, @transaction_2, @transaction_3])
    end
  end

  describe 'instance methods' do
    it 'can order_incomplete_invoices and return a nested array [[id1, created_at1], [id2, created_at2]]' do
      expect(Invoice.ordered_incomplete_invoices).to eq([[@invoice_1.id, @invoice_1.created_at], [@invoice_2.id, @invoice_2.created_at]])
    end
  end

  describe 'bulk discounts' do
    it 'can calculate total revenue for a merchant' do
      expect(@invoice_5.total_revenue).to eq(75)
      expect(@invoice_1.total_revenue).to eq(280)
    end

    it 'can calculate total discounted revenue for a merchant' do
      expect(@invoice_5.discounted_revenue).to eq(65)
    end
  end
end