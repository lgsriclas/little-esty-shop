# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

merchant = Merchant.create!(name: "Larry's Lucky Ladles")
customer = Customer.create!(first_name: "Sally", last_name: "Brown")
invoice_1 = customer.invoices.create!(status: 1)
item_1 = merchant.items.create!(name: "Star Wars Ladle", description: "May the soup be with you", unit_price: 10)
ii_1 = InvoiceItem.create!(quantity: 10, unit_price: 10, status: 1, item_id: item_1.id, invoice_id: invoice_1.id)
bd_1 = merchant.bulk_discounts.create!(quantity_threshold: 10, percent_discount: 20)
