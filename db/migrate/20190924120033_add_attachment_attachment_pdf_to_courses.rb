class AddAttachmentAttachmentPdfToCourses < ActiveRecord::Migration[5.2]
  def self.up
    change_table :courses do |t|
      t.attachment :attachment_pdf
    end
  end

  def self.down
    remove_attachment :courses, :attachment_pdf
  end
end
