class AdminProfile < ApplicationRecord
  belongs_to :admin_user
  has_one_attached :admin_image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  with_options presence: true do
    validates :store_name
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank"}
    validates :municipality
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :profile
    validates :admin_image
  end
end
