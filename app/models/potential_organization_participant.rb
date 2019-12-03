class PotentialOrganizationParticipant < ApplicationRecord
  validates :email, format: { with: /(\A([a-z]*\s*)*\<*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i }
  scope :not_invited, -> { where(invited: false) }
end
