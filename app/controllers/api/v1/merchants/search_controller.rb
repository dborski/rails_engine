class Api::V1::Merchants::SearchController < ApiBaseController
  def index
    merchants = Merchant.find_all(params[:id], params[:name], params[:created_at], params[:updated_at])
    render_merchants(merchants)
  end

  def show
    merchant = Merchant.find_one(params[:id], params[:name], params[:created_at], params[:updated_at])
    render_merchants(merchant)
  end
end
