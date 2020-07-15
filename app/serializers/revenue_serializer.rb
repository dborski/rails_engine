class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  
    attribute :revenue do |object|
      object.revenue_by_date_range
    end 
end 