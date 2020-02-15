class PostDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def unread?(user)
    [model.user_id != user.id, user.read_logs.find_by(post_id: model.id).nil?].all?
  end

  def unread_icon(user)
    if unread?(user)
      h.content_tag :span, class: 'label label-success' do
        'NEW'
      end
    end
  end

  def unread_comments_icon(user)
    read_comment_count = user.read_logs.find_by(post_id: model.id).try(:read_comments_count) || 0
    unread_comments_count = model.comments.count - read_comment_count
    if unread_comments_count > 0
      h.link_to h.post_comments_path(post, anchor: "comment#{read_comment_count + 1}") do
        h.content_tag :span, unread_comments_count, class: 'badge alert-info'
      end
    end
  end

end
