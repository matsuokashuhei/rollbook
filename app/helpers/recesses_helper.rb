module RecessesHelper

  RECESS_STATUS = {
    "0" => "未",
    "1" => "済",
    "2" => "不要",
  }

  def display_recess_status(status)
    RECESS_STATUS[status]
  end

end
