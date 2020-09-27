class Api::V1::FavoriteCustomersController < ApiBaseController

  def index
    render_customers(Customer.spent_at_merchant(params[:merchant_id], params[:quantity]))
  end 
end 