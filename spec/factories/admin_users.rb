FactoryBot.define do
  factory :admin_user do
    store_name { 'KingsRaid' }
    email { Faker::Internet.free_email }
    password { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
  end
end
