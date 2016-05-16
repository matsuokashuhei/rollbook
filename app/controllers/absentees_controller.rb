class AbsenteesController < ApplicationController

  def index
    @q = Member.active
               .with_rolls
               .merge(Roll.absences)
               .uniq
               .ransack(params[:q])
    if params[:q].present? || params[:utf8].present?
      @members = @q.result.page(params[:page])
    else
      @members = Member.none
    end
  end

  def show
    @member = Member.find(params[:member_id])
    lessons = Lesson.oldest_absence_per_course(member_id: @member.id)
    @rolls = lessons.map { |lesson| 
        roll = lesson.rolls.where(member_id: @member.id).first
        {
          course_id: lesson.course_id,
          course_name: lesson.course.name,
          lesson_id: roll.lesson_id,
          date: lesson.date,
          roll_id: roll.id,
        }
      }
    logger.debug(@rolls)
  end

end
