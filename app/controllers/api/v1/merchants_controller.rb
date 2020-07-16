class Api::V1::MerchantsController < ApiBaseController
  def index
    render_merchants(Merchant.all)
  end

  def show
    render_merchants(Merchant.find(params[:id]))
  end

  def create
    render_merchants(Merchant.create(merchant_params))
  end

  def update
    render_merchants(Merchant.update(params[:id], merchant_params))
  end

  def destroy
    merchant = Merchant.find(params[:id])
    Merchant.destroy(params[:id])
    render_merchants(merchant)
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
