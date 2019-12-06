class Course < ApplicationRecord
  include AASM

  ACCESS_STATE = %w{ Public Individual }.freeze
  ACCESS_STATE_FOR_ORG_USERS = %w{ Public Private Individual }.freeze

  scope :higest_rated, -> { where(id: CourseRaiting.all.order(:rate).pluck(:course_id)) }
  scope :organizations, -> { where.not(organization_id: nil) }
  scope :not_organizations, -> { where(organization_id: nil) }

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

  def avg_rate
    course_raitings.average(:rate).to_i
  end

  def has_any_rate?
    course_raitings.any?
  end

  def percent_of_progess(current_user)
    course_pages_ids = pages.pluck(:id)
    return 100 if course_pages_ids.empty?
    completed_pages_size = current_user.user_pages.where(page_id: course_pages_ids).size
    ((completed_pages_size.to_f / pages.size) * 100).round
  end

  def favorite?(current_user)
    current_user.bookmarks.find_by(course_id: id)
  end
end
