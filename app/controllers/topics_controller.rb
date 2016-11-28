class TopicsController < ApplicationController
  # use before_action filter and teh require_sign_in method from ApplicationController to redirect guest user who attempt to access controller actions other than index or show.
  before_action :require_sign_in, except: [:index, :show]

  # use before_action to check the role of signed-in users.  If the current user isn't an admin, we'll redirect them to topics index view.
  before_action :authorize_user, except: [:index, :show]


  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    # replaced with a mass assignment call.
    # @topic = Topic.new
    # @topic.name = params[:topic][:name]
    # @topic.description = params[:topic][:description]
    # @topic.public = params[:topic][:public]

    #mass assignment call
    @topic = Topic.new(topic_params)

    if @topic.save
       redirect_to @topic, notice: "Topic was saved succesfully."
     else
       flash.now[:alert] = "There was an error creating the topic.  Please try again."
       render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update

    @topic = Topic.find(params[:id])

    # replaced with mass assignment call.
    # @topic.name = params[:topic][:name]
    # @topic.description = params[:topic][:description]
    # @topic.public = params[:topic][:public]

    # mass assignment call
    @topic.assign_attributes(topic_params)

    if @topic.save
       redirect_to @topic, notice: "Topic was updated."
     else
       flash.now[:alert] = "There was an error updating the topic.  Please try again."
       render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      redirect_to topics_path, notice: "\"#{@topic.name}\" was deleted successfully."
    else
      flash.now[:alert] = "There was an error deleting the topic.  Please try again."
      render :show
    end
  end

  #PRIVATE MASS ASSINGMENT METHOD
  private

  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

  # define authorize_user, which is used above to redirect non-admins to topics_path (topics index view)
  def authorize_user
    unless current_user.admin? || current_user.moderator?
      flash[:alert] = "You must be an admin to do that, sorry!"
      redirect_to topics_path
    end
  end

end
