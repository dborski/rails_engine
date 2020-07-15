class Api::V1::Merchants::MostRevenueController < ApiBaseController
  def index
    merchants = Merchant.merchants_by_revenue(params[:quantity])
    render_merchants(merchants)
  end
end