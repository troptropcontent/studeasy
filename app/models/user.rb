class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  ALLOWED_ADMIN_EMAIL = %w[assessmentcopilot@gmail.com].freeze

  has_many :assessments

  enum role: { student: 0, buddy: 1, admin: 2 }

  validates :email, inclusion: { in: ALLOWED_ADMIN_EMAIL, message: '%{value} is not a valid admin email' }, if: :admin?
end
