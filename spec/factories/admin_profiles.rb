FactoryBot.define do
  factory :admin_profile do
    postal_code { '123-4567' }
    prefecture_id { 24 }
    municipality { Faker::Address.city }
    address { Faker::Address.street_name }
    building_name { Faker::Address.street_address }
    phone_number { '09012345678' }
    profile { Faker::Lorem.sentence }
    association :admin_user

    after(:build) do |admin_profile|
      admin_profile.admin_image.attach(io: File.open('public/images/test_admin_image.jpg'),
                                       filename: 'test_admin_image.jpg')
    end
  end
end
