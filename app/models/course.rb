class Course < ApplicationRecord
  include AASM
  #include Elasticsearch::Model
  #include Elasticsearch::Model::Callbacks
  #include ElasticMyAnalyzer
  #include EsHelper

  ACCESS_STATE = %w{ Public Private Individual }

  belongs_to :user
  has_many :pages, dependent: :destroy
  has_many :user_answers, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :course_raiting, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  has_attached_file :attachment_pdf, { url: '/attachment_pdf/:id/:filename',
                                       path: "public/attachment_pdf/:id/:filename" }
  validates_attachment_content_type :attachment_pdf, content_type: ['application/pdf']
  validates :title, length: { maximum: 100 }, presence: true

  mount_uploader :image, ImageUploader

  aasm do
    state :draft, initial: true
    state :ready
    event :make_ready do
      transitions from: :draft, to: :ready
    end

    event :make_draft do
      transitions from: :ready, to: :draft
    end
  end

  # settings ES_SETTING do
  #   mappings dynamic: 'true' do
  #     indexes :title, type: 'text',  analyzer: 'english'
  #     indexes :description, type: 'text',  analyzer: 'english'
  #     indexes :created_at, type: 'keyword'
  #   end
  # end
end
