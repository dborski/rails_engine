class CustomerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :first_name, :last_name

  attribute :total_spent do |object|
    object.total_spent
  end 
end