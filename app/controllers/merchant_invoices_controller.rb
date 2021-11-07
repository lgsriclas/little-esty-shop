class MerchantInvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    @invoice = Invoice.find(params[:d])
    @invoice_items = InvoiceItem.find_by(invoice_id: @invoice.id)
    @item = Item.find(@invoice_items.item_id)
    @customer = Customer.find(@invoice.customer_id)
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.update(invoice_params)
    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end
end