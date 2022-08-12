class UserMailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    post = Post.find(post_id)
    mail = UsersMailer.approve_post(post.user_id)
  end
end
