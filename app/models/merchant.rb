class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def top_5
    items.select('items.name, items.id, sum(invoice_items.quantity * invoice_items.unit_price) as item_revenue')
    .joins(invoices: :transactions)
    .where(transactions: {result: 0})
    .order(item_revenue: :desc)
    .group(:id)
    .limit(5)
  end

  # def ready_to_ship
  #   items = items.select(:id).joins(:merchants).where(invoice_items: "status != 2").order(created_at: :desc).pluck(:item_id)
  #   items = InvoiceItem.joins(item: :merchant).where("invoice_items.status != 2").order(created_at: :desc).pluck(:item_id).pluck
  #   items = InvoiceItem.where("status != 2").order(created_at: :desc).pluck(:item_id)
  #   items.map do |id|
  #     Item.find(id)
  #   end
  # end

  def self.enabled?
    where(status: true)
  end

  def self.disabled?
    where(status: false)
  end

  def self.big_5
    joins(items: :invoice_items, invoices: :transactions)
    .where(transactions: {result: 0})
    .select("merchants.name, merchants.id, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .group(:id)
    .order(revenue: :desc)
    .limit(5)
  end

  def favorite_customers
    Customer.joins(invoices: [:transactions, [invoice_items: [item: [:merchant]]]]).select('customers.*, COUNT(transactions.id) as transaction_count').where(transactions: {result: 0}).where(merchants: {id: id}).group(:id).order(transaction_count: :desc).limit(5)
  end
end
