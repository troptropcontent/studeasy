class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :assessments

  enum role: { student: 0, buddy: 1, admin: 2 }

  validate :email_authorisations

  private

  def email_authorisations
    return if student? || UserEmailAuthorisation.send(role).exists?(email: email)

    errors.add(:email, "This email is not a valid #{role} email")
  end
end
