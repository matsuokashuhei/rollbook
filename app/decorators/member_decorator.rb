class MemberDecorator < ApplicationDecorator
  delegate_all

  def name
    text =  "<ul class='list-unstyled' style='margin-top: 1px; margin-bottom: 1px;'>"
    text += "<li>"
    text += h.content_tag :h5, style: "margin-top: 0px; margin-bottom: 0px;" do
      h.content_tag :small do
        "#{model.last_name_kana}　#{model.first_name_kana}"
      end
    end
    text += "</li>"
    text += "<li>"
    text += h.content_tag :h5, style: "margin-top: 0px; margin-bottom: 0px;" do
      "#{model.last_name}　#{model.first_name}"
    end
    text += "</li>"
    text += "</ul>"
    text.html_safe
    #h.content_tag(:small, "#{model.last_name_kana}　#{model.first_name_kana}") + h.tag(:br) + "#{model.last_name}　#{model.first_name}"
  end

  def name_with_link
    h.link_to h.member_path model do
      self.name
    end
  end

  def bank_status
    if model.bank_account.blank?
      tooltip_options = { toggle: "tooltip", "original-title" => "引落の手続きをしてください。" }
      return h.content_tag :span, class: "badge", style: "background-color: red; font-size: 18px; font-weight: normal;", data: tooltip_options  do
          h.fa_icon "credit-card"
        end
    end
    if model.bank_account.present? && model.bank_account.begin_date.blank?
      tooltip_options = { toggle: "tooltip", "original-title" => "引落の手続きをしてください。" }
      return h.link_to h.bank_account_path(model.bank_account) do
          h.content_tag :span, class: "badge", style: "background-color: red; font-size: 18px; font-weight: normal;", data: tooltip_options  do
            h.fa_icon "credit-card"
          end
        end
    end
  end

  def imperfect
    if model.bank_account.try(:imperfect)
      tooltip_options = { toggle: "tooltip", "original-title" => "口座書類不備" }
      #tooltip_options = { toggle: "tooltip", "original-title" => h.t("activerecord.attributes.bank_account.imperfect") }
      h.link_to h.bank_account_path(model.bank_account) do
        h.content_tag :span, class: "badge", style: "background-color: orange; font-size: 18px; font-weight: normal;", data: tooltip_options  do
          h.fa_icon "warning"
        end
      end
    end
  end

  def gender
    model.gender == "M" ? "男" : "女"
  end

  def age
    return if birth_date.nil?
    today = Date.today.to_s(:number).to_i
    age = (today - birth_date.to_s(:number).to_i) / 10000
    "#{age}才"
  end

  def status
    h.content_tag(:h4, style: "margin: 0px; line-height: 0;") do
      case model.status
      # 体験は設計ミスのため削除する。
      #when Member::STATUSES[:TRIAL]
      #  h.content_tag(:span, "体験", class: "label label-info")
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
