module UsersHelper

  def users_link
    link_to t("activerecord.models.user"), users_path
  end

end
