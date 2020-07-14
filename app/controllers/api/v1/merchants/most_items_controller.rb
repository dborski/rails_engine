class Api::V1::Merchants::MostItemsController < ActionController::API
  def index
    merchants = Merchant.merchants_by_items_sold(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end
end