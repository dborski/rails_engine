module Renderable
  def render_revenue(revenue)
    serialized = {
        "data": {
          "id": nil,
          "attributes": {
            "revenue": revenue
          }
        }
      }
    render json: serialized
  end 

  def render_merchants(merchants)
    render json: MerchantSerializer.new(merchants)
  end

  def render_items(items)
    render json: ItemSerializer.new(items)
  end
end