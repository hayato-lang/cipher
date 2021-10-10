class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  PASSWORD_REGGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGGEX
  validates :store_name, presence: true
  
  has_many :likes, dependent: :destroy
  has_many :liked_events, through: :likes, source: :event
  has_many :events
  has_one :admin_profile

  def liked_by?(event_id)
    likes.where(event_id: event_id).exists?
  end
end
