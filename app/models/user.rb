class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :user_answers
  has_many :orders

  mount_uploader :avatar, PhotoUploader

  validates :email, uniqueness: true
  validates :pseudo, uniqueness: true
end
