class AddTransactionsCountToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :transactions_count, :integer
  end
end
