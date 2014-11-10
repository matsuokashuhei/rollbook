class StatisticsQuery

  @@begin_month = '201306'

  def self.monthly_active_members
    end_month = Date.today.strftime('%Y%m')
    query = <<-EOS.strip_heredoc
      WITH
        #{month_period_query(month_from: @@begin_month, month_to: end_month)},
        members_abbr AS (
          SELECT
            id,
            TO_CHAR(enter_date, 'YYYYMM') AS enter_month,
            TO_CHAR(leave_date, 'YYYYMM') AS leave_month
          FROM
            members
        )
      SELECT
        month,
        (SELECT COUNT(*) FROM members_abbr WHERE enter_month = month_period.month) AS monthly_increase,
        (SELECT COUNT(*) FROM members_abbr WHERE enter_month <= month_period.month) AS total_increase,
        (SELECT COUNT(*) FROM members_abbr WHERE leave_month = month_period.month) AS monthly_decrease,
        (SELECT COUNT(*) FROM members_abbr WHERE leave_month < month_period.month) AS total_decrease
      FROM
        month_period
      ORDER BY
        month
    EOS
    ActiveRecord::Base.connection.execute(query)
  end
  
  def self.monthly_active_members_courses(school_id: )
    end_month = Date.today.strftime('%Y%m')
    query = <<-EOS.strip_heredoc
      WITH
        #{month_period_query(month_from: @@begin_month, month_to: end_month)},
        members_courses_abbr AS (
          SELECT
             members_courses.id,
             TO_CHAR(members_courses.begin_date, 'YYYYmm') AS begin_month,
             TO_CHAR(members_courses.end_date, 'YYYYmm') AS end_month
          FROM
            members_courses
          INNER JOIN courses
            ON members_courses.course_id = courses.id
          INNER JOIN timetables
            ON courses.timetable_id = timetables.id
          INNER JOIN studios
            ON timetables.studio_id = studios.id
          INNER JOIN schools
            ON studios.school_id = schools.id
          WHERE
            schools.id = #{school_id}
        ),
        studios_recesses AS (
          SELECT
            *
          FROM
            recesses
          INNER JOIN members_courses_abbr
            ON recesses.members_course_id = members_courses_abbr.id
        )
      SELECT
        month,
        (SELECT COUNT(*) FROM members_courses_abbr WHERE begin_month = month_period.month) AS monthly_increase,
        (SELECT COUNT(*) FROM members_courses_abbr WHERE begin_month <= month_period.month) AS total_increase,
        (SELECT COUNT(*) FROM studios_recesses WHERE month = month_period.month) AS monthly_recesses,
        (SELECT COUNT(*) FROM members_courses_abbr WHERE end_month = month_period.month) AS monthly_decrease,
        (SELECT COUNT(*) FROM members_courses_abbr WHERE end_month < month_period.month) AS total_decrease
      FROM
        month_period
      ORDER BY
        month
    EOS
    ActiveRecord::Base.connection.execute(query)
  end

  private
  
  def self.month_period_query(month_from: '201306', month_to: Date.today.strftime('%Y%m'))
    query = <<-EOS.strip_heredoc
      RECURSIVE tmp(timestamp) AS (
        SELECT TO_TIMESTAMP(\'#{month_from}01 000000\', 'YYYYMMDD HH24MISS') AS timestamp
        UNION ALL
        SELECT tmp.timestamp + '1 months' FROM tmp WHERE TO_CHAR(tmp.timestamp, 'YYYYMM') < \'#{month_to}\'
      ),
      month_period AS (
        SELECT
          TO_CHAR(timestamp, 'YYYYMM') AS month
        FROM
          tmp
      )
    EOS
  end

end
