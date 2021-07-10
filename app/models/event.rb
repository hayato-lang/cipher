class Event < ApplicationRecord
  with_options presence: true do
    validates :content
    validates :event_data
  end
  belongs_to :admin_user
end
