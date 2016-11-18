require 'rails_helper'

#RSpec created a test for this controller.  type: tells RSpec to treat the test as a controller test.
RSpec.describe PostsController, type: :controller do
  #create a new post and assign random data values
  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET index" do
    it "returns http success" do
      #test performs a GET on the index and expects the response to be successful.
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_post] to @posts" do
      get :index
      #because the test creates one post (my_post), we expect index to return an array of one item.
      expect(assigns(:posts)).to eq([my_post])
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: my_post.id}
      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      get :show, {id: my_post.id}

      expect(assigns(:post)).to eq(my_post)
    end
  end

  #when new is invoked a new but unsaved post object is created but not saved.
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    #expect PostsController#new to render the posts new view.
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    #expect @post instance variable to be initialized by PostsController#new.
    #assigns gives us access to the @post variable, assigning it to :post.
    it "instantiates @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end

  describe "POST create" do
    #when create is invoked, the newly created object is in the database.
    #expect that PostsController#create is called with the parameters below and count of Post instances in the db increases by 1.
    it "increases the number of Post by 1" do
      expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
    end

    it "assigns the new post to @post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:post)).to eq Post.last
    end

    #expect to be redirected to the newly created post.
    it "redirects to the new post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to Post.last
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, {id: my_post.id}
      #expect the edit view to render when a post is edited.
      expect(response).to render_template :edit
    end
    #test that edit assigns the correct post to be updated to @post.
    it "assigns post to be updated to @post" do
      get :edit, {id: my_post.id}

      post_instance = assigns(:post)

      expect(post_instance.id).to eq my_post.id
      expect(post_instance.title).to eq my_post.title
      expect(post_instance.body).to eq my_post.body
    end
  end

  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_post.id, post: {title: new_title, body: new_body}
      # test that @post was updated with the title and body passed to update.  Also test that @post's id was not changed.
      updated_post = assigns(:post)
      expect(updated_post.id).to eq my_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      # expect to be redirected to the posts show view after the update.
      put :update, id: my_post.id, post: {title: new_title, body: new_body}
      expect(response).to redirect_to my_post
    end
  end

  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, {id: my_post.id}
      # search the db for a post with an id equal to my_post.id, which returns an array.
      # Assign the size of the array to count and expect count to = 0.
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end

    it "redirects to posts index" do
      delete :destroy, {id: my_post.id}
      # expect to be redirected to the posts index view after a post has been deleted.
      expect(response).to redirect_to posts_path
    end
  end

end
