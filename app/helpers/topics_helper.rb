module TopicsHelper
  #helper to make so that only signed in users and that they are admins can view the create new topic button
  def user_is_authorized_for_topics?
    current_user && current_user.admin?
  end
end
