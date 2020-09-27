class Api::V1::RevenueController < ApiBaseController
  def index
    render_revenue(Merchant.revenue_by_date_range(params[:start], params[:end]))
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    render_revenue(merchant.invoices.total_revenue)
  end 
end