class Dashboard
  
  attr_reader :months  

  def initialize(months = Rollbook::Util::Month.total_worked_months)
    @months = months
  end
    
  def monthly_tuition_fees_report(school_id:)
    query = <<-EOS.strip_heredoc
      WITH
        #{worked_months_query()},
        members_courses_abbr AS (
          SELECT
            members_courses.id,
            TO_CHAR(members_courses.begin_date, 'YYYYmm') AS begin_month,
            TO_CHAR(members_courses.end_date, 'YYYYmm') AS end_month,
            CASE
              WHEN to_char(members_courses.begin_date, 'dd') <= '07' THEN
                courses.monthly_fee
              WHEN to_char(members_courses.begin_date, 'dd') <= '14' THEN
                round(courses.monthly_fee * 0.75, 0)
              WHEN to_char(members_courses.begin_date, 'dd') <= '21' THEN
                round(courses.monthly_fee * 0.50, 0)
              WHEN to_char(members_courses.begin_date, 'dd') <= '28' THEN
                round(courses.monthly_fee * 0.25, 0)
              ELSE
                0
            END AS tuition_fee
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
        )
      SELECT
        month,
        (SELECT
           SUM(tuition_fee)
         FROM
           members_courses_abbr
         WHERE
           begin_month <= worked_months.month
           AND (end_month IS NULL OR end_month > worked_months.month)
        ) AS tuition_fee
      FROM
        worked_months
      ORDER BY
        month
    EOS
    ActiveRecord::Base.connection.execute(query)
  end

  private
  
    def worked_months_query
      <<-EOS.strip_heredoc
        RECURSIVE tmp(timestamp) AS (
          SELECT TO_TIMESTAMP(\'#{@months.first}01 000000\', 'YYYYMMDD HH24MISS') AS timestamp
          UNION ALL
          SELECT tmp.timestamp + '1 months' FROM tmp WHERE TO_CHAR(tmp.timestamp, 'YYYYMM') < \'#{@months.last}\'
        ),
        worked_months AS (
          SELECT
            TO_CHAR(timestamp, 'YYYYMM') AS month
          FROM
            tmp
        )
      EOS
    end

end