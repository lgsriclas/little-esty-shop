class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @disabled_items = @merchant.items.where(status: 0)
    @enabled_items = @merchant.items.where(status: 1)
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "Successfully Updated Information"
      redirect_to merchant_item_path(@merchant, @item)
    else
      flash[:alert] = "Error: #{error_message(@item.errors)}"
      redirect_to edit_merchant_item_path(@merchant, @item)
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    Item.create!(item_params)
    redirect_to merchant_items_path(@merchant)
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
