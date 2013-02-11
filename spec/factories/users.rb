FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@example.com"
    end

    password "secret_password"
    password_confirmation "secret_password"

    trait :confirmed do
      confirmed_at 5.minutes.ago
    end
  end
end
