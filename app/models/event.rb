class Event < ApplicationRecord
  has_many :comments
  belongs_to :admin_user
  has_one_attached :event_image
  with_options presence: true do
    validates :name
    validates :content
    validates :event_date
    validates :event_image
  end
  validate :day_after_today

  def self.search(search)
    if search != ""
      Event.where('name LIKE(?)', "%#{search}%")      
    else
      Event.all
    end
  end

  def day_after_today
    errors.add(:event_date, '明日以降の日付を入力してください') if !event_date.nil? && (event_date <= Date.today)
  end
end
