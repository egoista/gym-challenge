FactoryBot.define do
  factory :lap do
    sequence(:number) { |n| n }
    duration { Faker::Number.decimal(3, 3).to_f }
    average_speed { Faker::Number.decimal(2, 3).to_f }
    finish_time { Faker::Number.decimal(6, 3).to_f }
    pilot

    skip_create
    initialize_with { new(attributes) }
  end
end
