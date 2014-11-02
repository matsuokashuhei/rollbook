class MembersCourseDecorator < ApplicationDecorator
  delegate_all

  def introduction
    if model.introduction
      tooltip_options = { toggle: "tooltip", "original-title" => h.t("activerecord.attributes.members_course.introduction") }
      h.content_tag(:span, class: "badge", style: "background-color: gray; font-size: 18px; font-weight: normal;", data: tooltip_options) do
        "紹"
        #h.fa_icon "meh-o"
      end
    end
  end
  
  def monthly_status(month)
    return '退会' if model.end_date.present? && model.end_date.strftime('%Y%m') < month
    return '休会' if model.in_recess?(month)
    return '受講' if model.begin_date.strftime('%Y%m') < month
    return "#{model.start_week_of_month}週入会"
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
