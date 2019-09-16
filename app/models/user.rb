class User < ApplicationRecord
  has_many :organizations
  has_many :courses, dependent: :destroy
  has_many :user_answers, dependent: :destroy 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:admin, :user, :org_admin]
end
