require 'rails_helper'
include SessionsHelper

RSpec.describe FavoritesController, type: :controller do
  let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let (:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }

  context 'guest user' do
    describe 'POST create' do
      it 'redirects the user to the sign in view' do
        post :create, {post_id: my_post.id}
        # redirect guests to sign up if they are trying to favorite a post.
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe 'DELETE destroy' do
      it 'redirects the user to the sign in view' do
        favorite = my_user.favorites.where(post: my_post).create
        delete :destroy, { post_id: my_post.id, id: favorite.id }
        expect(response).to redirect_to(new_session_path)
      end
    end

  end

  context 'signed in user' do
    before do
      create_session(my_user)
    end

    describe 'POST create' do
      # expect that after a user favorites a post, we redirect them to the show view of that post.
      it 'redirects to the posts show view' do
        post :create, { post_id: my_post.id }
        expect(response).to redirect_to([my_topic, my_post])
      end

      it "creates a favorite for the current user and specified post" do
        #initially expect that no favorites exist for the user and post.
        expect(my_user.favorites.find_by_post_id(my_post.id)).to be_nil
        post :create, { post_id: my_post.id }
        #expect that after a user has favorited a post, they will have a favorite associated with that post.
        expect(my_user.favorites.find_by_post_id(my_post.id)).not_to be_nil
      end
    end

    describe 'DELETE destroy' do
      it 'redirects to the posts show view' do
        favorite = my_user.favorites.where(post: my_post).create
        delete :destroy, { post_id: my_post.id, id: favorite.id }
        expect(response).to redirect_to([my_topic, my_post])
      end

      it 'destroys the favorite for the current user and specified post' do
        #create the favorited post
        favorite = my_user.favorites.where(post: my_post).create
        #expect the favorite attribute to not be nil (e.g. to be favorited)
        expect(my_user.favorites.find_by_post_id(my_post.id)).not_to be_nil
        # unfavorite the post
        delete :destroy, { post_id: my_post.id, id: favorite.id }
        # expect the user will not have a favorited post.
        expect(my_user.favorites.find_by_post_id(my_post.id)).to be_nil
      end
    end

  end

end
