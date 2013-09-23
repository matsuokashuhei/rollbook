module RecessesHelper

  RECESS_STATUS = {
    "0" => "返金未",
    "1" => "返金済",
    "2" => "返金不要",
  }

  def display_recess_status(status)
    RECESS_STATUS[status]
  end

end
