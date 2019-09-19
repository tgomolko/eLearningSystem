class Course < ApplicationRecord
  include AASM

  ACCESS_STATE = %w{ Public Private Individual }
  
  belongs_to :user
  has_many :pages, dependent: :destroy 
  has_many :user_answers, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  validates :title, length: { maximum: 100 }, presence: true
  mount_uploader :image, ImageUploader

  aasm do
    state :draft, initial: true
    state :ready

    event :make_ready do
      transitions from: :draft, to: :ready
    end

    event :make_draft do
      transitions from: :ready, to: :draft
    end
  end
end
