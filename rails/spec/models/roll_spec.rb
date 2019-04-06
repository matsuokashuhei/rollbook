# == Schema Information
#
# Table name: rolls
#
#  id                 :integer          not null, primary key
#  lesson_id          :integer
#  member_id          :integer
#  status             :string(255)
#  substitute_roll_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe Roll do
  pending "add some examples to (or delete) #{__FILE__}"
end
