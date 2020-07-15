class Api::V1::RevenueController < ActionController::API
  def index
    json_object = {
        "data": {
          "id": nil,
          "attributes": {
            "revenue": Merchant.revenue_by_date_range(params[:start], params[:end])
          }
        }
      }

     render json: json_object
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    json_object = {
        "data": {
          "id": nil,
          "attributes": {
            "revenue": merchant.invoices.total_revenue
          }
        }
      }

     render json: json_object
  end 
end