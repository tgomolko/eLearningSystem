class User < ApplicationRecord
  has_many :organizations
  has_many :courses, dependent: :destroy
  has_many :user_answers, dependent: :destroy
  has_many :user_pages, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :relationships, source: :followed 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
end
