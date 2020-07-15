class Api::V1::MerchantItemsController < ApiBaseController
  def index
    merchant = Merchant.find(params[:merchant_id])
    render_items(merchant.items)
  end
end
