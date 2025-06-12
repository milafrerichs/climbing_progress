FactoryBot.define do
  factory :climb_log do
    date { Faker::Date.in_date_period }
    route_name { Faker::Name.name }
    location { Faker::FunnyName.name }
    grade { Faker::Number.number(digits: 1) }
  end
end
