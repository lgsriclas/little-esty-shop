class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
  enum status: [:disabled, :enabled]

  def revenue
    invoice_items.sum(&:item_revenue)
  end

  def self.ready_to_ship
    joins(:invoices).where("invoice_items.status != 2").order(created_at: :desc)
  end
end


