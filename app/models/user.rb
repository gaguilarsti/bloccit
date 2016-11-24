class User < ActiveRecord::Base
  has_many :posts

  # register an inline callback directly after the before_save callback.
  before_save { self.email = email.downcase if email.present? }

  # use Ruby's validates function to ensure that name is present and a max and min length.
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  # validates password with two validations:
  #1. only executes if password_digest is nil, which ensures when we create a new user, they have a valid password.
  #2. Ensures that when updating a user's password, the updated pw is also 6 characters long.  allow_blank:true skips the validation if no update password is given.  This allows us to change other attributes on a user without being forced to set the password.
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true

  # validate that email is present, unique, case insensitive and has a min and max length and properly formatted.
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  # Using Ruby's has_secure_password method - adds methods to set and authenticate against a BCrypt password.  This mechanism requries you to have a password_digest attribute.  Note - to use this, we needed to install BCrypt gem.
  has_secure_password

end
