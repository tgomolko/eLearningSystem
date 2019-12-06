class Page < ApplicationRecord
  validates :title, length: { maximum: 200 }, presence: true

  has_many :questions, dependent: :destroy
  has_many :user_pages, dependent: :destroy
  belongs_to :course
end
