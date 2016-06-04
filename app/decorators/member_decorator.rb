class MemberDecorator < ApplicationDecorator
  delegate_all
  
  # 会員の名前を「姓 名」という書式で返す。
  def name(delimiter=" ")
    [model.last_name, model.first_name].join(delimiter)
  end

  # 会員の名前を「姓（かな）名（かな）」という書式で返す。
  def kana(delimiter=" ")
    [model.last_name_kana, model.first_name_kana].join(delimiter)
  end

  # 会員の名前を次のような書式で返す。
  # すずき　いちろおう
  # 鈴木　一朗
  def name_and_kana
    h.content_tag(:ul, class: "list-unstyled", style: ["margin-top: 0px;", "margin-bottom: 3px;"].join(" ")) do
      h.concat(
        h.content_tag(:li) do
          h.content_tag(:h5, style: ["margin-top: 0px;", "margin-bottom: 0px;"].join(" ")) do
            h.content_tag(:small, kana)
          end
        end
      )
      h.concat(
        h.content_tag(:li) do
          h.content_tag(:h5, style: ["margin-top: 0px;", "margin-bottom: 0px;"].join(" ")) do
            name
          end
        end
      )
    end
  end

  # name_and_kanaにリンクをつけて返す。
  def name_with_link
    h.link_to h.member_path model do
      name_and_kana
    end
  end

  def bank_status
    bank_account = model.bank_account
    if bank_account.blank?
      style = ["background-color: red", "font-size: 18px", "font-weight: normal"].join("; ")
      tooltip = { toggle: "tooltip", "original-title" => "引落の手続きをしてください。" }
      return h.content_tag(:span, class: "badge", style: style, data: tooltip) do
          h.fa_icon "credit-card"
        end
    end
    if bank_account.imperfect
      style = ["background-color: orange", "font-size: 18px", "font-weight: normal"].join("; ")
      tooltip = { toggle: "tooltip", "original-title" => "書類不備です。" }
      return h.link_to h.bank_account_path(model.bank_account) do
          h.content_tag(:span, class: "badge", style: style, data: tooltip) do
            h.fa_icon "credit-card"
          end
        end
    end
    if bank_account.begin_date.blank?
      style = ["background-color: red", "font-size: 18px", "font-weight: normal"].join("; ")
      tooltip = { toggle: "tooltip", "original-title" => "引落の手続きをしてください。" }
      return h.link_to h.bank_account_path(model.bank_account) do
          h.content_tag(:span, class: "badge", style: style, data: tooltip.merge("original-title" => "引落の手続きをしてください。")) do
            h.fa_icon "credit-card"
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

  def list_item(active:)
    if active
      h.link_to h.t('activerecord.models.member'), '#member', data: { toggle: 'tab' }
    else
      link
    end
  end

  def link(text: h.t('activerecord.models.member'))
    h.link_to text, h.member_path(model)
  end

  def courses_link(text: h.t('activerecord.models.members_course'))
    h.link_to text, h.member_members_courses_path(model, status: '1')
  end

  def rolls_link(text: h.t('activerecord.models.roll'))
    h.link_to text, h.member_rolls_path(model)
  end

  def recesses_link(text: h.t('activerecord.models.recess'))
    h.link_to text, h.member_recesses_path(model)
  end

end
