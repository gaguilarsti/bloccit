class TopicsController < ApplicationController
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
    @topic = Topic.new
    @topic.name = params[:topic][:name]
    @topic.description = params[:topic][:description]
    @topic.public = params[:topic][:public]

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

    @topic.name = params[:topic][:name]
    @topic.description = params[:topic][:description]
    @topic.public = params[:topic][:public]

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

end
