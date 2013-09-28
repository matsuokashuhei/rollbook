module MembersCoursesHelper

  def min_begin_date(enter_date, cwday)
    return if cwday.blank?
    if enter_date.cwday < cwday
      return enter_date + (cwday - enter_date.cwday).day
    else
      return enter_date + (7 - enter_date.cwday).day + cwday.day
    end
  end
end
