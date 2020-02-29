require "csv"

namespace :db do

  desc "TODO"
  task add_time_slots: :environment do
    TimeSlot.delete_all
    TimeSlot.create(start_time: "14:30", end_time: "15:40")
    TimeSlot.create(start_time: "15:45", end_time: "16:55")
    TimeSlot.create(start_time: "17:00", end_time: "18:10")
    TimeSlot.create(start_time: "18:15", end_time: "19:25")
    TimeSlot.create(start_time: "19:30", end_time: "20:40")
    TimeSlot.create(start_time: "20:45", end_time: "21:55")
    TimeSlot.create(start_time: "22:00", end_time: "23:10")
    TimeSlot.create(start_time: "14:15", end_time: "15:25")
    TimeSlot.create(start_time: "15:30", end_time: "16:40")
    TimeSlot.create(start_time: "16:45", end_time: "17:55")
    TimeSlot.create(start_time: "18:00", end_time: "19:10")
    TimeSlot.create(start_time: "19:15", end_time: "20:25")
    TimeSlot.create(start_time: "20:30", end_time: "21:40")
    TimeSlot.create(start_time: "21:45", end_time: "22:55")
  end

  desc "TODO"
  task add_timetables: :environment do
    School.delete_all
    Studio.delete_all
    Timetable.delete_all
    # 立川
    school = School.create!(name: "立川校",
                            zip: "190-0022",
                            address: "東京都立川市錦町２−２−５　アオイビル２Ｆ",
                            phone: "042-523-4940",
                            open_date: "2005-01-01")
    studio = school.studios.create!(name: "(なし)", open_date: "2005-01-01")
    for cwday in 1..7
      ["14:30","15:45","17:00","18:15","19:30","20:45","22:00",].each do |time|
        studio.timetables.create(weekday: cwday, time_slot_id: TimeSlot.find_by(start_time: time).id)
      end
    end
    # 国分寺
    school = School.create!(name: "国分寺校",
                            zip: "185-0021",
                            address: "東京都国分寺市南町３−２２−３１　島崎ビルＢ１Ｆ",
                            phone: "042-322-9494",
                            open_date: "2008-01-01")
    studio = Studio.create!(name: "Aスタジオ", school_id: school.id, open_date: "2008-01-01")
    for cwday in 1..7
      ["14:30","15:45","17:00","18:15","19:30","20:45","22:00",].each do |time|
        studio.timetables.create(weekday: cwday, time_slot_id: TimeSlot.find_by(start_time: time).id)
      end
    end
    studio = Studio.create!(name: "Bスタジオ", school_id: school.id, open_date: "2013-01-01")
    for cwday in 1..7
      ["14:15","15:30","16:45","18:00","19:15","20:30","21:45",].each do |time|
        studio.timetables.create(weekday: cwday, time_slot_id: TimeSlot.find_by(start_time: time).id)
      end
    end
    #studio = Studio.create!(name: "Cスタジオ", school_id: school.id, open_date: "2013-08-01")
    #for cwday in 1..7
    #  ["14:15","15:30","16:45","18:00","19:15","20:30","21:45",].each do |time|
    #    studio.timetables.create(weekday: cwday, time_slot_id: TimeSlot.find_by(start_time: time).id)
    #  end
    #end
  end

  desc "TODO"
  task add_instructors: :environment do
    Instructor.delete_all
    CSV.foreach(File.join(Rails.root, "lib", "tasks", "instructor.csv")) do |row|
      next if Instructor.find_by(name: row[0])
      phone = "090-"
      phone += rand(9).to_s
      phone += rand(9).to_s
      phone += rand(9).to_s
      phone += rand(9).to_s
      phone += "-"
      phone += rand(9).to_s
      phone += rand(9).to_s
      phone += rand(9).to_s
      phone += rand(9).to_s
      Instructor.create(name: row[0],
                        kana: row[1],
                        team: row[2],
                        phone: phone)
    end
  end

  desc "TODO"
  task add_course_attributes: :environment do
    DanceStyle.delete_all
    CSV.foreach(File.join(Rails.root, "lib", "tasks", "dance_styles.csv")) do |row|
      DanceStyle.create(name: row[0])
    end
    Level.delete_all
    ["初級", "中級", "基礎", "幼児", "小学生", "小学生中級"].each do |name|
      Level.create(name: name)
    end
  end

  desc "TODO"
  task add_courses: :environment do
    weekday_ja = { "月" => 1, "火" => 2, "水" => 3, "木" => 4, "金" => 5, "土" => 6, "日" => 7 }
    # クラス
    Course.destroy_all
    i = 0
    CSV.foreach(File.join(Rails.root, "lib", "tasks", "courses.csv")) do |row|
      puts i += 1
      school = School.find_by(name: row[0])
      if row[1].blank?
        studio = Studio.find_by(school_id: school.id, name: "")
      else
        studio = Studio.find_by(school_id: school.id, name: row[1])
      end
      time_slot = TimeSlot.find_by(start_time: row[3])
      timetable = Timetable.find_by(studio_id: studio.id, weekday: weekday_ja[row[2]], time_slot_id: time_slot.id)
      instructor = Instructor.find_by(name: row[4])
      dance_style = DanceStyle.find_by(name: row[5])
      level = Level.find_by(name: row[6])
      Course.create(timetable_id: timetable.id,
                    instructor_id: instructor.id,
                    dance_style_id: dance_style.id,
                    level_id: level.id,
                    open_date: "2013-08-01")
    end
  end

end
