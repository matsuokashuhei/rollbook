module PostsHelper

  def list_item_to_posts
    content_tag :li, link_to_posts
  end

  def list_item_to_post post, active: false
    if active
      content_tag :li, post.title, class: "active"
    else
      content_tag :li, link_to_post(post)
    end
  end

  def link_to_posts
    link_to t("activerecord.models.post"), posts_path
  end

  def link_to_post post
    link_to post.title, post
  end

  def unread_badge(post, user)
    read_comments_count = user.read_logs.find_by(post_id: post.id).try(:read_comments_count) || 0
    unread_comments_count = post.comments.count - read_comments_count
    if unread_comments_count > 0
      link_to post_comments_path(post, anchor: "comment#{read_comments_count + 1}") do
        content_tag :span, unread_comments_count, class: 'badge alert-info'
      end
    end
  end
end
