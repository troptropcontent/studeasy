class UserEmailAuthorisation < ApplicationRecord
  enum role: User.roles
end
