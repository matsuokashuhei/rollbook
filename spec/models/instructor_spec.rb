# == Schema Information
#
# Table name: instructors
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  kana         :string(255)
#  team         :string(255)
#  phone        :string(255)
#  email_pc     :string(255)
#  email_mobile :string(255)
#  note         :text
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Instructor do
  pending "add some examples to (or delete) #{__FILE__}"
end
