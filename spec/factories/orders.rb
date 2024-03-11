FactoryBot.define do
  factory :order do
    association(:product)
  end
end
