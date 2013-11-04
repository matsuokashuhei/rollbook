module UsersHelper

  def list_item_to_users active: false
    text = t "activerecord.models.user"
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, link_to_users
    end
  end

  def list_item_to_user user, active: false
    text = user.name
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, link_to_user(user)
    end
  end

  def users_link
    link_to t("activerecord.models.user"), users_path
  end

  private

  def link_to_users
    link_to t("activerecord.models.user"), users_path
  end

  def link_to_user user
    link_to user.name, user_path(user)
  end

end
