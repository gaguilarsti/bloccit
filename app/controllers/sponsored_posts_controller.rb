class SponsoredPostsController < ApplicationController
  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end

  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def create
    @sponsored_post = SponsoredPost.new
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]
    @topic = Topic.find(params[:topic_id])

    @sponsored_post.topic = @topic

    if @sponsored_post.save
      #flash has provides a way to pass temporary values between actions.  Any value placed in flash will be available in the next action and then deleted.
      flash[:notice] = "Sponsored Post was saved."
      redirect_to [@topic, @sponsored_post]
    else
    #if there was an error in saving, display error message and render the empty new template gain.
      flash.now[:alert] = "There was an error saving the sponsored post.  Please try again."
      render :new
    end
  end

  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]

    if @sponsored_post.save
      flash[:notice] = "Sponsored Post was updated."
      redirect_to [@sponsored_post.topic, @sponsored_post]
    else
      flash.now[:alert] = "There was an error saving the sponsored post.  Please try again."
      render :edit
    end
  end

  def destroy
    @sponsored_post = SponsoredPost.find(params[:id])

    # call destroy on @post.  If that call is successful, then flash the notice.  If not, alert the user and redirect to the show view.
    if @sponsored_post.destroy
      flash[:notice] = "\"#{@sponsored_post.title}\" was deleted successfully."
      redirect_to @sponsored_post.topic
    else
      flash.now[:alert] = "There was an error deleting the post.  Please try again."
      render :show
    end

  end

end
