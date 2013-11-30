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
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
