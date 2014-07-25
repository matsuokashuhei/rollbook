module RecessesHelper

  RECESS_STATUSES = [
    ["未返金", "0"],
    ["返金済", "1"],
    ["引落前", "3"],
    ["残不", "2"],
  ]

  # タブ用
  def tab_to_members_recesses(member, active: false)
    text = t("activerecord.models.recess")
    if active
      content_tag :li, class: "active" do
        link_to text, '#members_recesses', data: { toggle: "tab" }
      end
    else
      content_tag :li, link_to_members_recesses(member)
    end
  end

  def courses_options_for_select(member)
    members_courses = member.members_courses.details.order(begin_date: :desc)
    options = members_courses.map do |members_course|
        name = members_course.begin_date.strftime('%Y/%m')
        name += '〜'
        name += members_course.end_date.strftime('%Y/%m') if members_course.end_date.present?
        name += '　'
        name += members_course.course.timetable.studio.name
        name += '　'
        name += members_course.course.name
        value = members_course.id
        [name, value]
      end
    options
  end

  private

  def link_to_members_recesses(member)
    link_to t("activerecord.models.recess"), member_recesses_path(member)
  end

end
