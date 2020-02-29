class BankAccountDecorator < ApplicationDecorator
  delegate_all

  def list_item(active:)
    if active
      h.link_to h.t('activerecord.models.bank_account'), '#bank_account', data: { toggle: 'tab' }
    else
      link
    end
  end

  def link(text: h.t('activerecord.models.bank_account'))
    h.link_to text, h.bank_account_path(model)
  end

  def members_link(text: h.t('activerecord.models.member'))
    h.link_to text, h.bank_account_members_path(model)
  end

  def holder_name
    text =  "<ul class='list-unstyled' style='margin-top: 1px; margin-bottom: 1px;'>"
    text += "<li>"
    text += h.content_tag :h5, style: "margin-top: 0px; margin-bottom: 0px;" do
      h.content_tag :small do
        model.holder_name_kana
      end
    end
    text += "</li>"
    text += "<li>"
    text += h.content_tag :h5, style: "margin-top: 0px; margin-bottom: 0px;" do
      model.holder_name
    end
    text += "</li>"
    text += "</ul>"
    text.html_safe
  end

  def status
    h.content_tag :h4, style: "margin: 0px; line-height: 0;" do
      if model.active?
        h.content_tag(:span, "引落中", class: "label label-success")
      else
        h.content_tag(:span, "手続中", class: "label label-warning")
      end
    end
  end

  def payment_courses
    count = model.payment_courses.count
    if count > 1
      h.link_to h.bank_account_members_path(model) do
        tooltip = { toggle: "tooltip", "original-title" => "#{count}クラス受講会員です。" }
        h.content_tag :span, class: 'badge', style: 'background-color: orange', data: tooltip do
          h.fa_icon 'calendar', text: count
        end
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
