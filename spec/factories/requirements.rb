FactoryGirl.define do
  factory :requirement do
    title 'Example requirement'
    story

    trait :pending do
      completed_at nil
    end

    trait :done do
      completed_at { 5.minutes.ago }
    end
  end
end
