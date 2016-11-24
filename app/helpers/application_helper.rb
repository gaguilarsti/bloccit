module ApplicationHelper
  #we define a method that takes two arguments.  1. an array of erros and 2. a block.  The & turns the block into a Proc, which can be reused like a variable.
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?

    # content_tag helper method is called.  Used to build the HTML and CSS to display the form element and any associated errors.
    content_tag :div, capture(&block), class: css_class
  end

  #assignment 26
  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.ping?s=48"
  end
end
