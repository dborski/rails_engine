class Api::V1::ItemMerchantController < ActionController::API
  def index
    item = Item.find(params[:item_id])
    render json: MerchantSerializer.new(item.merchant)
  end
end
