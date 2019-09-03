class Organization < ApplicationRecord
  include AASM
  
  belongs_to :user
  validates :company_name, length: { maximum: 100 }, presence: true

  aasm do
    state :pending
    state :approved, initial: true
    state :rejected 

    event :approve do
      transitions from: :pending, to: :approved
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end
  end
end
