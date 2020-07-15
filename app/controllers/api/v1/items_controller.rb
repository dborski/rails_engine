class Api::V1::ItemsController < ApiBaseController
  def index
    render_items(Item.all)
  end

  def show
    render_items(Item.find(params[:id]))
  end

  def create
    item = Item.create(item_params)
    render_items(item)
  end

  def update
    render_items(Item.update(params[:id], item_params))
  end

  def destroy
    item = Item.find(params[:id])
    Item.delete(params[:id])
    render_items(item)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
