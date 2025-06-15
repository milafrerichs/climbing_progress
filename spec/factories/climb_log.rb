FactoryBot.define do
  factory :climb_log do
    date { Faker::Date.in_date_period }
    route_name { Faker::Name.name }
    location { Faker::FunnyName.name }
    grade { Faker::Number.non_zero_digit }
    sequence :status, %w[Flash Top Project].cycle
    tries {
      if status == 'Flash'
        1
      elsif status == 'Project'
        rand(6..10)
      elsif status == 'Top'
        rand(2..5)
      else
        10
      end
    }
    trait :today do
      date { DateTime.now }
    end
    trait :yesterday do
      date { 1.days.ago }
    end
    trait :flash do
      status { "Flash" }
      tries { 1 }
    end
  end
end
