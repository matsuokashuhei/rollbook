# 時間枠
[
  { start_time: '14:15:00', end_time: '15:25:00' },
  { start_time: '15:30:00', end_time: '16:40:00' },
  { start_time: '16:45:00', end_time: '17:55:00' },
  { start_time: '18:00:00', end_time: '19:10:00' },
  { start_time: '19:15:00', end_time: '20:25:00' },
  { start_time: '20:30:00', end_time: '21:40:00' },
  { start_time: '21:45:00', end_time: '22:55:00' },
  { start_time: '14:30:00', end_time: '15:40:00' },
  { start_time: '15:45:00', end_time: '16:55:00' },
  { start_time: '17:00:00', end_time: '18:10:00' },
  { start_time: '18:15:00', end_time: '19:25:00' },
  { start_time: '19:30:00', end_time: '20:40:00' },
  { start_time: '20:45:00', end_time: '21:55:00' },
  { start_time: '22:00:00', end_time: '23:10:00' },
].each do |time|
  TimeSlot.create time
end

# 立川
school = School.create(
  name: '立川校',
  open_date: Date.new(2005, 1, 1)
)
studio = school.studios.create(
  name: '立川スタジオ',
  open_date: Date.new(2005, 1, 1)
)
1.upto(7) do |i|
  ['14:15', '15:30', '16:45', '18:00', '19:15', '20:30', '21:45'].each do |start_time|
    studio.timetables.create(weekday: i, time_slot: TimeSlot.timing(start_time))
  end
end

# 国分寺
school = School.create(
  name: '国分寺校',
  open_date: Date.new(2008, 1, 1)
)
studio = school.studios.create(
  name: '国分寺Aスタジオ',
  open_date: Date.new(2008, 1, 1)
)
1.upto(7) do |i|
  ['14:15', '15:30', '16:45', '18:00', '19:15', '20:30', '21:45'].each do |start_time|
    studio.timetables.create(weekday: i, time_slot: TimeSlot.timing(start_time))
  end
end
studio = school.studios.create(
  name: '国分寺Bスタジオ',
  open_date: Date.new(2013, 1, 1)
)
1.upto(7) do |i|
  ['14:30', '15:45', '17:00', '18:15', '19:30', '20:45', '22:00'].each do |start_time|
    studio.timetables.create(weekday: i, time_slot: TimeSlot.timing(start_time))
  end
end

# 田無
school = School.create(
  name: '田無校',
  open_date: Date.new(2014, 2, 1)
)
studio = school.studios.create(
  name: '田無スタジオ',
  open_date: Date.new(2014, 2, 1)
)
1.upto(7) do |i|
  ['14:15', '15:30', '16:45', '18:00', '19:15', '20:30', '21:45'].each do |start_time|
    studio.timetables.create(weekday: i, time_slot: TimeSlot.timing(start_time))
  end
end

# 科目の名前・ダンススタイル
[
  'Jr.HIPHOP',
  'HIPHOP',
  'GirlsHIPHOP',
  'R&B',
  'BasicHIPHOP',
  'EXERCISE',
  'KidsHIPHOP',
  'LOCKIN\'',
  'HOUSE',
  'JazzHIPHOP',
  'POP',
  'Jr.ADVANCE',
  'BREAKIN\'',
  'JAZZ',
  'PUNKING',
  'StyleHIPHOP',
  'REGGAE',
  'ReggaeHIPHOP',
  'ANIMATION',
  'JazzFUNK',
].each do |name|
  DanceStyle.create(name: name)
end

# 科目の名前・難易度
[
  '初級',
  '中級',
  '基礎',
  '幼児',
  '小学生',
].each do |name|
  Level.create(name: name)
end

