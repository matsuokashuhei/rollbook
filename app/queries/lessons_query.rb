class LessonsQuery

  # レッスン
  def self.find_lessons(school_id = nil, date)
    if school_id.present?
      courses = Course.active(date).details
        .merge(Timetable.weekday(date.cwday))
        .where(schools: { id: school_id })
        .merge(TimeSlot.order(:start_time)).merge(School.order(:open_date)).merge(Studio.order(:open_date))
    else
      courses = Course.active(date).details
        .merge(Timetable.weekday(date.cwday))
        .merge(TimeSlot.order(:start_time)).merge(School.order(:open_date)).merge(Studio.order(:open_date))
    end
  end

end
