class Event < ApplicationRecord
  with_options presence: true do
    validates :content
    validates :birthday
    belongs_to :admin_user
end
