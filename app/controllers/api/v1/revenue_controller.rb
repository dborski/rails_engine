class Api::V1::RevenueController < ActionController::API
  include Renderable

  def index
    render json: render_revenue(Merchant.revenue_by_date_range(params[:start], params[:end]))
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    render json: render_revenue(merchant.invoices.total_revenue)
  end 
end