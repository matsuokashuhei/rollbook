namespace :db do

  task add_tanashi_school: :environment do
    school = School.create!(name: "田無校",
                            open_date: "2014-02-01")

    studio = school.studios.create!(name: "Aスタジオ", open_date: "2014-02-01")
    for cwday in 1..7
      ["14:30","15:45","17:00","18:15","19:30","20:45","22:00",].each do |time|
        studio.timetables.create(weekday: cwday, time_slot_id: TimeSlot.find_by(start_time: time).id)
      end
    end
    studio = school.studios.create!(name: "Bスタジオ", open_date: "2014-02-01")
    for cwday in 1..7
      ["14:30","15:45","17:00","18:15","19:30","20:45","22:00",].each do |time|
        studio.timetables.create(weekday: cwday, time_slot_id: TimeSlot.find_by(start_time: time).id)
      end
    end
  end
end
