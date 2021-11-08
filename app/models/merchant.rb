class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def top_5
    wip = items.select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoice_items, invoices: :transactions)
    .where(transactions: {result: 0})
    .group(:id)
    .order(revenue: :desc)
    .limit(5)
  end
  
  def self.enabled?
    where(status: true)
  end

  def self.disabled?
    where(status: false)
  end
end
