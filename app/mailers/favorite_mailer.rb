class FavoriteMailer < ApplicationMailer
  default from: "gama-aguilar@hotmail.com"

    def new_comment(user, post, comment)

      headers["Message-ID"] = "<comments/#{comment.id}@nameless-wave-47309.herokuapp.com>"
      headers["In-Reply-To"] = "<post/#{post.id}@nameless-wave-47309.herokuapp.com>"
      headers["References"] = "<post/#{post.id}@nameless-wave-47309.herokuapp.com>"

      @user = user
      @post = post
      @comment = comment


      mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_post(post)

    headers["Message-ID"] = "<posts/#{post.id}@nameless-wave-47309.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@nameless-wave-47309.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@nameless-wave-47309.herokuapp.com>"

    @post = post

    mail(to: post.user.email, subject: "#{post.title} created - you'll be notified of new comments")

  end
end
