class MemberDecorator < ApplicationDecorator
  delegate_all

  def name
    h.content_tag(:small, "#{model.last_name_kana}　#{model.first_name_kana}") + h.tag(:br) + "#{model.last_name}　#{model.first_name}"
  end

  def tuition
    if model.receipts.unpaid.count > 0
      h.link_to h.member_receipts_path(model) do
      h.content_tag(:span, class: "badge", style: "background-color: red; font-size: 18px; font-weight: normal;") do
        #'(╬ ಠ益ಠ)'
        h.fa_icon "warning"
      end
      end
    end
  end

  def gender
    model.gender == "M" ? "男" : "女"
  end

  def status
    h.content_tag(:h3, style: "margin: 0px; line-height: 0;") do
      case model.status
      when Member::STATUSES[:TRIAL]
        h.content_tag(:span, "体験", class: "label label-info")
      when Member::STATUSES[:ADMISSION]
        h.content_tag(:span, "入会", class: "label label-success")
      when Member::STATUSES[:SECESSION]
        h.content_tag(:span, "退会", class: "label label-default")
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
