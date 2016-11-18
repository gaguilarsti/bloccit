require 'rails_helper'
include RandomData

RSpec.describe AdvertisementsController, type: :controller do

  let (:my_ad) { Advertisement.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(1..100)) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_ad] to @advertisement" do
      get :index
      expect(assigns(:advertisements)).to eq([my_ad])
    end

  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_ad.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: my_ad.id}
      expect(response).to render_template :show
    end

    it "assigns my_ad to @advertisement" do
      get :show, {id: my_ad.id}
      expect(assigns(:advertisement)).to eq(my_ad)
    end
  end

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

    #expect @advertisement instance variable to be initialized by PostsController#new.
    #assigns gives us access to the @advertisement variable, assigning it to :ad.
    it "instantiates @advertisement" do
      get :new
      expect(assigns(:advertisement)).not_to be_nil
    end
 end

 describe "POST create" do
   #when create is invoked, the newly created object is in the database.
   #expect that AdvertisementController#create is called with the parameters below and count of Post instances in the db increases by 1.
   it "increases the number of advertisements by 1" do
     expect{post :create, advertisement: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(1..100)}}.to change(Advertisement,:count).by(1)
   end

   it "assigns the new ad to @advertisement" do
     post :create, advertisement: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(1..100)}
     expect(assigns(:advertisement)).to eq Advertisement.last
   end

   #expect to be redirected to the newly created post.
   it "redirects to the new advertisement" do
     post :create, advertisement: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(1..100)}
     expect(response).to redirect_to Advertisement.last
   end
 end

  # describe "GET #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
