FactoryGirl.define do
  factory :story do
    title 'My example story'
    body 'Lorem ipsum dolor sit amet'
    project

    factory :invalid_story do
      title ''
    end

    trait :incomplete do
      completed_at nil
    end

    trait :completed do
      completed_at { 5.minutes.ago }
    end
  end
end
