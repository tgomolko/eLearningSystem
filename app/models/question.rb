class Question < ApplicationRecord
  belongs_to :page
  has_many :user_answers, dependent: :destroy

  enum question_type: [:textbox, :radio, :checkbox]
end
