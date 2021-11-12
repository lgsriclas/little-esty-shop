class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def top_5
    items.select('items.name, items.id, sum(invoice_items.quantity * invoice_items.unit_price) as item_revenue')
    .joins(invoice_items: [invoice: [:transactions]])
    .where(transactions: {result: 0})
    .order(item_revenue: :desc)
    .group(:id)
    .limit(5)
  end

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

  def best_date
    invoices.joins(:invoice_items, :transactions)
    .where(transactions: {result: 0})
    .select('invoices.updated_at AS date, max(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .group(:id)
    .order(revenue: :desc)
    .limit(1)
    .first
    .date.strftime('%A, %B %d, %Y')
  end
end
