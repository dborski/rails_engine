module Renderable
  def render_revenue(revenue)
    revenue_info = revenue.to_json
    parsed = JSON.parse(revenue_info)

    if parsed.class == Float
      revenue = parsed
    else 
      revenue =  parsed.first['revenue']
    end 

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

  def render_customers(customers)
    render json: CustomerSerializer.new(customers)
  end
end