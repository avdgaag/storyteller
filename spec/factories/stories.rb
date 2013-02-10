FactoryGirl.define do
  factory :story do
    title 'My example story'
    body 'Lorem ipsum dolor sit amet'

    factory :invalid_story do
      title ''
    end
  end
end
