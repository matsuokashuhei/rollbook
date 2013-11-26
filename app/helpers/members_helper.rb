module MembersHelper

  # パン屑用
  def list_item_to_members(active: false)
    text = t("activerecord.models.member")
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, link_to_members
    end
  end

  def list_item_to_member(member, active: false)
    text = member.full_name
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, link_to_member(member, text: text)
    end
  end

  # タブ用
  def tab_to_member(member, active: false)
    text = t("activerecord.models.member")
    if active
      content_tag :li, class: "active" do
        link_to text, '#members', data: { toggle: "tab" }
      end
    else
      content_tag :li, link_to_member(member)
    end
  end

  def tab_to_members_rolls(member, active: false)
    text = t("activerecord.models.roll")
    if active
      content_tag :li, class: "active" do
        link_to text, "#members_rolls", data: { toggle: "tab" }
      end
    else
      content_tag :li, link_to_members_rolls(member)
    end
  end

  def link_to_members
    link_to t("activerecord.models.member"), members_path
  end

  def link_to_member(member, text: t("activerecord.models.member"), active: false)
    link_to text, member_path(member)
  end

  def link_to_members_rolls(member)
    link_to t("activerecord.models.roll"), member_rolls_path(member)
  end

  def course_members_link(course, disable: false)
    unless disable
      link_to t("activerecord.models.member"), course_members_path(@course)
    else
      link_to t("activerecord.models.member"), nil, class: "disabled"
    end
  end

  # セレクトボックス
  def options_of_member_status
    [["体験", "0"], ["入会", "1"], ["退会", "2"]]
  end

  MEMBER_STATUS = Member::STATUS

  def display_gender(gender)
    { "M" => "男", "F" => "女" }[gender]
  end

end
