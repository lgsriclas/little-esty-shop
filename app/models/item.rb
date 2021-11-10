class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def revenue
    invoice_items.sum(&:item_revenue)
  end

  def self.ready_to_ship
          joins(:invoice_items)
          .where.not(invoice_items: {status: 2})
          .pluck(:id)
  end
end
