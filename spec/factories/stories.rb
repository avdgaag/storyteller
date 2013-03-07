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

    trait :attached do
      ignore do
        attachments_count 1
      end

      after :create do |story, evaluator|
        FactoryGirl.create_list(:attachment, evaluator.attachments_count, attachable: story)
      end
    end
  end
end
