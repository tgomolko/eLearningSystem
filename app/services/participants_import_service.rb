class ParticipantsImportService
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def call
    import_participants
  end

  private

  def import_participants
    CSV.foreach(file.path, headers: true) do |row|
      PotentialOrganizationParticipant.find_or_create_by(email: row["email"])
    end
  end
end
