class Post < ActiveRecord::Base
  belongs_to :topic
  #added the dependent to perform a cascade delete, where the comments get deleted along with a post when a post delete action is taken.
  has_many :comments, dependent: :destroy
end
