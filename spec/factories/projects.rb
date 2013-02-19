FactoryGirl.define do
  factory :project do
    title  'My new project'
    description 'Lorem ipsum'
    association :owner, factory: :user

    trait :invalid do
      title ''
      description ''
      owner nil
    end
  end
end
