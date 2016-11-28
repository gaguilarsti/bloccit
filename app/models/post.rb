class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  #added the dependent to perform a cascade delete, where the comments get deleted along with a post when a post delete action is taken.
  has_many :comments, dependent: :destroy

  #added for relationshp with votes
  has_many :votes, dependent: :destroy

  #added this to show posts in descending order chronologically
  default_scope { order('created_at DESC') }

  #data validations
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  #logic for votes
  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    # note that votes below is an implied (or equal to) self.votes
    votes.sum(:value)
  end

end
