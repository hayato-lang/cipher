class Like < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true
  belongs_to :admin_user, optional: true
end
