class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  #added the dependent to perform a cascade delete, where the comments get deleted along with a post when a post delete action is taken.
  has_many :comments, dependent: :destroy

  #added this to show posts in descending order chronologically
  default_scope { order('created_at DESC') }

  # ***assignment 27 additional scopes***

  #ordered by title
  scope :ordered_by_title, -> { order('title ASC')}

  #ordered by reverse created at
  scope :ordered_by_reverse_created_at, -> { order('created_at ASC')}



  #data validations
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
