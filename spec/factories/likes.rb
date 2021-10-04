FactoryBot.define do
  factory :like do
    association :user
    association :event
    user { event.user }
  end
end
