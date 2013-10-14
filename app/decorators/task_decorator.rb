class TaskDecorator < ApplicationDecorator
  delegate_all

  def name_ja
    { "debit" => "入金", }[model.name]
  end

  def frequency_ja
    { "M" => "月次", }[model.frequency]
  end

  def status_label
    label = "<h3 style=\"margin: 0px; line-height: 0;\">"
    case model.status
    when Task::STATUSES[:NONE]
      label << "<span class=\"label label-default\">未定</span>"
    when Task::STATUSES[:IN_PROCESS]
      label << "<span class=\"label label-info\">仕掛中</span>"
    when Task::STATUSES[:FINISHED]
      label << "<span class=\"label label-success\">完了済</span>"
    end
    label << "</h3>"
    label.html_safe
  end

  def due_date
    #case model.frequency
    #when Task::FREQUENCIES[:ONE_DAY]
    #  model.due_date
    #when Task::FREQUENCIES[:MONTHLY]
    #  model.due_date.try(:strftime, "%Y/%m")
    #end
    model.due_date.try(:strftime, "%Y/%m")
  end

end
