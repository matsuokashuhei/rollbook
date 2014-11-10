class DashboardsController < ApplicationController

  def index
    @members_chart = members_chart
    @members_courses_chart = members_courses_chart
    @recesses_chart = recesses_chart
  end
  
  private
  
  def members_chart
    result = StatisticsQuery.monthly_active_members
    source = to_chart_source(result)
    members_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.xAxis(categories: source[:months])
      f.yAxis([{ title: { text: "" }, min: 0, }, { title: { text: "", }, min: 0, opposite: true }, ])
      f.tooltip(value_suffix: '人')
      f.series(name: "入会", yAxis: 0, type: "column", data: source[:monthly_increase])
      f.series(name: "退会", yAxis: 0, type: "column", data: source[:monthly_decrease])
      f.series(name: "在籍", yAxis: 1, type: "line", data: source[:total_changes])
    end
  end

  def members_courses_chart
    sum = nil
    members_courses_chart = LazyHighCharts::HighChart.new('graph') do |f|
      School.order(:open_date).each do |school|
        # 検索する。
        result = StatisticsQuery.monthly_active_members_courses(school_id: school.id)
        # 検索結果をチャート用に加工する。  
        source = to_chart_source(result)
        # チャートに渡す。  
        f.xAxis(categories: source[:months])
        f.yAxis([{ title: { text: "" }, min: 0, }, { title: { text: "", }, min: 0, opposite: true }, ])
        f.tooltip(value_suffix: 'クラス')
        f.series(name: school.name, yAxis: 0, type: "column", data: source[:total_changes])
        if sum.blank?
          sum = source[:total_changes]
        else
          sum = [sum, source[:total_changes]].transpose.map {|num| num.inject(&:+) }
        end
      end
      f.series(name: '合計', yAxis: 1, type: "line", data: sum)
    end
  end
  
  
  def recesses_chart
    sum_members_courses = nil
    sum_recesses = nil
    members_courses_chart = LazyHighCharts::HighChart.new('graph') do |f|
      School.order(:open_date).each_with_index do |school, i|
        # 検索する。
        result = StatisticsQuery.monthly_active_members_courses(school_id: school.id)
        # 検索結果をチャート用に加工する。  
        source = to_chart_source(result)
        active_members_courses = [source[:total_changes], source[:monthly_recesses]].transpose.map {|num| num.inject(&:+) }
        recess_rate = [source[:monthly_recesses], active_members_courses].transpose.map {|num| ((num[0].to_f / num[1].to_f) * 100).round(1) }
        # チャートに渡す。  
        f.xAxis(categories: source[:months])
        f.yAxis({ title: { text: "" }, min: 0, max: 50 })
        f.tooltip(value_suffix: '%')
        f.series(name: school.name, yAxis: 0, type: "column", data: recess_rate)
        
        if i == 0
          sum_members_courses = active_members_courses
          sum_recesses = source[:monthly_recesses]
        else
          sum_members_courses = [sum_members_courses, active_members_courses].transpose.map {|num| num.inject(&:+) }
          sum_recesses = [sum_recesses, source[:monthly_recesses]].transpose.map {|num| num.inject(&:+) }
        end
      end
      sum_recess_rate = [sum_recesses, sum_members_courses].transpose.map {|num| ((num[0].to_f / num[1].to_f) * 100).round(1) }
      f.series(name: '合計', yAxis: 0, type: "line", data: sum_recess_rate)
    end
  end

  def to_chart_source(result)
    # 月
    months = result.map {|row| "#{row['month'][0, 4]}/#{row['month'][4, 2]}" }
    # 月別数
    monthly_increase = result.map {|row| row["monthly_increase"].to_i }
    monthly_decrease = result.map {|row| row["monthly_decrease"].to_i }
    monthly_recesses = result.map {|row| row["monthly_recesses"].to_i }
    # 累積数
    total_increase = result.map {|row| row["total_increase"].to_i }
    total_decrease = result.map {|row| row["total_decrease"].to_i }
    total_changes = [total_increase, total_decrease].transpose.map {|num| num.inject(&:-) }
    if monthly_recesses.present?
      total_changes = [total_changes, monthly_recesses].transpose.map {|num| num.inject(&:-) }
    end
    {
      months: months,
      monthly_increase: monthly_increase,
      monthly_decrease: monthly_decrease,
      monthly_recesses: monthly_recesses,
      total_changes: total_changes
    }
  end

end
