# == Schema Information
#
# Table name: courses
#
#  id             :integer          not null, primary key
#  timetable_id   :integer
#  instructor_id  :integer
#  dance_style_id :integer
#  level_id       :integer
#  age_group_id   :integer
#  open_date      :date
#  close_date     :date
#  note           :text
#  monthly_fee    :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Course do
  pending "add some examples to (or delete) #{__FILE__}"
end
