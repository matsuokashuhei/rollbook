module MembersCoursesHelper

  # タブ用
  def tab_to_members_courses(member, active: false)
    text = t("activerecord.models.members_course")
    if active
      content_tag :li, class: "active" do
        link_to text, '#members_courses', data: { toggle: "tab" }
      end
    else
      content_tag :li, link_to_member_members_courses(member)
    end
  end

  private

  def link_to_member_members_courses(member)
    link_to t("activerecord.models.members_course"), member_members_courses_path(member, status: '1')
  end

end
