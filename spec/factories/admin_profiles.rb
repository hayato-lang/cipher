FactoryBot.define do
  factory :admin_profile do
    postal_code { Faker::Address.zip }
    prefecture_id {'24'}
    municipality {Faker::Address.city}
    address {Faker::Address.street_name}
    building_name {Faker::Address.street_address}
    phone_number {Faker::PhoneNumber.cell_phone}
    profile {Faker::Base.regexify}
    association :admin_user
    after(:build) do |admin|
      admin.admin_image.attach(io: File.open('public/images/test_admin_image.jpg'), filename: 'test_admin_image.jpg')
    end
  end
end

