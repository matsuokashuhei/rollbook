module DebitsHelper

  def list_item_to_debits(tuition, active: false)
    text = tuition.month_ja
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, link_to_debits(tuition)
    end
  end

  private

  def link_to_debits(tuition)
    link_to tuition.month_ja, tuition_debits_path(tuition)
  end

end
