class Organization < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :users#, foreign_key: "participant_org_id"
  has_many :courses
  validates :company_name, length: { maximum: 100 }, presence: true

  aasm do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions from: [:pending, :rejected], to: :approved
    end

    event :reject do
      transitions from: [:pending, :approved], to: :rejected
    end
  end
end
