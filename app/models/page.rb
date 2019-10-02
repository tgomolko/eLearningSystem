class Page < ApplicationRecord
  belongs_to :course, counter_cache: true
  has_many :questions, dependent: :destroy 
  has_many :user_pages, dependent: :destroy
end
