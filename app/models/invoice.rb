class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchant
  belongs_to :customer

  enum status: [:cancelled, :completed, 'in progress']

  def successful_transactions
    transactions.success
  end

  def top_selling_by_date
    joins(invoices: :invoice_items)
    .select("invoices.created_at AS date, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue_by_day")
    .group(:date)
    .order(:revenue)
    .first.date.strftime('%A, %B %d, %Y')
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def self.ordered_incomplete_invoices
    incomplete_invoices_ids = InvoiceItem.incomplete_invoices
    Invoice.where(id: incomplete_invoices_ids).order(created_at: :asc).pluck(:id, :created_at)
  end
end
