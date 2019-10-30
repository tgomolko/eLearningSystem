class Email < ApplicationRecord
  validates :email, format: { with: /(\A([a-z]*\s*)*\<*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i }

  def self.import(file)
    return unless file.content_type == "text/csv"
    CSV.foreach(file.path, headers: true) do |row|
      email = find_by(email: row["email"]) || new
      email.attributes = row.to_hash
      email.save
    end
  end
end
