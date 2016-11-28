require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }

  # create a parent topic for post.
  let(:topic) { Topic.create!(name: name, description: description) }

  #we create a user to associate with a test post.
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }

  # associate post with a topic via topic.posts.create!.  This is a chained method call which creates a post for a given topic.
  # added the user attribute at the end when we wanted to associate users to posts.
  let(:post) { topic.posts.create!(title: title, body: body, user: user) }

  # testing to make sure posts are allowed to have many comments
  it { is_expected.to have_many(:comments) }
  
  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }


  # data validations
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }
  # Test whether post has attributes named title and body.  Tests whether post will return a non-nil value when post.title and post.body is called.
  describe "attributes" do
    it "has title, body and user attributes" do
      expect(post).to have_attributes(title: title, body: body, user: user)
    end
  end
end
