module MembersCoursesHelper

  # パン屑用
  def list_item_to_members_courses(member, active: false)
    text = t("activerecord.models.members_course")
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, link_to_members_courses(member)
    end
  end

  # タブ用
  def tab_to_members_courses(member, active: false)
    text = t("activerecord.models.members_course")
    if active
      content_tag :li, class: "active" do
        link_to text, '#members_courses', data: { toggle: "tab" }
      end
    else
      content_tag :li, link_to_members_courses(member)
    end
  end

  private

  def link_to_members_courses(member)
    link_to t("activerecord.models.members_course"), member_courses_path(member)
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
