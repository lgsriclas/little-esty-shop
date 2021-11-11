class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
  enum status: [:disabled, :enabled]

  def revenue
    invoice_items.sum(&:item_revenue)
  end

  def best_item_date
    invoice_items.joins(invoice: :transactions)
    .where(transactions: {result: 0})
    .select('invoices.updated_at AS date, max(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .group(:date)
    .order(revenue: :desc)
    .limit(1)
    .first
    .date.strftime('%A, %B %d, %Y')
  end
  
  def self.ready_to_ship
    joins(:invoices)
    .select("items.name, invoices.id as id, invoices.created_at as created_at")
    .where("invoice_items.status != 2")
    .order(created_at: :desc)
  end
end
