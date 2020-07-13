class Api::V1::Merchants::SearchController < ActionController::API
  def index
    merchants = Merchant.find_all(params[:name], params[:created_at], params[:updated_at])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find_one(params[:name], params[:created_at], params[:updated_at])
    render json: MerchantSerializer.new(merchant)
  end
end
