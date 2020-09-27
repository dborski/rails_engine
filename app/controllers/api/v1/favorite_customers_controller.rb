class Api::V1::FavoriteCustomersController < ApiBaseController

  def index
    customers = Customer.spent_at_merchant(params[:merchant_id], params[:quantity])
    binding.pry
    render_customer(customers)
  end 
end 