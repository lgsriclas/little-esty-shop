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

  def top_selling_by_date_by_merchant
    # joins(invoices: :invoice_items).select("invoices.created_at AS date, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue_by_day").group(:date).order(:revenue).first.date.strftime('%A, %B %d, %Y')

    Invoice.joins(invoice_items: :item, items: :merchant)
    .joins(:transactions)
    .where(transactions: {result: 0})
    .select("max(invoice_items.quantity * invoice_items.unit_price) AS best_date, invoices.updated_at AS date")
    .group(:id)
    .order(best_date: :desc)
    .limit(1)
    
  end
end
