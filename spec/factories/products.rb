FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    price_cents { SecureRandom.random_number(10000) }
    age_low_weeks { 0 }
    age_high_weeks { 12 }
  end
end
