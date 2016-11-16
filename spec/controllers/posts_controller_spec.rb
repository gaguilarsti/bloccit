require 'rails_helper'

#RSpec created a test for this controller.  type: tells RSpec to treat the test as a controller test.
RSpec.describe PostsController, type: :controller do
  #create a new post and assign random data values
  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET #index" do
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

  describe "GET #show" do
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
  describe "GET #new" do
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

  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
