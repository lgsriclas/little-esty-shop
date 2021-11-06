class AdminsController < ApplicationController
  def dashboard
    @customers = Customer.all
    @top_customers = Customer.top_5.map {|customer| customer.attributes}
  end
end
