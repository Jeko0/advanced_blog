class CommentDecorator < ApplicationDecorator
  delegate_all

  def post_time
    if (self.updated_at - self.created_at) > 1 
      h.t(:edited) + " " + h.time_ago_in_words(comment.updated_at) + " " + h.t(:ago)
    else 
      h.t(:posted) + " " + h.time_ago_in_words(comment.created_at) + " " +h.t(:ago)
    end 
  end
end
