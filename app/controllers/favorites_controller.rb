class FavoritesController < ApplicationController
  #
  before_action :require_sign_in

  def create
    # find the post we want to favorite using post_id in params
    post = Post.find(params[:post_id])
    # create a favorite for the current_user, passing in the post to establish associations for the user, post and favorite.
    favorite = current_user.favorites.build(post: post)

    if favorite.save
      flash[:notice] = "Post favorited."
    else
      flas[:alert] = "Favoriting failed."
    end

    redirect_to [post.topic, post]

  end

  def destroy
    post = Post.find(params[:post_id])
    #find the favorited post by id
    favorite = current_user.favorites.find(params[:id])

    if favorite.destroy
      flash[:notice] = "Post unfavorited."
    else
      flash[:alert] = "Unfavoriting failed."
    end
    redirect_to [post.topic, post]
  end

end
