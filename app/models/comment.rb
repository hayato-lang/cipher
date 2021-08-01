class Comment < ApplicationRecord
  belongs_to :event
  validates :text, presence: true
end
