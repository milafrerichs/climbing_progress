FactoryBot.define do
  factory :climb_log do
    date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    route_name { Faker::Name.name }
    location { Faker::FunnyName.name }
    grade { Faker::Number.non_zero_digit }
    sequence :status, %w[Flash Top Project].cycle
    sequence :climb_type, ClimbLog.climb_types.values.cycle
    user
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
