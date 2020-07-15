class Api::V1::Items::SearchController < ApiBaseController
  def index
    items = Item.find_all(params[:name], params[:description], params[:unit_price], params[:merchant_id], params[:created_at], params[:updated_at])
    render_items(items)
  end

  def show
    item = Item.find_one(params[:name], params[:description], params[:unit_price], params[:merchant_id], params[:created_at], params[:updated_at])
    render_items(item)
  end
end
