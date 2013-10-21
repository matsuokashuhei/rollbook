module MembersHelper

  def members_link
    link_to t("activerecord.models.member"), members_path
  end

  def member_link(member, disable: false)
    unless disable
      link_to t("activerecord.models.member"), member_path(member)
    else
      link_to t("activerecord.models.member"), nil, class: "disabled"
    end
  end

  def members_name_link(member)
    link_to member.full_name, member_path(member)
  end

  def course_members_link(course, disable: false)
    unless disable
      link_to t("activerecord.models.member"), course_members_path(@course)
    else
      link_to t("activerecord.models.member"), nil, class: "disabled"
    end
  end

  MEMBER_STATUS = Member::STATUS

  def display_gender(gender)
    { "M" => "男", "F" => "女" }[gender]
  end

end
