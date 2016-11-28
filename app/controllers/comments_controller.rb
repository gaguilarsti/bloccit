class CommentsController < ApplicationController
  # require sign_in so that guests aren't able to create comments.
  before_action :require_sign_in

  before_action :authorize_user, only: [:destroy]

  def create
    # find the correct post using post_id and then create a new comment using comment_params. Also assing the cooment's user.
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment saved succesfully."

      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Comment failed to save. Comments must be minimum of 5 characters."
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Comment couldn't be deleted.  Try again."
      redirect_to [@post.topic, @post]
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete this comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end


end
