require 'rails_helper'

RSpec.describe Post, type: :model do
  #using the let method to create a new instance of the Post class and named it post.
  #Let dynamically defines a method and upon first call within a spec, computes and stores the returned value.

  let(:post) {Post.create!(title: "New Post Title", body: "New Post Body")}
  # Test whether post has attributes named title and body.  Tests whether post will return a non-nil value when post.title and post.body is called.
  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
    end
  end
end
