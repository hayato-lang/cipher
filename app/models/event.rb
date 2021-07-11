class Event < ApplicationRecord
  belongs_to :admin_user
  has_one_attached :event_image
  with_options presence: true do
    validates :content
    validates :event_date
    validates :event_image
  end
end
