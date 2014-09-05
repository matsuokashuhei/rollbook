class MemberValidator < ActiveModel::Validator
  
  def validate(member)
    # 入会日
    enter_date_is_future_than_begin_date(member)
    # 退会
    leave_date_is_require_if_leave(member)
    leave_date_is_past_than_enter_date(member)
    members_courses_are_ended(member)  
  end
  
  # 入会日は受講クラスの開始日より過去であること
  def enter_date_is_future_than_begin_date(member)
    return unless member.enter_date.present?
    member.members_courses.each do |members_course|
      unless member.enter_date <= members_course.begin_date
        member.errors.add(:enter_date, "は受講クラスの開始日以前にしてください。")
        return
      end
    end
  end

  # 退会するときは退会日を書くこと。
  def leave_date_is_require_if_leave(member)
    return unless member.status == Member::STATUSES[:SECESSION]
    unless member.leave_date.present?
      member.errors.add(:base, "退会するときは退会日を入れてください。")
      return
    end
  end

  # 退会日は入会日より未来であること。
  def leave_date_is_past_than_enter_date(member)
    return if member.enter_date.blank?
    return if member.leave_date.blank?
    unless member.leave_date >= member.enter_date
      member.errors.add(:leave_date, "は入会日以降にしてください。")
      return
    end
  end
  
  # 退会するときは受講クラスを退会済みであること。
  def members_courses_are_ended(member)
    return if member.leave_date.blank?
    member.members_courses.each do |members_course|
      unless members_course.end_date.present?
        member.errors.add(:base, "退会するときはその前に受講クラスを退会してください。")
        return
      end
      unless member.leave_date >= members_course.end_date
        member.errors.add(:base, "退会日は受講クラスの終了日以降にしてください。")
        return
      end
    end
  end

end