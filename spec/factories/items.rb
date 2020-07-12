FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Item #{n}" }
    description { Faker::TvShows::DumbAndDumber.quote }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    merchant
  end
end
