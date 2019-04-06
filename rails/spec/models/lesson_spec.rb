# == Schema Information
#
# Table name: lessons
#
#  id           :integer          not null, primary key
#  course_id    :integer
#  date         :date
#  status       :string(255)
#  note         :text
#  created_at   :datetime
#  updated_at   :datetime
#  rolls_status :string(255)
#

require 'spec_helper'

describe Lesson do
  pending "add some examples to (or delete) #{__FILE__}"
end
