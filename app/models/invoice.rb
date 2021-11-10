class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  belongs_to :customer

  enum status: [:cancelled, :completed, 'in progress']

  def successful_transactions
    transactions.success
  end

  def top_selling_by_date
    joins(invoices: :invoice_items).select("invoices.created_at AS date, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue_by_day").group(:date).order(:revenue).first.date.strftime('%A, %B %d, %Y')
  end
end
