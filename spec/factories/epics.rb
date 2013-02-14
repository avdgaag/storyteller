FactoryGirl.define do
  factory :epic do
    title 'My custom epic'
    body 'Lorem ipsum dolor sit amet'
    association :author, factory: :user

    trait :invalid do
      title nil
      author nil
    end
  end
end
