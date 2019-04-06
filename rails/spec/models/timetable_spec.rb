# == Schema Information
#
# Table name: timetables
#
#  id           :integer          not null, primary key
#  studio_id    :integer
#  weekday      :integer
#  time_slot_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Timetable do
  pending "add some examples to (or delete) #{__FILE__}"
end
