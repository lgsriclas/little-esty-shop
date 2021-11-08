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
  
  def self.enabled?
    where(status: true)
  end

  def self.disabled?
    where(status: false)
  end
end
