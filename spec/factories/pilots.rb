FactoryBot.define do
  factory :pilot do
    code { '1' }
    name { Faker::Name.first_name }
    race

    skip_create
    initialize_with { new(attributes) }

    trait :with_laps_with_fixed_times do
      after(:build) do |pilot, _evaluator|
        (1..4).each do |n|
          build(:lap, number: n, pilot: pilot, duration: 60.0, average_speed: 60.0, finish_time: 3600.00)
        end
      end
    end
  end
end
