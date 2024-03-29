class PostDecorator < ApplicationDecorator
  delegate_all
  decorates_association :comment

  def edit_if_authorized
    if self.user == h.current_user || h.current_user.admin? 
      h.link_to h.t(:edit), h.edit_post_path(self), class:"btn btn-warning"
    end
  end

  def delete_if_authorized
    if self.user == h.current_user || h.current_user.admin? 
      h.button_to h.t(:destroy_post), @post, method: :delete, class:"btn btn-danger"
    end
  end

  def post_like_counter 
    str = self.likes.count == 1 ? " like" : " likes" 
    self.likes.count.to_s + str
  end


  def pre_like
    self.likes.find {|like| like.user_id == h.current_user.id}
  end

  def like_dislike 
    if pre_like 
      h.button_to "Unlike", h.post_like_path(post, pre_like), method: :delete
    else 
      h.button_to "Like", h.post_likes_path(post), method: :post 
    end 
  end

  # def is_approved?
  #   if post.approved
  #     h.render  "comments/show", post: post
  #   end 
  # end

  # def approve_post
  #   if post.approve
  #     h.link_to, h.posts_path, class: "btn btn-success btn-block btn-lg gradient-custom-4 text-body"
  #   elsif current_user.admin?
  #     h.link_to , h.approve_post_path(post), data: { turbo_method: :post }, class: "btn btn-success btn-block btn-lg gradient-custom-4 text-body"
  #   else 
  #     return
  #   end
  # end
end