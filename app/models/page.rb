class Page < ApplicationRecord
  belongs_to :course
  has_many :questions, dependent: :destroy 
end