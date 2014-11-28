class MembersCourseCallbacks

  def self.after_update(members_course)
    return if members_course.end_date.blank?
    rolls = Roll.joins(:member, :lesson)
      .where(member_id: members_course.member_id)
      .merge(Lesson.where(course_id: members_course.course_id)
      .date_range(from: members_course.end_date + 1.day))
    rolls.each do |roll|
      roll.destroy
    end
  end

end