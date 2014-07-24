class TimetablesQuery
  
  # タイムテーブル
  def self.timetable(timetable_id)
    Timetable.joins([[studio: :school], :time_slot]).find(timetable_id)
  end
end

