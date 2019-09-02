class Organization < ApplicationRecord
  belongs_to :user
  validates :company_name, :length => {:maximum => 100}, presence: true
end
