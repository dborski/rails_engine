class Api::V1::ItemMerchantController < ApiBaseController
  def index
    item = Item.find(params[:item_id])
    render_merchants(item.merchant)
  end
end
