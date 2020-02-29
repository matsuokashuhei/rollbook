class MembersCourseCallbacks

  def self.after_update(members_course)
    return if members_course.end_date.blank?
    rolls = Roll.joins(:member, :lesson)
                .where(member_id: members_course.member_id)
                .where(status: [Roll::STATUS[:NONE],
                                Roll::STATUS[:ATTENDANCE],
                                Roll::STATUS[:ABSENCE],
                                Roll::STATUS[:RECESS],
                                Roll::STATUS[:CANCEL]])
                .merge(Lesson.where(course_id: members_course.course_id)
                .date_range(from: members_course.end_date + 1.day))
    rolls.each do |roll|
      roll.destroy
    end
  end

end
