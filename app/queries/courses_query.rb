class CoursesQuery
  
  # タイムテーブル
  def self.timetables(studio = nil, date = Date.today)
    formatted_date = date.strftime('%Y-%m-%d')
    query = <<-EOS.strip_heredoc
      SELECT
        schools.id AS school_id,
        schools.name AS school_name,
        studios.id AS studio_id,
        studios.name AS studio_name,
        timetables.weekday,
        TO_CHAR(time_slots.start_time, 'HH24:MI') AS start_time,
        TO_CHAr(time_slots.end_time, 'HH24:MI') AS end_time,
        courses.id AS course_id,
        dance_styles.name AS dance_style_name,
        levels.name AS level_name,
        instructors.name AS instructor_name
      FROM
        timetables
        INNER JOIN studios
        ON studios.id = timetables.studio_id
        INNER JOIN schools
        ON schools.id = studios.school_id
        INNER JOIN time_slots
        ON time_slots.id = timetables.time_slot_id
        LEFT OUTER JOIN courses
        ON courses.timetable_id = timetables.id
        LEFT OUTER JOIN dance_styles
        ON dance_styles.id = courses.dance_style_id
        LEFT OUTER JOIN levels
        ON levels.id = courses.level_id
        LEFT OUTER JOIN instructors
        ON instructors.id = courses.instructor_id
    EOS
    if studio.present?
      query += <<-EOS.strip_heredoc
        WHERE
          studios.id = \'#{studio.id}\'
          AND COALESCE(courses.open_date, \'#{formatted_date}\') <= \'#{formatted_date}\'
          AND COALESCE(courses.close_date, '9999-12-31') >= \'#{formatted_date}\'
      EOS
    else
      query += <<-EOS.strip_heredoc
        WHERE
          COALESCE(courses.open_date, \'#{formatted_date}\') <= \'#{formatted_date}\'
          AND COALESCE(courses.close_date, '9999-12-31') >= \'#{formatted_date}\'
      EOS
    end
    query += <<-EOS.strip_heredoc
      ORDER BY
        schools.open_date,
        studios.open_date,
        time_slots.start_time,
        timetables.weekday
    EOS
    ActiveRecord::Base.connection.execute(query)
  end
  
  def self.course(course_id)
    query = <<-EOS.strip_heredoc
      SELECT
        schools.id AS school_id,
        schools.name AS school_name,
        studios.id AS studio_id,
        studios.name AS studio_name,
        timetables.weekday,
        TO_CHAR(time_slots.start_time, 'HH24:MI') AS start_time,
        TO_CHAr(time_slots.end_time, 'HH24:MI') AS end_time,
        courses.id AS course_id,
        dance_styles.name AS dance_style_name,
        levels.name AS level_name,
        instructors.name AS instructor_name
      FROM
        timetables
        INNER JOIN studios
        ON studios.id = timetables.studio_id
        INNER JOIN schools
        ON schools.id = studios.school_id
        INNER JOIN time_slots
        ON time_slots.id = timetables.time_slot_id
        LEFT OUTER JOIN courses
        ON courses.timetable_id = timetables.id
        LEFT OUTER JOIN dance_styles
        ON dance_styles.id = courses.dance_style_id
        LEFT OUTER JOIN levels
        ON levels.id = courses.level_id
        LEFT OUTER JOIN instructors
        ON instructors.id = courses.instructor_id
      WHERE
        courses.id = \'#{course_id}\'
      ORDER BY
        schools.open_date,
        studios.open_date,
        time_slots.start_time,
        timetables.weekday
    EOS
    ActiveRecord::Base.connection.execute(query).first
  end
end