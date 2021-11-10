class Transaction < ApplicationRecord
  belongs_to :invoice
  enum result: [:success, :failed]

  def self.success
    where(result: 0).distinct
  end
end
