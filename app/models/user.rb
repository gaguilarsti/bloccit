class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :votes, dependent: :destroy

  has_many :favorites, dependent: :destroy


  # register an inline callback directly after the before_save callback.
  before_save { self.email = email.downcase if email.present? }

  # added to use the role column as an enum and below 'enum role: [:member, :admin]'
  before_save { self.role ||= :member }

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

  #added to use the role column as an enum
  enum role: [:member, :admin]

  #added for favorites
  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end

  #added for gravatar
  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

end
