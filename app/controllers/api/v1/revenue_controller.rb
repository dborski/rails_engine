class Api::V1::RevenueController < ActionController::API
  def index
    revenue = Merchant.revenue_by_date_range(params[:start], params[:end])
    json_object = {
        "data": {
          "id": nil,
          "attributes": {
            "revenue": revenue
          }
        }
      }

     render json: json_object
  end
end