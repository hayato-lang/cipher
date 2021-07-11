FactoryBot.define do
  factory :event do
    name    {Faker::Music::Hiphop.groups}
    event_date { '2021-10-09 21:00:00' }
    content {Faker::Lorem.sentence}
    association :admin_user
    after(:build) do |event|
      event.event_image.attach(io: File.open('public/images/test_event_image.jpg'), filename: 'test_event_image.jpg')
    end
  end
end

