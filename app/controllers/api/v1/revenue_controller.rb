class Api::V1::RevenueController < ActionController::API
  def index
    revenue = Merchant.revenue_by_date_range(params[:start], params[:end])
  end
end