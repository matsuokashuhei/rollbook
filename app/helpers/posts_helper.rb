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
end
