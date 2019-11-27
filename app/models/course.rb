class Course < ApplicationRecord
  include AASM

  ACCESS_STATE = %w{ Public Individual }.freeze
  ACCESS_STATE_FOR_ORG_USERS = %w{ Public Private Individual }.freeze

  belongs_to :user
  has_many :pages, dependent: :destroy
  has_many :user_answers, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :course_raitings, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :tinymce_images, as: :owner

  has_attached_file :attachment_pdf, { url: '/attachment_pdf/:id/:filename',
                                       path: "public/attachment_pdf/:id/:filename" }

  validates_attachment_content_type :attachment_pdf, content_type: ['application/pdf']
  validates :title, length: { maximum: 100 }, presence: true

  mount_uploader :image, ImageUploader

  aasm do
    state :draft, initial: true
    state :ready
    event :ready do
      transitions from: :draft, to: :ready
    end

    event :draft do
      transitions from: :ready, to: :draft
    end
  end
end
