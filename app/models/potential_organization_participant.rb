class PotentialOrganizationParticipant < ApplicationRecord
  validates :email, format: { with: /(\A([a-z]*\s*)*\<*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i }

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      PotentialOrganizationParticipant.find_or_create_by(email: row["email"])
    end
  end
end
