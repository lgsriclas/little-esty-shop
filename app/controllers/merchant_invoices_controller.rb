class MerchantInvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.distinct
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice_items = InvoiceItem.find_by(invoice_id: @invoice.id)
    @item = Item.find(@invoice_items.item_id)
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice_items = InvoiceItem.find_by(invoice_id: @invoice.id)
    @invoice_items.update(invoice_item_params)
    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end

  private
  def invoice_item_params
   params.permit(:status)
  end
end