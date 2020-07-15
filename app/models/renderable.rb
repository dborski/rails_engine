module Renderable
  def render_revenue(revenue)
      {
        "data": {
          "id": nil,
          "attributes": {
            "revenue": revenue
          }
        }
      }
  end 
end