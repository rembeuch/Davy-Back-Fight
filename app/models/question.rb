class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  mount_uploader :photo, PhotoUploader
end
