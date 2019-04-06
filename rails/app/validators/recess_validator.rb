class RecessValidator < ActiveModel::Validator

  def validate(recess)
    if recess.new_record?
      members_course_is_active(recess)
      within_six_month(recess)
      has_no_rolls(recess)
    end
  end

  def members_course_is_active(recess)
    return if recess.month.blank?
    members_course = recess.members_course
    if recess.month < members_course.begin_date.strftime('%Y%m')
      recess.errors.add(:month, 'は受講クラスに在籍している月にしてください。')
    elsif recess.month > (members_course.end_date.try(:strftime, '%Y%m') || '999912')
      recess.errors.add(:month, 'は受講クラスに在籍している月にしてください。')
    end
  end

  def within_six_month(recess)
    return if recess.month.blank?
    if recess.month > (Date.today + 6.month).strftime('%Y%m')
      recess.errors.add(:month, 'は6ヶ月以内にしてください。')
    end
  end

  def has_no_rolls(recess)
    return if recess.members_course_id
    return if recess.month.blank?
    members_course = recess.members_course
    if Lesson.for_month(recess.month)
      .where(course_id: members_course.course_id)
      .fixed
      .joins(:roll)
      .where(rolls: { member_id: members_course.member_id })
      .where(status: ['1', '2', '4'])
      .exists?.!
      recess.errors.add(:base, 'レッスンを受けているので休会することはできません。')
    end
  end

end
