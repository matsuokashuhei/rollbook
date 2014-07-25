class MembersCourseValidator < ActiveModel::Validator
  
  def validate(members_course)
    # 開始日
    begin_date_is_future_than_enter_date(members_course)
    begin_date_is_future_than_open_date(members_course)
    begin_date_is_courses_day_of_week(members_course)
    # 終了日
    end_date_is_end_of_month(members_course)
    end_date_is_future_than_begin_date(members_course)
    have_no_recesses(members_course)
  end
  
  def begin_date_is_future_than_enter_date(members_course)
    return if members_course.begin_date.blank?
    return if members_course.course_id.blank?
    unless members_course.begin_date >= members_course.member.enter_date
      members_course.errors.add(:begin_date, "は入会日より未来の日にしてください。")
    end
  end

  def begin_date_is_future_than_open_date(members_course)
    return if members_course.begin_date.blank?
    return if members_course.course_id.blank?
    unless members_course.begin_date >= members_course.course.open_date
      members_course.errors.add(:begin_date, "はクラスの開始日より未来の日にしてください。")
    end
  end

  def begin_date_is_courses_day_of_week(members_course)
    return if members_course.begin_date.blank?
    return if members_course.course_id.blank?
    unless members_course.begin_date.cwday == members_course.course.timetable.weekday
      members_course.errors.add(:begin_date, "はクラスと同じ曜日の日にしてください。")
    end
  end

  def end_date_is_end_of_month(members_course)
    return if members_course.end_date.blank?
    unless members_course.end_date == members_course.end_date.end_of_month
      members_course.errors.add(:end_date, "は月の終わりの日にしてください。")
    end
  end

  def end_date_is_future_than_begin_date(members_course)
    return if members_course.end_date.blank?
    unless members_course.end_date > members_course.begin_date
      members_course.errors.add(:end_date, "は開始日より未来の日にしてください。")
    end
  end

  def have_no_recesses(members_course)
    return if members_course.end_date.blank?
    return if members_course.course_id.blank?
    members_course.recesses.each do |recess|
      if recess.month > members_course.end_date.strftime("%Y/%m")
        members_course.errors.add(:base, "クラスを退会する場合は%sの休会を取り消ししてください。" % recess.decorate.month)
      end
    end
  end

end