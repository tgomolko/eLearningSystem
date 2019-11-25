class Page < ApplicationRecord
  belongs_to :course
  has_many :questions, dependent: :destroy
  has_many :user_pages, dependent: :destroy
end
