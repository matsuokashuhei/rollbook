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

end