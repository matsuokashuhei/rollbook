module StatisticsHelper

  def business_year date
    case date.month
    when 1..3
      date.year - 1
    else
      date.year
    end
  end

end
