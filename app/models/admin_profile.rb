class AdminProfile < ApplicationRecord
  belongs_to :admin_user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank"} 
end
