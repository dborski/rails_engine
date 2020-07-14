class Api::V1::Merchants::MostRevenueController < ActionController::API
  def index
    merchants = Merchant.merchants_by_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end
end