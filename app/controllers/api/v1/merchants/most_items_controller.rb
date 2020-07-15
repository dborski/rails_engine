class Api::V1::Merchants::MostItemsController < ApiBaseController
  def index
    merchants = Merchant.merchants_by_items_sold(params[:quantity])
    render_merchants(merchants)
  end
end