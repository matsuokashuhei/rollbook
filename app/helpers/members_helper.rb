module MembersHelper

  def members_link
    link_to t("activerecord.models.member"), members_path
  end

  MEMBER_STATUS = Member::STATUS

  def display_gender(gender)
    { "M" => "男", "F" => "女" }[gender]
  end

end
