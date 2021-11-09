class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def top_5
    items.top_5_by_revenue
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
end
