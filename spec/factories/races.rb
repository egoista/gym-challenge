FactoryBot.define do
  factory :race do
    skip_create
    initialize_with { new }
  end
end
