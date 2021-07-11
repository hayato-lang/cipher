class Event < ApplicationRecord
  belongs_to :admin_user
  has_one_attached :event_image
  with_options presence: true do
    validates :content
    validates :event_date
    validates :event_image
  end
  validate :day_after_today
  def day_after_today
    unless event_date == nil
      errors.add(:event_date, "明日以降の日付を入力してください") if event_date <= Date.today
    end
  end

end
