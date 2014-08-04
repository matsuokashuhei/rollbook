class MembersQuery
  
  def initialize(member)
    @member = member
  end

  # 会員の受講クラス
  def find_courses
  end

  # 会員の休会情報
  def find_resecces
    Recess.joins(members_course: :course).where(members_courses: { member_id: @member.id })
  end

  def find_rolls(members_course = nil)
    rolls = Roll.joins(:member, :lesson).where(member_id: @member.id)
    if members_course.present?
      rolls = rolls.merge(Lesson.where(course_id: members_course.course_id).after_date(members_course.begin_date))
    end
    rolls
  end

end