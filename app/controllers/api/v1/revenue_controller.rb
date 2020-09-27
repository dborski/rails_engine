class Api::V1::RevenueController < ApiBaseController
  def index
    render_revenue(Merchant.revenue_by_date_range(params[:start], params[:end]))
  end

  def show
    if params[:quantity]
      customers = Customer.spent_at_merchant(params[:merchant_id], params[:quantity])
      binding.pry
      render_customer(customers)
    else 
      merchant = Merchant.find(params[:merchant_id])
      render_revenue(merchant.invoices.total_revenue)
    end 
  end 
end