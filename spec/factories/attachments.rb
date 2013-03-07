include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :attachment do
    association :attachable, factory: :story
    user
    file { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'image.jpg'), 'image/jpeg') }
  end
end
