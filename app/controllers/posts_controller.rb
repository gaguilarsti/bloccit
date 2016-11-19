class PostsController < ApplicationController
  #we removed the post index route after we nested them under topics.

  def show
    #we find the post that corresponds to the id in the params that was passed to show and assign it to @post.
    @post = Post.find(params[:id])
  end

  def new
    #create an instance variable, then assign it to an empty post returned by Post.new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    #call Post.new to create a new instance of Post.
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @topic = Topic.find(params[:topic_id])

    @post.topic = @topic

    #if successfully save, prompt a message and redirect to the post that was created/saved.

    if @post.save
      #flash has provides a way to pass temporary values between actions.  Any value placed in flash will be available in the next action and then deleted.
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
    #if there was an error in saving, display error message and render the empty new template gain.
      flash.now[:alert] = "There was an error saving the post.  Please try again."
      render :new

    end
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post.  Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    # call destroy on @post.  If that call is successful, then flash the notice.  If not, alert the user and redirect to the show view.
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post.  Please try again."
      render :show
    end

  end

end
