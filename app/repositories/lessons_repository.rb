class LessonsRepository
  
  def self.create(params)
    lesson = Lesson.find_or_initialize_by(course_id: params[:course_id], date: params[:date])
    if lesson.new_record?
      lesson.status = Lesson::STATUS[:UNFIXED]
      lesson.rolls_status = Lesson::ROLLS_STATUS[:NONE]
      lesson.save
    end
    lesson
  end
end