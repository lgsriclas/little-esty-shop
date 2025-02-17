class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant
  enum status: [:packaged, :pending, :shipped]

  def item_revenue
    quantity * unit_price
  end

  def discount
    bulk_discounts
    .where('quantity_threshold <= ?', "#{self.quantity}")
    .order(percent_discount: :desc).first

    # joins(merchant: :bulk_discounts)
    # .select("bulk_discounts.percent_discount AS percent")
    # .order(percent: :desc)
    # .where('quantity_threshold <= ?', "#{self.quantity}").first
  end

  def revenue
    if discount == nil
      unit_price * quantity
    else
      unit_price * quantity * (1 - (discount.percent_discount.to_f / 100))
    end
  end

  def self.item_revenue
    revenue = group(:item_id).sum('quantity * unit_price')
    revenue.sort_by{ |_, v| -v }.to_h.keys
  end

  def self.incomplete_invoices
    incomplete_invoices = InvoiceItem.select('invoice_items.*')
    .where("status = 0 OR status = 1")
    .distinct.order(invoice_id: :asc)
    .pluck(:invoice_id)
    if incomplete_invoices == nil
      incomplete_invoices = []
    end
    incomplete_invoices
  end

end
