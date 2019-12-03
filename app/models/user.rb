class User < ApplicationRecord
  has_one :organization, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :user_answers, dependent: :destroy
  has_many :user_pages, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :relationships, source: :followed
  has_many :course_raitings, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_messageable

  enum role: [:admin, :user, :org_admin]

  def follow(course)
    following << course
  end

  def unfollow(course)
    following.delete(course)
  end

  def following?(course)
    following.include?(course)
  end

  def mailboxer_email(object)
    email
  end

  def rated_course?(course)
    course_raitings.where(course_id: course.id).any?
  end

  def org_member?
    organization_id || participant_org_id
  end

  def completed_course?(course)
    user_courses.where(course_id: course.id).any?
  end

  def completed_all_course_pages?(course)
    course_pages_ids = course.pages.pluck(:id)
    return false if course_pages_ids.empty?
    course_pages_ids.size == user_pages.where(page_id: course_pages_ids).size
  end
end
