class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  PASSWORD_REGGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGGEX
  validates :nickname, presence: true
  has_many :comments, dependent: :destroy
  has_many :events
  has_many :likes, dependent: :destroy
  has_many :liked_events, through: :likes, source: :event

  def liked_by?(event_id)
    likes.where(event_id: event_id).exists?
  end
end
