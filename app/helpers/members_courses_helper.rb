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

  def min_begin_date(enter_date, cwday)
    return if cwday.blank?
    if enter_date.cwday <= cwday
      return enter_date + (cwday - enter_date.cwday).day
    else
      return enter_date + (7 - enter_date.cwday).day + cwday.day
    end
  end
end
