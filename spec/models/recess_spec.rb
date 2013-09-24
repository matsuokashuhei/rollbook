# == Schema Information
#
# Table name: recesses
#
#  id                :integer          not null, primary key
#  members_course_id :integer
#  month             :string(255)
#  status            :string(255)
#  note              :text
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Recess do
  pending "add some examples to (or delete) #{__FILE__}"
end
