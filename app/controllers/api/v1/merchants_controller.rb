class Api::V1::MerchantsController < ActionController::API
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    merchant = Merchant.create(merchant_params)
    render json: MerchantSerializer.new(merchant)
  end

  def update
    render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params))
  end

  def destroy
    merchant = Merchant.find(params[:id])
    Merchant.destroy(params[:id])
    render json: MerchantSerializer.new(merchant)
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
