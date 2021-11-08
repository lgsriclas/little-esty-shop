class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_5_items = @merchant.top_5
  end

  def show
    @item = Item.find(params[:id])
  end
end
