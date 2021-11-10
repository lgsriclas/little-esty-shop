class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
  enum status: [:disabled, :enabled]

  def revenue
    invoice_items.sum(&:item_revenue)
  end
end


